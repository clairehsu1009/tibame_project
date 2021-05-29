package com.live.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;
import com.liveBid.websocket.jedis.JedisHandleBid;
import com.liveBid.websocket.model.MaxVO;
import com.liveBid.websocket.model.State;
import com.liveBid.websocket.model.BidVO;

@ServerEndpoint("/TogetherWS/{live_no}/{userName}")
public class TogetherWS {
//	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	private static Map<String, ConcurrentHashMap> sessionsSet = new HashMap<String, ConcurrentHashMap>();

	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("userName") String userName, @PathParam("live_no") String live_no,
			Session userSession) throws IOException {
		ConcurrentHashMap<String, Session> sessionsMap = sessionsSet.get(live_no);
		if(sessionsMap == null) {
			sessionsMap = new ConcurrentHashMap<>();
		}
		/* save the new user in the map */
		sessionsMap.put(userName, userSession);
		sessionsSet.put(live_no, sessionsMap);
		
		/* Sends all the connected users to the new user */
		Set<String> userNames = sessionsMap.keySet(); 

		State stateMessage = new State("open", userName, userNames);

		String stateMessageJson = gson.toJson(stateMessage);

		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
			
				if (session.isOpen()) {
					session.getAsyncRemote().sendText(stateMessageJson);
				}
			
		}

		String text = String.format("Session ID = %s, connected; userName = %s%nusers: %s", userSession.getId(),
				userName, userNames);
		System.out.println(text);
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {
//		message過來
//		1.history 拿最新資料 bidVO =>bidVO
//		2.getMax裡面包max      更新最高價格   bidVO 轉成maxVO 回傳maxVO 
//		3.chat    直接轉交  bidVO =>

		BidVO chatBid = gson.fromJson(message, BidVO.class);

		String live_no = chatBid.getLive_no();
		String type = chatBid.getType();
		String sender = chatBid.getSender();
		String product_no = chatBid.getProduct_no();

		if ("history".equals(type)) {
			// 抓取最高價格MaxVO
			String historyData = JedisHandleBid.getMaxPrice(live_no, product_no);

			// historyData=null要判斷
			if (historyData == null) {
				MaxVO max0 = new MaxVO("bid", sender, live_no, "", "0", product_no, "", "");
				String max0S = gson.toJson(max0);
				BidVO bid = new BidVO("history", sender, live_no, product_no, max0S);
				String currentBid = gson.toJson(bid);
				
					if (userSession != null && userSession.isOpen()) {
						try {
							userSession.getBasicRemote().sendText(currentBid);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						return;
					}
				
			} else {
				if (userSession != null && userSession.isOpen()) {
					BidVO bid = new BidVO("history", sender, live_no, product_no, historyData);
					String currentBid = gson.toJson(bid);
					
						if (userSession != null && userSession.isOpen()) {
							try {
								userSession.getBasicRemote().sendText(currentBid);
							} catch (IOException e) {
								// TODO Auto-generated catch block
								e.printStackTrace();
							}
							return;
						}
					
				}
			}

		} else if ("getMax".equals(type)) {
			ConcurrentHashMap<String, Session> sessionsMap = sessionsSet.get(live_no);
			Set<String> others = sessionsMap.keySet();
			
			// 64有包裝成BIDVO

			MaxVO max = gson.fromJson(chatBid.getMessage(), MaxVO.class);
			String finalMax = null;
			// 我拿到前面傳來的maxJSON
			if (max.getTimeStart().equals("0")) {
				// 直接存進rd
				JedisHandleBid.saveMaxPrice(max.getLive_no(), max.getProduct_no(), chatBid.getMessage());

				finalMax = chatBid.getMessage();
			} else if (max.getTimeStart().equals("1")) {
				// 比較大小 存進rd

				String presentMax = JedisHandleBid.getMaxPrice(max.getLive_no(), max.getProduct_no());
				MaxVO presentMaxVO = gson.fromJson(presentMax, MaxVO.class);
				if (presentMaxVO == null) {// 如果最大值空的

					MaxVO bye = new MaxVO("max", sender, live_no, "", "0", product_no, "3", "");
					finalMax = gson.toJson(bye);
				} else {

					if ((Integer.parseInt(presentMaxVO.getMaxPrice()) < Integer.parseInt(max.getMaxPrice()))) {
						JedisHandleBid.saveMaxPrice(max.getLive_no(), max.getProduct_no(), chatBid.getMessage());
						finalMax = chatBid.getMessage();// 之後上面改寫 這行要移到else以外
					} else {
						max.setMaxPrice(presentMaxVO.getMaxPrice());
						max.setUser_id(presentMaxVO.getUser_id());
						finalMax =  gson.toJson(max);
					}

				}
			} else if (max.getTimeStart().equals("2")) {
				// 不用
				finalMax = chatBid.getMessage();
			}
			for (String other : others) {
				Session receiverSession = sessionsMap.get(other);
				
					if (receiverSession != null && receiverSession.isOpen()) {
						try {
							receiverSession.getBasicRemote().sendText(finalMax);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				
			}

		} else {
			ConcurrentHashMap<String, Session> sessionsMap = sessionsSet.get(live_no);
			Set<String> others = sessionsMap.keySet();

			for (String other : others) {
				Session receiverSession = sessionsMap.get(other);
				
					if (receiverSession != null && receiverSession.isOpen()) {
						try {
							receiverSession.getBasicRemote().sendText(message);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				
			}

		}

	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		
		for(String key :sessionsSet.keySet()) {
			ConcurrentHashMap<String, Session> sessionsMap = sessionsSet.get(key);
			Set<String> userNames = sessionsMap.keySet();
			for(String userName: userNames) {
				Session session = sessionsMap.get(userName);
				if(session == userSession) {
					sessionsMap.remove(userName);
					break;
				}
			}
			
			
			if (userNameClose != null) {
				State stateMessage = new State("close", userNameClose, userNames);
				String stateMessageJson = gson.toJson(stateMessage);
				Collection<Session> sessions = sessionsMap.values();
				for (Session session : sessions) {
					session.getAsyncRemote().sendText(stateMessageJson);
				}
			}

			String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
					reason.getCloseCode().getCode(), userNames);
			System.out.println(text);
		}

	}

}

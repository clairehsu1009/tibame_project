package com.customer_service.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
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

import org.json.JSONException;
import com.customer_service.model.ChatMessage;
import com.customer_service.model.State;
import Jedis.JedisHandleMessage;
import com.google.gson.Gson;

@ServerEndpoint("/CustomerWS/{userNameOrEmpno}")
public class CustomerWS {
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	private static Map<String, Session> sessionsMapForMember = new ConcurrentHashMap<>();
	private static Map<String, Session> sessionsMapForEmp = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("userNameOrEmpno") String userName, Session userSession)
			throws IOException, JSONException {
		
		if (userName.startsWith("14")) {// 員工線上
			System.out.println("empID = " + userSession.getId());
			sessionsMapForEmp.put(userName, userSession);
			Set<String> emps = sessionsMapForEmp.keySet();
			Set<String> memNames = sessionsMapForMember.keySet();
			System.out.println(memNames.size());
			for(String mem : memNames) {
				System.out.println(mem);
			}
			if (memNames.size() > 0) {
				State stateMessage = new State();
				stateMessage.setUsers(memNames);
				stateMessage.setType("memAvailable");
				String stateMessageJson = gson.toJson(stateMessage);
				userSession.getAsyncRemote().sendText(stateMessageJson);
				for(String memName : memNames) {
					Session session = sessionsMapForMember.get(memName);
					State stateMessage1 = new State();
					stateMessage1.setUsers(emps);
					stateMessage1.setType("empAvailable");
					String stateMessageJson1 = gson.toJson(stateMessage1);
					session.getAsyncRemote().sendText(stateMessageJson1);
				}
			}else {
			State stateMessage = new State();
			stateMessage.setUsers(emps);
			stateMessage.setType("empAvailable");
			String stateMessageJson = gson.toJson(stateMessage);
			userSession.getAsyncRemote().sendText(stateMessageJson);
			}
			
		
		} else {
			System.out.println("memID = " + userSession.getId());
			Set<String> memNames = sessionsMapForMember.keySet();
			Set<String> empNames = sessionsMapForEmp.keySet();
System.out.println(empNames.size());
			sessionsMapForMember.put(userName, userSession);
			if (empNames.size() > 0) {
				State stateMessage = new State();
				State stateMessage1 = new State();
				stateMessage.setUsers(memNames);
				stateMessage1.setUsers(empNames);
				stateMessage.setType("onMem");
				stateMessage1.setType("empAvailable");
				String stateMessageJson = gson.toJson(stateMessage);
				String stateMessageJson1 = gson.toJson(stateMessage1);
				for(String emp : empNames) {
					sessionsMapForEmp.get(emp).getAsyncRemote().sendText(stateMessageJson);
				}
				userSession.getAsyncRemote().sendText(stateMessageJson1);
			} else {
				State stateMessage = new State();
				stateMessage.setType("empNotAvailable");
				String stateMessageJson = gson.toJson(stateMessage);
				userSession.getAsyncRemote().sendText(stateMessageJson);
			}
//			empNames = new HashSet<String>();
//			empNames.add(userName);
		}
	}

	@OnMessage
	public void onMessage(Session userSession, String message) {

		ChatMessage chatMessage = gson.fromJson(message, ChatMessage.class);
		String sender = chatMessage.getSender();
		String receiver = chatMessage.getReceiver();

		if ("history".equals(chatMessage.getType())) {
			List<String> historyData = JedisHandleMessage.getHistoryMsg(sender, receiver);
			String historyMsg = gson.toJson(historyData);
			ChatMessage cmHistory = new ChatMessage("history", sender, receiver, historyMsg);
			if (userSession != null && userSession.isOpen()) {
				userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
				System.out.println("history = " + gson.toJson(cmHistory));
				return;
			}
		} else {
			if (sender.startsWith("14")) {
				Session memSession = sessionsMapForMember.get(receiver);
				if (memSession != null && memSession.isOpen()) {
					memSession.getAsyncRemote().sendText(message);
					userSession.getAsyncRemote().sendText(message);
					JedisHandleMessage.saveChatMessage(sender, receiver, message);
				}
			} else {
				Session empSession = sessionsMapForEmp.get(receiver);
				if (empSession != null && empSession.isOpen()) {
					empSession.getAsyncRemote().sendText(message);
					userSession.getAsyncRemote().sendText(message);
					JedisHandleMessage.saveChatMessage(sender, receiver, message);
				}
			}

//		Session receiverSession = sessionsMap.get(receiver);
//		if (receiverSession != null && receiverSession.isOpen()) {
//			receiverSession.getAsyncRemote().sendText(message);
//			userSession.getAsyncRemote().sendText(message);
//			JedisHandleMessage.saveChatMessage(sender, receiver, message);
//		}
		}
		System.out.println("Message received: " + message);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		if (sessionsMapForMember.values().contains(userSession)) { // 使用者離線
			Set<String> userNames = sessionsMapForMember.keySet();
			for (String userName : userNames) {
				if (sessionsMapForMember.get(userName).equals(userSession)) {
					userNameClose = userName;
					sessionsMapForMember.remove(userName);
					break;
				}
			}
		
		if (userNameClose != null) {
			State stateMessage = new State("close", userNameClose, userNames);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> empSessions = sessionsMapForEmp.values();
			for (Session session : empSessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}
		} else { // 會員離線
			Set<String> empNames = sessionsMapForEmp.keySet();
			for (String empno : empNames) {
				if (sessionsMapForEmp.get(empno).equals(userSession)) {
					sessionsMapForEmp.remove(empno);
					break;
				}
			}
		}
		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), userNameClose);
		System.out.println(text);
	}
}

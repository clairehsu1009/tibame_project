package com.message.websocket.controller;

import java.io.IOException;
import java.util.Collection;
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

import com.google.gson.Gson;

import com.message.websocket.jedis.JedisHandleMessage;
import com.message.websocket.model.ChatMessage;
import com.message.websocket.model.State;

@ServerEndpoint("/FriendChatWS/{user_id}")
public class FriendChatWS {
	private static Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();

	@OnOpen
	public void onOpen(@PathParam("user_id") String user_id, Session userSession) throws IOException {
		/* save the new user in the map */
		sessionsMap.put(user_id, userSession);
		/* Sends all the connected users to the new user */
		
		Set<String> onlineUser_ids = sessionsMap.keySet();//線上的使用者
		Set<String> user_ids = JedisHandleMessage.getFriendList(user_id); //偽好友名單
		
		State stateMessage = new State("open", user_id, user_ids, onlineUser_ids);
		
		String stateMessageJson = gson.toJson(stateMessage);
		
		Collection<Session> sessions = sessionsMap.values();
		for (Session session : sessions) {
				if (session.isOpen()) {
					session.getAsyncRemote().sendText(stateMessageJson);
					System.out.println(stateMessageJson);
				}
		}
		
		String text = String.format("Session ID = %s, connected; user_id = %s%nusers: %s", userSession.getId(),
				user_id, user_ids);
		System.out.println(text);
		
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
		}
		
		Session receiverSession = sessionsMap.get(receiver);
		if (receiverSession != null && receiverSession.isOpen()) {
			receiverSession.getAsyncRemote().sendText(message);
			userSession.getAsyncRemote().sendText(message);
			JedisHandleMessage.saveChatMessage(sender, receiver, message);
		}else {
			userSession.getAsyncRemote().sendText(message);
			JedisHandleMessage.saveChatMessage(sender, receiver, message);
		}
		System.out.println("Message received: " + message);
	}

	@OnError
	public void onError(Session userSession, Throwable e) {
		System.out.println("Error: " + e.toString());
	}

	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String user_idClose = null;
		Set<String> offline_users = null;
		Set<String> user_ids = sessionsMap.keySet();
		for (String user_id : user_ids) {
			if (sessionsMap.get(user_id).equals(userSession)) {
				user_idClose = user_id;
				sessionsMap.remove(user_id);
				break;
			}
		}

		if (user_idClose != null) {
			State stateMessage = new State("close", user_idClose, user_ids, offline_users);
			String stateMessageJson = gson.toJson(stateMessage);
			Collection<Session> sessions = sessionsMap.values();
			for (Session session : sessions) {
				session.getAsyncRemote().sendText(stateMessageJson);
			}
		}

		String text = String.format("session ID = %s, disconnected; close code = %d%nusers: %s", userSession.getId(),
				reason.getCloseCode().getCode(), user_ids);
		System.out.println(text);
	}
}

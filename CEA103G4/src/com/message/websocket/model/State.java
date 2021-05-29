package com.message.websocket.model;

import java.util.Set;

public class State {
	private String type;
	// the user changing the state
	private String user;
	// total users
	private Set<String> users;
	// online users
	private Set<String> online_users;

	public State(String type, String user, Set<String> users, Set<String> online_users) {
		super();
		this.type = type;
		this.user = user;
		this.users = users;
		this.online_users = online_users;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Set<String> getUsers() {
		return users;
	}

	public void setUsers(Set<String> users) {
		this.users = users;
	}

	public Set<String> getOnline_users() {
		return online_users;
	}

	public void setOnline_users(Set<String> online_users) {
		this.online_users = online_users;
	}

}

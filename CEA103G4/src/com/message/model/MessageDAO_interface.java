package com.message.model;

import java.util.*;

public interface MessageDAO_interface {
	public void insert(MessageVO messageVO);
	public void update(MessageVO messageVO);
	public void delete(Integer messageVO);
	public MessageVO findByPrimaryKey(Integer messageVO);
	public List<MessageVO> getAll();
	
}
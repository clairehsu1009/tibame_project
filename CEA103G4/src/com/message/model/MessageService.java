package com.message.model;

import java.util.List;

public class MessageService {

	private MessageDAO_interface dao;

	public MessageService() {
		dao = new MessageJNDIDAO();
	}

	public MessageVO addMessage(String user_id, String content,String seller_id, java.sql.Date message_time) {

		MessageVO messageVO = new MessageVO();

		messageVO.setUser_id(user_id);
		messageVO.setContent(content);
		messageVO.setMessage_time(message_time);
		messageVO.setSeller_id(seller_id);
		dao.insert(messageVO);

		return messageVO;
	}

	public MessageVO updateMessage(Integer message_no, String user_id, String content, String seller_id, java.sql.Date message_time) {

		MessageVO messageVO = new MessageVO();

		messageVO.setMessage_no(message_no);
		messageVO.setUser_id(user_id);
		messageVO.setContent(content);
		messageVO.setMessage_time(message_time);
		messageVO.setSeller_id(seller_id);
		
		dao.update(messageVO);
		
		return messageVO;
	}

	public void deleteMessage(Integer message_no) {
		dao.delete(message_no);
	}

	public MessageVO getOneMessage(Integer message_no) {
		return dao.findByPrimaryKey(message_no);
	}

	public List<MessageVO> getAll() {
		return dao.getAll();
	}
}

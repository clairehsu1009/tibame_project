package com.notice.model;

import java.util.List;

public class NoticeService {

	private NoticeDAO_interface dao;

	public NoticeService() {
		dao = new NoticeJNDIDAO();
	}

	public NoticeVO addNotice(String user_id, String noc_content, Integer noc_state) {

		NoticeVO noticeVO = new NoticeVO();

		noticeVO.setUser_id(user_id);
		noticeVO.setNoc_content(noc_content);
		noticeVO.setNoc_state(noc_state);
		dao.insert(noticeVO);

		return noticeVO;
	}

	public NoticeVO updateNotice(Integer notice_no, String user_id, String noc_content, java.sql.Timestamp noc_date,
			Integer noc_state) {

		NoticeVO noticeVO = new NoticeVO();

		noticeVO.setNotice_no(notice_no);
		noticeVO.setUser_id(user_id);
		noticeVO.setNoc_content(noc_content);
		noticeVO.setNoc_date(noc_date);
		noticeVO.setNoc_state(noc_state);
		dao.update(noticeVO);

		return noticeVO;
	}

	public void deleteNotice(Integer notice_no) {
		dao.delete(notice_no);
	}

	public NoticeVO getOneNotice(Integer notice_no) {
		return dao.findByPrimaryKey(notice_no);
	}

	public List<NoticeVO> getAll() {
		return dao.getAll();
	}
}

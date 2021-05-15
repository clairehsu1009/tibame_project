package com.notice.model;

import java.util.List;

public interface NoticeDAO_interface {
	public void insert(NoticeVO noticeVO);
	public void update(NoticeVO noticeVO);
	public void delete(Integer noticeVO);
	public NoticeVO findByPrimaryKey(Integer noticeVO);
	public List<NoticeVO> getAll();
	
}
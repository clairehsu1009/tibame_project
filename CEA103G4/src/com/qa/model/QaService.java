package com.qa.model;

import java.sql.Date;
import java.util.List;

public class QaService {

	private QaDAO_interface dao;

	public QaService() {
		dao = new QaDAO();
	}

	public QaVO addQa(Integer empno, Date qa_date, String qa_content) {

		QaVO qaVO = new QaVO();

		qaVO.setEmpno(empno);
		qaVO.setQa_date(qa_date);
		qaVO.setQa_content(qa_content);
		
		dao.insert(qaVO);

		return qaVO;
	}

	public QaVO updateQa(Integer qa_no, Integer empno, Date qa_date, String qa_content) {
		
		QaVO qaVO = new QaVO();

		qaVO.setQa_no(qa_no);
		qaVO.setEmpno(empno);
		qaVO.setQa_date(qa_date);
		qaVO.setQa_content(qa_content);
		
		dao.update(qaVO);
		
		return qaVO;
	}
	
	public void deleteQa(Integer qa_no) {
		dao.delete(qa_no);
	}

	public QaVO getOneQa(Integer qa_no) {
		return dao.findByPrimaryKey(qa_no);
	}

	public List<QaVO> getAll() {
		return dao.getAll();
	}
}

package com.qa.model;

import java.util.List;

public interface QaDAO_interface {
	public void insert(QaVO qa_no);

	public void update(QaVO qa_no);
	
	public void delete(Integer qa_no);
	
	public QaVO findByPrimaryKey(Integer qa_no);

	public List<QaVO> getAll();
	// 萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}

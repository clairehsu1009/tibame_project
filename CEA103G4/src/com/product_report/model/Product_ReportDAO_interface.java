package com.product_report.model;
import java.util.*;

import com.product_type.model.Product_TypeVO;

public interface Product_ReportDAO_interface {	
	
	public void insert(Product_ReportVO product_reportVO);
    public void update(Product_ReportVO product_reportVO);
    public void delete(Integer pro_report_no);
    public Product_ReportVO findByPrimaryKey(Integer pro_report_no);
    public List<Product_ReportVO> getAll_Report_state();
    public List<Product_ReportVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Product_ReportVO> getAll(Map<String, String[]> map); 
    public Product_ReportVO userProduct_ReportInfo(Integer product_no);

	
	
}

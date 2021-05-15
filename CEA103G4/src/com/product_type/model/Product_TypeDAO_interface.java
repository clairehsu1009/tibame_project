package com.product_type.model;

import java.util.List;
import java.util.Set;

import com.product.model.ProductVO;

public interface Product_TypeDAO_interface {

	public void insert(Product_TypeVO product_typeVO);
    public void update(Product_TypeVO product_typeVO);
    public void delete(Integer pdtype_no);
    public Product_TypeVO findByPrimaryKey(Integer pdtype_no);
    public List<Product_TypeVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<Product_TypeVO> getAll(Map<String, String[]> map); 
	public Set<ProductVO> getProductsByPdtype_no(Integer pdtype_no);

	
}

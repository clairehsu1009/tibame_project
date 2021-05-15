package com.product_type.model;

import java.util.List;
import java.util.Set;

import com.product.model.ProductVO;

public class Product_TypeService {
	private Product_TypeDAO_interface dao;
	
	public Product_TypeService() {
		dao = new Product_TypeDAO();
	}
	
	public Product_TypeVO addProduct_Type(String pdtype_name) {

		Product_TypeVO product_typeVO = new Product_TypeVO();
		
		product_typeVO.setPdtype_name(pdtype_name);
		dao.insert(product_typeVO);

		return product_typeVO;
	}
	
	public Product_TypeVO updateProduct_Type(Integer pdtype_no, String pdtype_name) {

		Product_TypeVO product_typeVO = new Product_TypeVO();

		product_typeVO.setPdtype_no(pdtype_no);
		product_typeVO.setPdtype_name(pdtype_name);
		dao.update(product_typeVO);

		return product_typeVO;
	}

	public void deleteProduct_Type(Integer pdtype_no) {
		dao.delete(pdtype_no);
	}

	public Product_TypeVO getOneProduct_Type(Integer pdtype_no) {
		return dao.findByPrimaryKey(pdtype_no);
	}

	public List<Product_TypeVO> getAll() {
		return dao.getAll();
	}
	
	public Set<ProductVO> getProductsByPdtype_no(Integer pdtype_no) {
		return dao.getProductsByPdtype_no(pdtype_no);
	}
}

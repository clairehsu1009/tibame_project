package com.product.model;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.json.JSONException;
import org.json.JSONObject;



public class ProductService {
	
	private ProductDAO_interface dao;

	public ProductService() {
		dao = new ProductDAO();
	}

	public ProductVO addProduct(String product_name, String product_info, Integer product_price,
			Integer product_remaining, Integer product_state, byte[] product_photo, String user_id,
			Integer pdtype_no) {

		ProductVO productVO = new ProductVO();
		
		productVO.setProduct_name(product_name);
		productVO.setProduct_info(product_info);
		productVO.setProduct_price(product_price);
		productVO.setProduct_remaining(product_remaining);
		productVO.setProduct_state(product_state);
		productVO.setProduct_photo(product_photo);
		productVO.setUser_id(user_id);
		productVO.setPdtype_no(pdtype_no);
		dao.insert(productVO);

		return productVO;
	}

	public ProductVO updateProduct(Integer product_no, String product_name, String product_info, Integer product_price,
			Integer product_remaining, Integer product_state, byte[] product_photo, String user_id,
			Integer pdtype_no) {

		ProductVO productVO = new ProductVO();

		productVO.setProduct_no(product_no);
		productVO.setProduct_name(product_name);
		productVO.setProduct_info(product_info);
		productVO.setProduct_price(product_price);
		productVO.setProduct_remaining(product_remaining);
		productVO.setProduct_state(product_state);
		productVO.setProduct_photo(product_photo);
		productVO.setUser_id(user_id);
		productVO.setPdtype_no(pdtype_no);
		dao.update(productVO);

		return productVO;
	}

	public void deleteProduct(Integer product_no) {
		dao.delete(product_no);
	}

	public ProductVO getOneProduct(Integer product_no) {
		return dao.findByPrimaryKey(product_no);
	}

	public List<ProductVO> getAll() {
		return dao.getAll();
	}
	public Optional<ProductVO> getProductPic(Integer product_no){
		return dao.findProductPic(product_no);
	}
	
	public List<ProductVO> getAllShop() {
		return dao.getAllShop();
	}
	
	public List<ProductVO> getAllShopWithoutPhoto(){
		List<ProductVO> productList = dao.getAllShop();
		for( ProductVO product:productList) {
			product.setProduct_photo(null);
		}
		
		return productList;
	}

	
	public List<ProductVO> getAllShop(Map<String, String[]> map) {
		return dao.getAllShop(map);
	}
	
	public List<ProductVO> getAdvSearchShop(String[] pdtypeNo, String priceType) {
		return dao.getAdvSearchShop(pdtypeNo, priceType);
	}
	
	public List<ProductVO> getMoneyRangeShop(String minPrice, String maxPrice) {
		return dao.getMoneyRangeShop(minPrice, maxPrice);
	}
	
	public ProductVO updateState(Integer product_no, Integer product_state) {

		ProductVO productVO = new ProductVO();

		productVO.setProduct_no(product_no);
		productVO.setProduct_state(product_state);
		dao.updateState(productVO);
		return productVO;
	}
	public ProductVO updateProductRemaining(Integer product_no,Integer product_remaining, Integer product_state) 
	{

		ProductVO productVO = new ProductVO();

		productVO.setProduct_no(product_no);
		productVO.setProduct_remaining(product_remaining);
		productVO.setProduct_state(product_state);
		dao.update_remaining(productVO);

		return productVO;
	}
		
	
	

	public void updateLive(Integer live_no, List<ProductVO> product_no) {
		
		dao.updateStateLive(live_no, product_no);
	}
	
	public void offShelf(List<ProductVO> product_no) {
		
		dao.offShelf(product_no);
	}
	
	public List<ProductVO> getSellerProducts(String user_id) {
		return dao.getSellerProducts(user_id);
	}
	
	public ProductVO getFavorite(Integer product_no) {
		return dao.getFavorite(product_no);
		}
	}





	


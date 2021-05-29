package com.product.model;
import java.util.*;




public interface ProductDAO_interface {
          public void insert(ProductVO productVO);
          public void update(ProductVO productVO);
          public void delete(Integer product_no);
          public ProductVO findByPrimaryKey(Integer product_no);
          Optional<ProductVO> findProductPic(Integer product_no);
          public List<ProductVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<ProductVO> getAll(Map<String, String[]> map); 
          public List<ProductVO> getAllWithoutPhoto();
          public List<ProductVO> getAllShop();
          public List<ProductVO> getAllShop(Map<String, String[]> map);
          public List<ProductVO> getAdvSearchShop(String[] pdtypeNo, String priceType);
          public List<ProductVO> getMoneyRangeShop(String minPrice, String maxPrice);
          public void update_remaining(ProductVO productVO);
          //修改商品庫存、狀態更動
          public void updateState(ProductVO productVO);
          //多個商品設定直播商品並帶入live_no
          public void updateStateLive(Integer live_no,List<ProductVO> list);
          //多個商品下架並清空live_no
          public void offShelf(List<ProductVO> list);
          public List<ProductVO> getSellerProducts(String user_id);
          public ProductVO getFavorite(Integer product_no);
          public void updateState(Integer product_state, List<ProductVO> list);
}

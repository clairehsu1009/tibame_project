package com.live_order_detail.model;

import java.util.List;

public class Live_order_detailService {
	private Live_order_detailDAO_interface dao;

	public Live_order_detailService() {
		dao = new Live_order_detailJNDIDAO();
	}

	public Live_order_detailVO addDetail(Integer live_order_no, Integer product_no, Integer price,
			Integer product_num) {

		Live_order_detailVO live_order_detailVO = new Live_order_detailVO();

		live_order_detailVO.setLive_order_no(live_order_no);
		live_order_detailVO.setProduct_no(product_no);
		live_order_detailVO.setPrice(price);
		live_order_detailVO.setProduct_num(product_num);

		dao.insert(live_order_detailVO);
		return live_order_detailVO;
	}

	public Live_order_detailVO updateDetail(Integer live_order_no, Integer product_no, Integer price,
			Integer product_num) {

		Live_order_detailVO live_order_detailVO = new Live_order_detailVO();

		live_order_detailVO.setLive_order_no(live_order_no);
		live_order_detailVO.setProduct_no(product_no);
		live_order_detailVO.setPrice(price);
		live_order_detailVO.setProduct_num(product_num);

		dao.update(live_order_detailVO);

		return live_order_detailVO;
	}

	public void deleteDetail(Integer live_order_no, Integer product_no) {
		dao.delete(live_order_no, product_no);
	}

	public Live_order_detailVO getOneDetail(Integer live_order_no, Integer product_no) {
		return dao.findByPrimaryKey(live_order_no, product_no);
	}

	public List<Live_order_detailVO> getAll() {
		return dao.getAll();
	}
}

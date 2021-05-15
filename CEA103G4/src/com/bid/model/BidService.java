package com.bid.model;

import java.util.List;

import com.bid.model.BidVO;

public class BidService {
	private BidDAO_interface dao;

	public BidService() {
		dao = new BidJNDIDAO();
	}

	public BidVO addBid(String user_id, Integer product_no, Integer bid_price) {

		BidVO bidVO = new BidVO();

		bidVO.setUser_id(user_id);
		bidVO.setProduct_no(product_no);
		bidVO.setBid_price(bid_price);

		dao.insert(bidVO);

		return bidVO;

	}

	public BidVO updateBid(String user_id, Integer product_no, Integer bid_price, Integer bid_no) {

		BidVO bidVO = new BidVO();

		bidVO.setUser_id(user_id);
		bidVO.setProduct_no(product_no);
		bidVO.setBid_price(bid_price);
		bidVO.setBid_no(bid_no);

		dao.insert(bidVO);

		return bidVO;

	}

	public void deleteBid(Integer bid_no) {
		dao.delete(bid_no);
	}

	public BidVO getOneBid(Integer bid_no) {
		return dao.findByPrimaryKey(bid_no);
	}

	public List<BidVO> getAll() {
		return dao.getAll();
	}
}

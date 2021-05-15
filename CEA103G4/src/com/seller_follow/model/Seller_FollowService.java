package com.seller_follow.model;
import java.util.List;

public class Seller_FollowService {
		
		private Seller_FollowDAO_interface dao;

		public Seller_FollowService() {
			dao = new Seller_FollowDAO();
		}

		public Seller_FollowVO addSeller_Follow(String user_id, String seller_id) {

			Seller_FollowVO seller_followVO = new Seller_FollowVO();
			
			seller_followVO.setUser_id(user_id);
			seller_followVO.setSeller_id(seller_id);
			dao.insert(seller_followVO);

			return seller_followVO;
		}

		public void deleteSeller_Follow(Integer tracer_no) {
			dao.delete(tracer_no);
		}

		public List<Seller_FollowVO> getOneUser(String user_id) {
			return dao.getOneUser(user_id);
		}

		public List<Seller_FollowVO> getAll() {
			return dao.getAll();
		}
		
		public Seller_FollowVO getTracerNo(String user_id, String seller_id) {
			return dao.getTracerNo(user_id,seller_id);
		}
	}


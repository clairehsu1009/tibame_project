package com.ad.model;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

import com.ad.model.AdVO;

public class AdService {

	private AdDAO_interface dao;

	public AdService() {
		dao = new AdDAO();
	}

	public AdVO addAd(Integer empno, String ad_content, byte[] ad_photo, Integer ad_state, Date ad_start_date, Date ad_end_date, String ad_url) {

		AdVO adVO = new AdVO();

		adVO.setEmpno(empno);
		adVO.setAd_content(ad_content);
		adVO.setAd_photo(ad_photo);
		adVO.setAd_state(ad_state);
		adVO.setAd_start_date(ad_start_date);
		adVO.setAd_end_date(ad_end_date);
		adVO.setAd_url(ad_url);
		
		dao.insert(adVO);

		return adVO;
	}

	public AdVO updateAd(Integer ad_no, Integer empno, String ad_content, byte[] ad_photo, Integer ad_state, Date ad_start_date, Date ad_end_date, String ad_url) {
		
		AdVO adVO = new AdVO();

		adVO.setAd_no(ad_no);
		adVO.setEmpno(empno);
		adVO.setAd_content(ad_content);
		adVO.setAd_photo(ad_photo);
		adVO.setAd_state(ad_state);
		adVO.setAd_start_date(ad_start_date);
		adVO.setAd_end_date(ad_end_date);
		adVO.setAd_url(ad_url);
		
		dao.update(adVO);
		
		return adVO;
	}
	
	public void deleteAd(Integer ad_no) {
		dao.delete(ad_no);
	}

	public AdVO getOneAd(Integer ad_no) {
		return dao.findByPrimaryKey(ad_no);
	}

	public List<AdVO> getAll() {
		return dao.getAll();
	}
	
	public Optional<AdVO> getAdPic(Integer ad_no){
		return dao.findAdPic(ad_no);
	}
}

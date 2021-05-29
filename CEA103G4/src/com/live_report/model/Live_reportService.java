package com.live_report.model;

import java.util.List;

public class Live_reportService {
	private Live_reportDAO_interface dao;

	public Live_reportService() {
		dao = new Live_reportJNDIDAO();
	}

	public Live_reportVO addLive_report(String live_report_content, Integer live_no, String user_id, Integer empno,
			Integer live_report_state, byte[] photo) {

		Live_reportVO live_reportVO = new Live_reportVO();

		live_reportVO.setLive_report_content(live_report_content);
		live_reportVO.setLive_no(live_no);
		live_reportVO.setUser_id(user_id);
		live_reportVO.setEmpno(empno);
		live_reportVO.setLive_report_state(live_report_state);
		live_reportVO.setPhoto(photo);

		dao.insert(live_reportVO);

		return live_reportVO;
	}

	public Live_reportVO updateLive_report(Integer live_report_no,Integer live_report_state) {
		Live_reportVO live_reportVO = new Live_reportVO();

		live_reportVO.setLive_report_no(live_report_no);
		live_reportVO.setLive_report_state(live_report_state);

		dao.update(live_reportVO);
		return live_reportVO;
	}

	public void deleteLive_report(Integer live_report_no) {
		dao.delete(live_report_no);
	}

	public Live_reportVO getOneLive_report(Integer live_report_no) {
		return dao.findByPrimaryKey(live_report_no);
	}

	public List<Live_reportVO> getAll() {
		return dao.getAll();
	}
}
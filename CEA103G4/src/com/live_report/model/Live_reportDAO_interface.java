package com.live_report.model;

import java.util.List;

public interface Live_reportDAO_interface {
	public void insert(Live_reportVO live_reportVO);

	public void update(Live_reportVO live_reportVO);

	public void delete(Integer live_report_no);

	public Live_reportVO findByPrimaryKey(Integer live_report_no);

	public List<Live_reportVO> getAll();
}

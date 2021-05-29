package com.live.model;

import java.util.List;

public interface LiveDAO_interface {
	public Integer insert(LiveVO liveVO);

	public void update(LiveVO liveVO);

	public void delete(Integer live_id);

	public LiveVO findByPrimaryKey(Integer live_id);

	public List<LiveVO> getAll();
	
	public List<LiveVO> getAll2();
	
	public List<LiveVO> getAllByID(String user_id);
	
	public void over(Integer live_id);
}

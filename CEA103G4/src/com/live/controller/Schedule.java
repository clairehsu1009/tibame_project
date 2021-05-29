package com.live.controller;

import java.util.*;

import com.live.model.LiveService;
import com.live.model.LiveVO;

public class Schedule extends Timer{
    Timer timer;
    
    private Map<Integer, LiveTask> taskMap = new HashMap<Integer,LiveTask>();
    
    
    
    @Override
	public void cancel() {
		// TODO Auto-generated method stub
		super.cancel();
		
		System.out.println("timer取消");
	}

	public void addLiveTask(LiveVO liveVO) {
    	LiveTask liveTask = new LiveTask(liveVO);
    	this.taskMap.put(liveVO.getLive_no(),liveTask);
    	System.out.println("啟動排程");
    	System.out.println(liveVO.getLive_no()+"將於"+liveVO.getLive_time()+"開始直播");
    	this.schedule(liveTask, liveVO.getLive_time());
    	
    }
    
    public LiveTask getLiveTask(int live_no) {
    	return this.taskMap.get(live_no);
    }
    
    public void cancelLiveTask(int live_no) {
    	
    	
    	LiveTask liveTask = getLiveTask(live_no);
    	if(liveTask != null) {
    		liveTask.cancel();
    		this.taskMap.remove(live_no);
    		System.out.println("取消編號"+live_no+"的排程");
    	}else {
    		System.out.println("無編號"+live_no+"的排程");
    	}
    }
    
    class LiveTask extends TimerTask{
    	
    	private LiveVO liveVO;
    	private LiveService liveSvc = new LiveService();
    	
    	
    	public LiveTask(LiveVO liveVO) {
    		super();
    		this.liveVO = liveVO;
    	}
    	
		@Override
		public void run() {
			liveVO.setLive_state(2);
			liveSvc.updateLive(liveVO.getLive_type(), liveVO.getLive_name(), liveVO.getLive_time(), liveVO.getLive_state(), liveVO.getUser_id(), liveVO.getEmpno(), liveVO.getLive_photo(), liveVO.getLive_id(), liveVO.getLive_no());
			System.out.println("開始直播!");
		}
    	
    }
}

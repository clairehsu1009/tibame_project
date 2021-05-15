package com.fun.model;

import java.util.List;

public class FunService {
		
	private FunDAO_interface dao;
	
	public FunService() {
		dao = new FunDAO();
	}
	
	public FunVO addFun(String funName,Integer state) {
		FunVO funVO = new FunVO();
		
		funVO.setFunName(funName);	
		funVO.setState(state);
		dao.insert(funVO);
		
		return funVO;
	}
	
	public FunVO updateFun(Integer funno,String fun_name,Integer state) {
		
		FunVO funVO = new FunVO();
		
		funVO.setFunno(funno);
		funVO.setFunName(fun_name);
		funVO.setState(state);
		
		dao.update(funVO);
		
		return funVO;
	}
	
	public void deleteFun(Integer funno) {
		dao.delete(funno);
	}
	
	public FunVO getOneFun(Integer funno) {
		return dao.findByPrimaryKey(funno);
	}
	
	public List<FunVO> getAll(){
		return dao.getAll();
	}
}	


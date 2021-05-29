package com.auth.model;

import java.util.List;
import java.util.Set;


public class AuthService {
	private AuthDAO_interface dao;
	
	public AuthService() {
		dao = new AuthDAO();
	}
	
	public AuthVO addAuth(Integer empno,Integer funno,Integer auth_no) {
		AuthVO authVO = new AuthVO();
		
		authVO.setEmpno(empno);
		authVO.setFunno(funno);
		authVO.setAuth_no(auth_no);

				
		dao.insert(authVO);

		return authVO;
	}
	
	public AuthVO updateAuth(Integer auth_no,Integer  empno, Integer  funno) {

		AuthVO authVO = new AuthVO();
		authVO.setAuth_no(auth_no);
//System.out.println("AuthSvc auth_no= " + auth_no);
		authVO.setEmpno(empno);
//System.out.println("AuthSvc empno= " + empno);		
		authVO.setFunno(funno);
//System.out.println("AuthSvc funno= " + funno);		
		
		dao.update(authVO);

		return authVO;
	}
	public void deleteAuth(Integer empno,Integer funno) {
		dao.delete(funno,empno);
	}

	public AuthVO getOneAuth(Integer empno, Integer funno, Integer auth_no) {
		AuthVO authVO = new AuthVO();
		authVO.setEmpno(empno);		
		authVO.setFunno(funno);
		authVO.setAuth_no(auth_no);		
		dao.findAuthAllValues(authVO);
		return authVO;
	}
	
	public Set<AuthVO> getAllAuthByFunno(Integer funno) {
		return dao.findAuthByFunno(funno);
	}
	
	public List<AuthVO> getAll() {
		return dao.getAll();
	}

	public List<AuthVO> getAuthNOs (Integer empno){
		return dao.getAuth(empno);
	}
}

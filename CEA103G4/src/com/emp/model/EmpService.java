package com.emp.model;

import java.util.List;

public class EmpService {

	private EmpDAO_interface dao;

	public EmpService() {
		dao = new EmpDAO();
	}

	public EmpVO addEmp(String ename, String job, String id, Integer gender, java.sql.Date dob,String city,
			String dist, String addr, String email,Double sal,
			Integer state, java.sql.Date hiredate, String empPwd) {

		EmpVO empVO = new EmpVO();

		empVO.setEname(ename);
		empVO.setJob(job);
		empVO.setId(id);
		empVO.setGender(gender);
		empVO.setDob(dob);
		empVO.setCity(city);
		empVO.setDist(dist);
		empVO.setAddr(addr);
		empVO.setEmail(email);
		empVO.setSal(sal);
		empVO.setState(state);
		empVO.setHiredate(hiredate);
		empVO.setEmp_pwd(empPwd);
		
		dao.insert(empVO);
		
		return empVO;
	}

	public EmpVO updateEmp(Integer empno, String ename, String job, String id, Integer gender, java.sql.Date dob,
			String city,String dist,String addr,String email, Double sal, Integer state, java.sql.Date hiredate) {

		EmpVO empVO = new EmpVO();

		empVO.setEmpno(empno);
		empVO.setEname(ename);
		empVO.setJob(job);
		empVO.setId(id);
		empVO.setGender(gender);
		empVO.setDob(dob);
		empVO.setCity(city);
		empVO.setDist(dist);
		empVO.setAddr(addr);
		empVO.setEmail(email);
		empVO.setSal(sal);
		empVO.setState(state);
		empVO.setHiredate(hiredate);


		dao.update(empVO);

		return empVO;
	}

	public void deleteEmp(Integer empno) {
		dao.delete(empno);
	}

	public EmpVO getOneEmp(Integer empno) {
		return dao.findByPrimaryKey(empno);
	}

	public List<EmpVO> getAll() {
		return dao.getAll();
	}
	public String getPassword() {
		return dao.genAuthCode();
	}
	
	public EmpVO sendPwdMail(Integer empno, String ename,String email, String empPwd, String link) {
		EmpVO empVO = new EmpVO();
		empVO.setEmpno(empno);
		empVO.setEname(ename);
		empVO.setEmail(email);
		empVO.setEmp_pwd(empPwd);
		empVO.setLink(link);
		
		dao.sendMail(empVO);
		return empVO;
	}
	

	
	public EmpVO selectEmp(Integer empno, String empPwd) {

		return dao.login(empno, empPwd);
	}

	public EmpVO updatePswd(Integer empno, String empPwd) {		
		EmpVO empVO = new EmpVO();	
		empVO.setEmpno(empno);;
		empVO.setEmp_pwd(empPwd);
		
		dao.updatePswd(empVO);
		return empVO;
	}
	
	public EmpVO selectEmail(String email) {

		return dao.getEmail(email); 
	}

}

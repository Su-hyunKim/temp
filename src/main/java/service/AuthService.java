package service;

import java.util.List;

import vo.AuthVO;

public interface AuthService {	
	List<AuthVO> selectList(); //selectList
	AuthVO selectOne(AuthVO vo); //selectOne
	int insert(AuthVO vo); //insert
	int update(AuthVO vo); //update
	int delete(AuthVO vo); //delete

}
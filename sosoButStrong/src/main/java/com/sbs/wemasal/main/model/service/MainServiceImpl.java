package com.sbs.wemasal.main.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.main.model.dao.MainDao;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MainDao mainDao;
	
	@Override
	public int selectMainCount() {
		return mainDao.selectMainCount(sqlSession);
	}
	
	@Override
	public ArrayList<Attachment> ajaxSelectMain() {
		return mainDao.ajaxSelectMain(sqlSession);
	}
	
	@Override
	public ArrayList<Attachment> selectMain(PageInfo pi) {
		return mainDao.selectMain(sqlSession, pi);
	}
	
	@Override
	public int insertPic(Attachment at) {
		return mainDao.insertPic(sqlSession, at);
	}

	@Override
	public int deletePic(String changeName) {
		return mainDao.deletePic(sqlSession, changeName);
	}


	



}

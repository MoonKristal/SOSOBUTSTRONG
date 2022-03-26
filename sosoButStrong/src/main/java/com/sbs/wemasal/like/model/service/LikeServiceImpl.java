package com.sbs.wemasal.like.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.like.model.dao.LikeDao;
import com.sbs.wemasal.like.model.vo.Like;

@Service
public class LikeServiceImpl implements LikeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private LikeDao likeDao;
	
	@Override
	public int deleteLike(Like l) {
		return likeDao.deleteLike(sqlSession, l);
	}

	@Override
	public int insertLike(Like l) {
		return likeDao.insertLike(sqlSession, l);
	}

}

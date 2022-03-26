package com.sbs.wemasal.like.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.like.model.vo.Like;

@Repository
public class LikeDao {

	public int deleteLike(SqlSessionTemplate sqlSession, Like l) {
		return sqlSession.delete("likeMapper.deleteLike", l);
	}

	public int insertLike(SqlSessionTemplate sqlSession, Like l) {
		return sqlSession.insert("likeMapper.insertLike", l);
	}

}

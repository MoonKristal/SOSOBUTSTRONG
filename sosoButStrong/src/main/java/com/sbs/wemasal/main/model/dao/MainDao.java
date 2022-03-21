package com.sbs.wemasal.main.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;

@Repository
public class MainDao {

	public int selectMainCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mainMapper.selectMainCount");
	}
	
	public ArrayList<Attachment> ajaxSelectMain(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("mainMapper.selectMain");
	}
	
	public ArrayList<Attachment> selectMain(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mainMapper.selectMain", null, rowBounds);
	}

	public int insertPic(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("mainMapper.insertPic", at);
	}

	public int deletePic(SqlSessionTemplate sqlSession, String changeName) {
		return sqlSession.delete("mainMapper.deletePic", changeName);
	}


	



}

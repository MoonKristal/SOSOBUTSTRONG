package com.sbs.wemasal.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.notice.model.vo.Notice;

@Repository
public class NoticeDao {

	// 2022.3.29(화) 4h40
	/*
	public int selectManagerNoticeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.selectManagerNoticeListCount");
	}
	*/

	// 2022.3.29(화) 4h50
	public ArrayList<Notice> selectManagerNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		RowBounds rowBounds = Pagination.createRowBounds(pi);
		return (ArrayList)sqlSession.selectList("noticeMapper.selectManagerNoticeList", null, rowBounds);
	}

	// 2022.3.29(화) 6h35
	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}

	public int insertNoticeAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("noticeMapper.insertNoticeAttachment", at);
	}

	// 2022.3.29(화) 8h5
	public Notice selectManagerNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("noticeMapper.selectManagerNotice", nno);
	}

	// 2022.3.29(화) 8h40
	public int selectNoticeListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.selectNoticeListCount");
	}

	public ArrayList<Notice> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		RowBounds rowBounds = Pagination.createRowBounds(pi);
		return (ArrayList)sqlSession.selectList("noticeMapper.selectNoticeList", null, rowBounds);
	}

	public Notice selectNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.selectOne("noticeMapper.selectNotice", nno);
	}
	
	// 2022.4.3(일) 16h55
	public int increaseCount(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("noticeMapper.increaseCount", nno);
	}

	// 2022.4.2(토) 18h10
	public int deleteNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("noticeMapper.deleteNotice", nno);
	}
	
	// 2022.4.2(토) 19h45
	public int deleteNoticAttachment(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.delete("noticeMapper.deleteNoticAttachment", nno);
	}
	
	// 2022.4.3(일) 15h30
	public int updateNotice(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("noticeMapper.updateNotice", n);
	}

	// 2022.4.3(일) 14h45
	public int updateNoticeAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.update("noticeMapper.updateNoticeAttachment", at);
	}

	// 2022.4.3(일) 15h35
	public int insertNewNoticeAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("noticeMapper.insertNewNoticeAttachment", at);
	}

}

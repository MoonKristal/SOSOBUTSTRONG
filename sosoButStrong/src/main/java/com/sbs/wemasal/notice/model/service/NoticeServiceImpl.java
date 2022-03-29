package com.sbs.wemasal.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.notice.model.dao.NoticeDao;
import com.sbs.wemasal.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private NoticeDao noticeDao;

	// 2022.3.29(화) 4h40
	/*
	@Override
	public int selectManagerNoticeListCount() {
		return noticeDao.selectManagerNoticeListCount(sqlSession);
	}
	*/

	@Override
	public ArrayList<Notice> selectManagerNoticeList(PageInfo pi) {
		return noticeDao.selectManagerNoticeList(sqlSession, pi);
	}

	// 2022.3.29(화) 6h30
	@Override
	public int insertNotice(Notice n) {
		return noticeDao.insertNotice(sqlSession, n);
	}

	@Override
	public int insertNoticeAttachment(Attachment at) {
		return noticeDao.insertNoticeAttachment(sqlSession, at);
	}

	// 2022.3.29(화) 8h
	@Override
	public Notice selectManagerNotice(int nno) {
		return noticeDao.selectManagerNotice(sqlSession, nno);
	}

	// 2022.3.29(화) 8h40
	@Override
	public int selectNoticeListCount() {
		return noticeDao.selectNoticeListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectNoticeList(PageInfo pi) {
		return noticeDao.selectNoticeList(sqlSession, pi);
	}

	@Override
	public Notice selectNotice(int nno) {
		return noticeDao.selectNotice(sqlSession, nno);
	}

}

package com.sbs.wemasal.notice.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.notice.model.vo.Notice;

public interface NoticeService {

	// 2022.3.29(화) 4h40
//	int selectManagerNoticeListCount();
	ArrayList<Notice> selectManagerNoticeList(PageInfo pi);
	
	// 2022.3.29(화) 6h30
	int insertNotice(Notice n);
	int insertNoticeAttachment(Attachment at);
	
	// 2022.3.29(화) 8h5
	Notice selectManagerNotice(int nno);
	
	// 2022.3.29(화) 8h40
	int selectNoticeListCount();
	ArrayList<Notice> selectNoticeList(PageInfo pi);

	// 2022.3.29(화) 9h15
	Notice selectNotice(int nno);
	// 2022.4.3(일) 16h55
	int increaseCount(int nno);

	// 2022.4.2(토) 18h10
	int deleteNotice(int nno);
	
	// 2022.4.3(일) 15h30
	int updateNotice(Notice n);
	// 2022.4.2(토) 19h45
	int deleteNoticeAttachment(int nno);
	// 2022.4.3(일) 14h45
	int updateNoticeAttachment(Attachment at);

	// 2022.4.3(일) 15h35
	int insertNewNoticeAttachment(Attachment at);

}

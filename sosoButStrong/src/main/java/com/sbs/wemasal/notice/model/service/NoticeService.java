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

}

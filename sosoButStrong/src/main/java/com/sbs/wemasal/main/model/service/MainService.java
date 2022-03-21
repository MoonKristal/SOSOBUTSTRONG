package com.sbs.wemasal.main.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;


public interface MainService {
	
	// 등록되어 있는 메인페이지 사진 개수
	int selectMainCount();
	
	// 메인페이지 사진 조회(ajax)
	ArrayList<Attachment> ajaxSelectMain();

	// 메인페이지 사진 조회
	ArrayList<Attachment> selectMain(PageInfo pi);
	
	// 메인페이지 사진 등록
	int insertPic(Attachment at);

	int deletePic(String changeName);

	
	
}

package com.sbs.wemasal.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PageInfo {
	
	private int listCount; //총 게시판 갯수
	private int currentPage; //현재 페이지
	private int pageLimit; // 1페이지당 보여질 페이징바 수
	private int boardLimit; // 1페이지당 보여질 게시판 리스트 수 
	
	private int maxPage; // 최대 페이징바 수
	private int startPage; // 1페이지당 시작 페이징바
	private int endPage; //  1페이지당 끝 페이징바
	
}

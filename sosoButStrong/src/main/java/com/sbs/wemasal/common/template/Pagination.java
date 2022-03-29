package com.sbs.wemasal.common.template;

import org.apache.ibatis.session.RowBounds;

import com.sbs.wemasal.common.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int listCount, int currentPage, int pageLimit, int boardLimit) {
	
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);  
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(listCount, currentPage, pageLimit, boardLimit, maxPage, startPage, endPage);
 	}
	
	// 2022.3.24(목) myBatis에 페이징 처리 정보 넘기기 위한 공통 메소드 -> 2022.3.29(화) 1h10 Pagination 클래스에 static으로 만들어봄_은영
	public static RowBounds createRowBounds(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		return new RowBounds(offset, limit);
	}

}

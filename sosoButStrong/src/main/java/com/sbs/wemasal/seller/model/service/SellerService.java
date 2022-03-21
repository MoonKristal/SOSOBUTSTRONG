package com.sbs.wemasal.seller.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.seller.model.vo.Product;

public interface SellerService {
	
	// *상품조회/수정 리스트 조회 서비스 + 페이징 처리
	// 로그인한 판매자가 등록한 상품리스트 총 개수 조회
	int selectProductCount(int uploader);
	
	// 로그인한 판매자의 등록되어있는 상품리스트 전체 조회
	ArrayList<Product> selectProduct(PageInfo pi, int uploader);

	
	// *상품등록
	// 상품정보 참조 첨부파일 업로드 서비스
	int uploadAttachment(Attachment at);
	
	// 상품정보 업로드 서비스
	int uploadProduct(Product p);

}

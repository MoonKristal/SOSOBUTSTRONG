package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.seller.model.vo.Product;

public interface CustomerService {
	
	// 판매중 상품(샐러드) 리스트 조회
	ArrayList<Customer> selectSaladList();
	
	// 상품(샐러드) 상세보기
	Customer selectSaladDetailView(int productNo);
	
	// 상품(샐러드)리뷰 리스트 조회
	ArrayList<Review> selectProductReviewList(int productNo);
	
	// 나의 상품(샐러드)리뷰 리스트 조회
	ArrayList<Review> selectMyReviewList(int userNo);
	
	// 리뷰 삭제
	int deleteReview(int ReviewNo);
	
	// 리뷰 수정용 조회
	Review selectReviewForUpdate(int ReviewNo);
	
	// 리뷰 첨부파일 수정
	int updateAttachment(Attachment at);
	
	// 리뷰 수정
	int updateReview(Review r);
	
	// 리뷰 등록
	int uploadReview(Review r);
	
	// 리뷰 첨부파일 등록
	int uploadAttachment(Attachment at);
	
	// 내 장바구니 조회
	ArrayList<Cart> selectMyCart(int userNo);
	
	// 장바구니에 상품 담기
	int addToCart(Cart c);
	
	// 장바구니 상품 삭제
	int deleteCart(int cartNo);

	// 베스트 셀러 (메인페이지)
	ArrayList<Seller> selectTop3SellerList();
}

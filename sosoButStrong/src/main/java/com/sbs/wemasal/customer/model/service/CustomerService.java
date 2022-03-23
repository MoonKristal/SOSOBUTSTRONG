package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;

public interface CustomerService {
	
	// 판매중 상품(샐러드) 리스트 조회
	ArrayList<Customer> selectSaladList();
	
	// 상품(샐러드) 상세보기
	Customer selectSaladDetailView(int productNo);
	
	// 상품(샐러드)리뷰 리스트 조회
	ArrayList<Review> selectProductReviewList(int productNo);
	
}

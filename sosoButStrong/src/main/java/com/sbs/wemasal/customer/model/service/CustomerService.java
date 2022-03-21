package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import com.sbs.wemasal.customer.model.vo.Customer;

public interface CustomerService {
	
	// 판매중 샐러드 리스트 조회
	ArrayList<Customer> selectSaladList();
	
	// 샐러드 상품 상세보기
	Customer selectSaladDetailView(int pno);
	

}

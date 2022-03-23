package com.sbs.wemasal.customer.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.customer.model.service.CustomerService;
import com.sbs.wemasal.customer.model.vo.Customer;

@Controller
public class CustomerController {
	
	@Autowired
	private CustomerService customerService;
	
	/**
	 * 판매중인 상품(샐러드)리스트 보기 / 페이징처리 X / 상품 가로로 4개 씩 아래로 순차적 나열 형태
	 * @param mv
	 * @return
	 */
	@RequestMapping("saladListView.cmm")
	public ModelAndView selectSaladList(ModelAndView mv) {
		
		ArrayList<Customer> list = customerService.selectSaladList();
		
		mv.addObject("list",list).setViewName("user/customer/saladListView");
		
		return mv;
	}
	/**
	 * 상품(샐러드)상세(디테일뷰)보기
	 * @param pno : 상세보기 할 상품번호(식별 값)
	 * @param mv
	 * @return
	 */
	@RequestMapping("saladDetailView.cmm")
	public ModelAndView selectSaladDetailView(int pno, ModelAndView mv) {
		
		Customer c = customerService.selectSaladDetailView(pno);
		System.out.println(pno);
		
		mv.addObject("c",c).setViewName("user/customer/saladDetailView");
		
		return mv;
	}

}

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
	 * 판매중인 상품(샐러드)리스트 보기, 페이징처리 X
	 * @param currentPage
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
	 * 상품(샐러드) 상세,디테일뷰 보기
	 * @param pno
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

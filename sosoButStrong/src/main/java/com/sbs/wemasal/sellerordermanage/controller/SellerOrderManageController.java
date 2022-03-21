package com.sbs.wemasal.sellerordermanage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class SellerOrderManageController {
	

	@RequestMapping("orderManage.se")
	public String orderListManageForm() {
		return "user/seller/orderManageForm";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

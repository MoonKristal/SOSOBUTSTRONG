package com.sbs.wemasal.seller.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.wemasal.seller.model.service.SettlementService;

// 2022.3.25(금) 15h15
@Controller
public class SettlementController {
	
	@Autowired
	private SettlementService settlementService;
	
	// 2022.3.25(금) 15h25
	@RequestMapping("overview.st")
	public String selectSettlementOverview() {
		return "user/seller/settlementOverview";
	}
	
	
	
	

}

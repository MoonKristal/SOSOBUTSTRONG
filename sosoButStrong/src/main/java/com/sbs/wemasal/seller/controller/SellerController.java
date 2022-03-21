package com.sbs.wemasal.seller.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SellerController {
	
	@RequestMapping("sellerMyMenuForm.se")  // method라는 속성 쓸 수 있음! 그러나 안써도 알아서 뷰단에서 넘기는 형식대로 잘 받기 때문에 굳이 안썼음
	public String sellerMyMenuForm() {
		return "user/seller/productList";
	}
	
	@RequestMapping("productEnrollForm.se")
	public String productEnrollForm() {
		return "user/seller/sellerUploadForm";
	}
}

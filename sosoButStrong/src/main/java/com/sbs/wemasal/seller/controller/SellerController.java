package com.sbs.wemasal.seller.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sbs.wemasal.common.template.SaveFile;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.seller.model.service.SellerService;
import com.sbs.wemasal.seller.model.vo.Seller;

@Controller
public class SellerController {
	
	@Autowired
	private SellerService sellerService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// ----------------------------------------------
	@RequestMapping("sellerMyMenuForm.se")  // method라는 속성 쓸 수 있음! 그러나 안써도 알아서 뷰단에서 넘기는 형식대로 잘 받기 때문에 굳이 안썼음
	public String sellerMyMenuForm() {
		return "user/seller/productList";
	}
	
	@RequestMapping("productEnrollForm.se")
	public String productEnrollForm() {
		return "user/seller/sellerUploadForm";
	}
	
	@RequestMapping("orderManage.se")
	public String orderListManageForm() {
		return "user/seller/orderManageForm";
	}
	
	
	// --------------------------------------------
	@RequestMapping("sellerInsert.se")
	public String insertSeller(Member m, Seller s, Model model, HttpSession session, MultipartFile upfile) {
		
		// 암호화 작업(암호문을 만들어내는 과정)
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		m.setUserPwd(encPwd); // Member객체에 userPwd에 평문이 아닌 암호문으로 변경
		System.out.println(upfile);
		
		String changeName = SaveFile.saveFile(upfile, session); // 파일경로설정
		s.setSellerImage(upfile.getOriginalFilename()); // Seller객체에 이미지 원본명 추가 (String으로 반환해서 넣어주기)
		s.setSellerImagePath(changeName); // Seller객체에 imagePath에 사진경로 추가 
		
		int result = sellerService.insertSeller(m,s);
		
		if(result > 0) { // 성공 => 메인페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 판매자 신청이 되었습니다.");
			return "redirect:/";
			
		} else { // 실패 
			session.setAttribute("alertMsg", "실패하였습니다.");
			return "redirect:/";
		}
		
	}
	// 상호 중복체크
	@ResponseBody
	@RequestMapping("sellerNameCheck.se")
	public String idCheck(String checkName) {

		return sellerService.sellerNameCheck(checkName) > 0 ? "NN" : "NY";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

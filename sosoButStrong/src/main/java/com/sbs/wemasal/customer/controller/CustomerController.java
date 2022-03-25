package com.sbs.wemasal.customer.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.template.SaveFile;
import com.sbs.wemasal.customer.model.service.CustomerService;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;
import com.sbs.wemasal.member.model.vo.Member;

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
		
		mv.addObject("c",c).setViewName("user/customer/saladDetailView");
		
		return mv;
	}
	/**
	 * 상품리뷰 조회 (AJAX)
	 * @param pno : 상품번호
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="reviewList.cmm", produces="application/json; charset=UTF-8")
	public String ajaxSelectProductReviewList(int pno) {
		
		return new Gson().toJson(customerService.selectProductReviewList(pno));
	}
	/**
	 * 리뷰 더보기 페이지로 이동
	 * @param pno : 상품번호
	 * @param mv
	 * @return
	 */
	@RequestMapping("reviewDetailView.cmm")
	public ModelAndView ReviewDetailView(int pno, ModelAndView mv) {
		
		Customer c = customerService.selectSaladDetailView(pno);
		
		mv.addObject("c",c).setViewName("user/customer/saladDetailViewReviewDetail");
		
		return mv;
	}
	/**
	 * 리뷰관리(내가 쓴 리뷰) 페이지로 이동
	 * @return
	 */
	@RequestMapping("reviewList.cs")
	public String ajaxSelectMyReviewList() {
		
		return "user/customer/myReviewList";
	}
	/**
	 * 나의 상품리뷰 조회 (AJAX)
	 * @param mno : 로그인 한 유저의 회원번호 (내가 작성한 리뷰만 조회해올 식별 값)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="myReviewList.cs", produces="application/json; charset=UTF-8")
	public String ajaxSelectMyReviewList(int mno) {
		
		return new Gson().toJson(customerService.selectMyReviewList(mno));
	}
	/**
	 * 리뷰 삭제 (AJAX) (요청시 DB에서 delete 하지 않고 update로 상태를 Y -> N 으로 변경하여 노출되지 않도록 함)
	 * @param rno : 삭제 할 리뷰 번호 
	 * @return
	 */
	@ResponseBody
	@RequestMapping("deleteReview.cs")
	public int ajaxDeleteReview(int rno) {
		
		return customerService.deleteReview(rno);
	}
	/**
	 * 리뷰수정용 기존 내용 조회 (AJAX)
	 * @param rno : 조회 할 리뷰 번호 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="selectReview.cs", produces="application/json; charset=UTF-8")
	public String ajaxSelectReviewForUpdate(int rno) {
		
		Review r = customerService.selectReviewForUpdate(rno);
		
		return new Gson().toJson(customerService.selectReviewForUpdate(rno));
	}
	/**
	 * 리뷰 수정
	 * @param r : 리뷰 수정할 내용
	 * @param reThumbnail : 수정할 리뷰 첨부 이미지
	 * @param at : 첨부파일 가공용
	 * @param originFilePath : 기존 이미지 저장경로
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("updateReview.cs")
	public String updateReview(Review r, MultipartFile reThumbnail, Attachment at, String originFilePath, Model model, HttpSession session) {
		
		if(!reThumbnail.getOriginalFilename().equals("")) { // 수정할 첨부파일(썸네일)이 있으면
			
			SaveFile saveFile = new SaveFile();
			
			String changeName = saveFile.saveFile(reThumbnail, session); // 파일명 변경하고 서버에 파일저장 후 변경한 파일명 반환받아서 변수에 저장
			
			at.setOriginName(reThumbnail.getOriginalFilename()); // 파일 원본명 얻어서 세팅
			at.setChangeName("resources/uploadFiles/" + changeName); // 서버저장 용도로 변경한 파일명에 저장경로 붙여서 세팅
			at.setRefRno(r.getReviewNo()); // 수정할 파일이 참조할 리뷰번호 세팅
			
			customerService.updateAttachment(at); // 첨부파일 수정 , 업데이트
			
			new File(session.getServletContext().getRealPath(originFilePath)).delete(); // 기존에 있던  썸네일은 서버에서 삭제
		}
		
		int result = customerService.updateReview(r); // 상품수정
		
		if(result > 0) { // 리뷰 수정 성공
			session.setAttribute("alertMsg", "리뷰수정이 완료 되었습니다.");
			return "redirect:reviewList.cs";
		} else { // 리뷰 수정 실패
			model.addAttribute("errorMsg", "리뷰수정 실패");
		}	return "common/errorPage";
	}
	/**
	 * 리뷰 작성
	 * @param r : 리뷰 작성 내용
	 * @param thumbnail : 리뷰 첨부 이미지
	 * @param at : 첨부파일 가공용
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("uploadReview.cs")
	public String uploadReview(Review r, MultipartFile thumbnail, Attachment at, HttpSession session, Model model) {
		
		SaveFile saveFile = new SaveFile();
		
		String changeName = saveFile.saveFile(thumbnail, session); // 파일명 변경하고 서버에 파일저장 후 변경한 파일명 반환받아서 변수에 저장
		
		at.setOriginName(thumbnail.getOriginalFilename()); // 파일 원본명 얻어서 세팅
		at.setChangeName("resources/uploadFiles/" + changeName); // 서버저장 용도로 변경한 파일명에 저장경로 붙여서 세팅
		
		int result1 = customerService.uploadReview(r); // 상품리뷰 작성
		
		int result2 = customerService.uploadAttachment(at); // 첨부파일 업로드
		
		if(result1 * result2 > 0) { // 리뷰작성 성공
			session.setAttribute("alertMsg", "리뷰작성 완료");
			return "redirect:reviewList.cs";
		} else { // 리뷰작성 실패
			if(result2 < 0) {
				new File(changeName + at.getChangeName()).delete();
		}
			model.addAttribute("errorMsg", "리뷰작성 실패");
			return "common/errorPage";
		}
	}
	/**
	 * 내 장바구니로 이동 및 장바구니 조회
	 * @param mv
	 * @param session
	 * @return
	 */
	@RequestMapping("myCart.cs")
	public ModelAndView selectMyCart(ModelAndView mv, HttpSession session) {
		
		int userNo = ((Member)session.getAttribute("loginUser")).getUserNo(); // 조회할 장바구니 식별할 유저번호 가져와서 변수에 담기
		
		ArrayList<Cart> list = customerService.selectMyCart(userNo); // 유저번호로 장바구니 조회
		
		mv.addObject("list",list).setViewName("user/customer/cart");
		
		return mv;
	}
	/**
	 * 상품 장바구니 추가
	 * @param c : 장바구니에 담을 상품정보(상품번호,상품명,유저번호,옵션,가격,수량)
	 * @param model
	 * @return
	 */
	@RequestMapping("addCart.cs")
	public String addToCart(Cart c, HttpSession session, Model model){
		
		if(customerService.addToCart(c) > 0) {
			
			session.setAttribute("alertMsg", "상품을 장바구니에 담았습니다 ^^ 장바구니 메뉴에서 확인하실 수 있습니다");
			
			return "redirect:saladDetailView.cmm?pno="+c.getProductNo();
		}
		model.addAttribute("errorMsg", "장바구니 담기 실패");
		
		return "common/errorPage";
	}
	/**
	 * 장바구니 비우기 (삭제)
	 * @param cno : 삭제할 장바구니를 식별 할 장바구니 번호
	 * @param model
	 * @return
	 */
	@RequestMapping("deleteCart.cs")
	public String deleteCart(int cno, Model model) {
		
		if(customerService.deleteCart(cno) > 0) {
			
			return "redirect:myCart.cs";
		}
		model.addAttribute("errorMsg", "장바구니 삭제 실패");
		
		return "common/errorPage";
	}
	/**
	 * 바로주문 (장바구니에 담기에 성공하면 바로 장바구니 내용 가지고 주문하기 페이지로 이동)
	 * @param c : 장바구니에 담을 상품정보(상품번호,상품명,유저번호,옵션,가격,수량)
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("orderNow.cs")
	public String orderNow (Cart c, HttpSession session, Model model) {
		
		if(customerService.addToCart(c) > 0) {
			
			return "redirect:orderForm.od";
		}
		model.addAttribute("errorMsg", "바로주문 실패");
		
		return "common/errorPage";
	}
}

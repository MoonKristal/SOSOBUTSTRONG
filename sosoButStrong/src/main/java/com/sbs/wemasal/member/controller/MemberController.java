package com.sbs.wemasal.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.common.template.SaveFile;
import com.sbs.wemasal.member.model.service.MemberService;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.seller.model.service.SellerService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("loginPage.me")
	public String loginPage() {
		return "user/member/login";
	}
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(HttpServletRequest request, Member m, ModelAndView mv, HttpSession session ) {

		Member loginUser = memberService.loginMember(m);
		
		//System.out.println(bcryptPasswordEncoder.encode("seller1"));
		
		if(loginUser != null && bcryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd())) {
			// System.out.println("여기ㅏ로왔나");
			// 로그인 성공
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/");
		} else {
			// System.out.println("아님 여ㅑ기???? ");
			// 로그인 실패
			mv.addObject("errorMsg", "로그인실패").setViewName("user/common/errorPage");
		}
		return mv;
	}
	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate(); 
		return "redirect:/";
	}

	
	@RequestMapping("enroll.me") // 회원가입 선택 페이지로
	public String enroll() {
		return "user/member/memberEnroll";
	}
	
	@RequestMapping("memberEnroll.me") // 일반회원 가입 페이지로
	public String memberEnroll() {
		return "user/member/memberEnrollForm";
	}
	
	
	@RequestMapping("sellerEnroll.me") // 판매자 가입 페이지로 
	public String sellerEnroll() {
		return "user/seller/sellerEnrollForm";
	}
	
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {
		System.out.println(m);
		
		// 암호화 작업(암호문을 만들어내는 과정)
		String encPwd = bcryptPasswordEncoder.encode(m.getUserPwd());
		//System.out.println("암호문 : " + encPwd);
		
		m.setUserPwd(encPwd); // Member객체에 userPwd에 평문이 아닌 암호문으로 변경
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { // 성공 => 메인페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");
			return "redirect:/";
			
		} else { // 실패 
			session.setAttribute("alertMsg", "회원가입 실패하였습니다.");
			return "redirect:/";
		}
		
	}

	@ResponseBody
	@RequestMapping("idCheck.me")
	public String idCheck(String checkId) {

		return memberService.idCheck(checkId) > 0 ? "NN" : "NY";
	}
	
	
	public void updateMember() {
		
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
			
			int result = memberService.insertSeller(m,s);
			
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
		public String sellerIdCheck(String checkName) {

			return memberService.sellerNameCheck(checkName) > 0 ? "NN" : "NY";
		}
		
		// -----------------------------------------------------------------
	
	
		// 구매자 회원정보수정 비밀번호 확인페이지로
		@RequestMapping("buyerInformationPwdCheck.me") 
		public String buyerInformationPwdCheck() {
			return "user/member/buyerInformationPwdCheck";
		}
	
		// 비밀번호 확인 후 구매자 회원정보수정 페이지로
		@RequestMapping("PWDCheck.me") 
		public String buyerInformation(String userId, String userPwd, HttpSession session, Model model) {
			
			String encPwd = ((Member)session.getAttribute("loginUser")).getUserPwd();
			if(bcryptPasswordEncoder.matches(userPwd, encPwd)) { // 비밀번호가 맞을 경우 => 구매자회원정보수정페이지로
				return "user/member/buyerInformation";
			} else { // 비밀번호가 틀릴 경우
				session.setAttribute("alertMsg", "비밀번호가 틀렸습니다.");
				return "user/member/buyerInformationPwdCheck";
			}
		}
		
	
		// 일반회원 정보 수정 처리
		@RequestMapping("buyerInformationUpdate.me") 
		public String updateMember(Member m, Model model, HttpSession session) {
			
			int result = memberService.updateMember(m);
			
			if(result > 0) { // 수정성공
				
				Member updateMem = memberService.loginMember(m);
				session.setAttribute("loginUser", updateMem);
				
				session.setAttribute("alertMsg", "성공적으로 회원정보가 변경되었습니다.");
				return "user/member/buyerInformationPwdCheck";
				
			} else { // 수정실패 
				session.setAttribute("alertMsg", "수정실패했습니다.");
				return "user/member/buyerInformationPwdCheck";
			}
			
		}
		
		@RequestMapping("buyerInformationDelete.me")
		public String deleteMember(String userId, HttpSession session, Model model) {
		
			int result = memberService.deleteMember(userId);
			if(result > 0) {
				// 탈퇴처리 성공 => session에서 loginUser 지움, alert문구 담기 => 메인페이지 url요청
				session.removeAttribute("loginUser");
				session.setAttribute("alertMsg", "탈퇴되었습니다.");
				return "redirect:/";
			} else {
				// 탈퇴처리 실패
				session.setAttribute("alertMsg", "회원탈퇴 실패하였습니다.");
				return "redirect:/";
			}
		}
		
		// 아이디/비밀번호 찾기 페이지로
		@RequestMapping("findIDPW.me") 
		public String findIDPW() {
			return "user/member/findIDPW";
		}
		
	
}

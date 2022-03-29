package com.sbs.wemasal.question.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.common.template.SaveFile; // The static import com.sbs.wemasal.common.template.SaveFile must be a field or member type
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.member.model.vo.Seller;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.question.model.service.QuestionService;
import com.sbs.wemasal.question.model.vo.Answer;
import com.sbs.wemasal.question.model.vo.Question;

@Controller
public class QuestionController {
	
	@Autowired
	private QuestionService questionService;
	
	// 2022.3.17(목) 14h30 구매자 마이페이지 메인으로 forwarding
	@RequestMapping("buyerMyPage.me")
	public String buyerMyPageMain() {
		return "user/common/buyerMyPage";
	}
	
	// 2022.3.7(월) 14h -> 2022.3.24(목) 14h50 기능 구현
	@RequestMapping("buyerList.qu")
	public ModelAndView selectBuyerQuestionList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpServletRequest request, ModelAndView mv) {
		int buyerNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo(); // 나의 질문 = HttpSession으로부터 왜 바로 loginUser 못 꺼내쓰지?
		
		PageInfo pi = Pagination.getPageInfo(questionService.selectBuyerQuestionListCount(buyerNo), currentPage, 4, 8);
		
		ArrayList<Question> list = questionService.selectBuyerQuestionList(pi, buyerNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("user/question/buyerQuestionListView");
		
		return mv;
	}
	
	// 2022.3.14(월) 9h30
	@RequestMapping("enrollForm.qu")
	public String questionEnrollForm() {
		return "user/question/buyerQuestionEnrollForm";
	}
	
	// 2022.3.18(금) 13h55
	@ResponseBody
	@RequestMapping("buyerOrderList.qu")
	public Object ajaxSelectBuyerOrderList(int userNo, @RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		PageInfo pi = Pagination.getPageInfo(questionService.selectBuyerOrderListCount(userNo), currentPage, 4, 5);
		// pageLimit = 페이지 하단에 보여질/표시되는 paging bar/buttons의 최대 개수 -> 4로 임의 지정
		// boardLimit = 한 페이지에 보여질 게시글의 최대 개수 -> 5로 임의 지정
//		System.out.println(pi);
		// 2022.3.23(수) 0h55 주문 내역 있는 경우 테스트 = PageInfo(listCount=2, currentPage=1, pageLimit=4, boardLimit=5, maxPage=1, startPage=1, endPage=1)
		// 2022.3.23(수) 1h15 주문 내역 없는 경우 테스트 = PageInfo(listCount=0, currentPage=1, pageLimit=4, boardLimit=5, maxPage=0, startPage=1, endPage=0)
		
		// 2022.3.22(화) 18h55
		ArrayList<Order> list = questionService.selectBuyerOrderList(pi, userNo);
		// 요청보낸 구매자 번호의 주문번호 ORDER_NO, 주문일자 ORDER_DATE, 판매자 번호 SELLER, 판매자 SELLER_NAME, 주문상품 ORDER_ITEM, 수량 QUANTITY, 주문금액 ORDER_PRICE 받아와야 함
		
		// 반환 방법1) AJAX 통신 응답 시 ModelAndView 객체(request 객체 같은 것) 사용할 수 있는 것인지 모르겠음
//		mv.addObject("pi", pi).addObject("list", list);
//		return mv;
		
		// 반환 방법2)
//		return new Gson().toJson(list); // 19h10 나의 질문 = pi는 왜 응답해줘야 하지? view단에서 paging 처리해야 하니까 + pi와 list 둘 다 AJAX 응답해주려면 어떻게 해야 하지?
		
		// 2022.3.22(화) 22h35 반환 방법3) RequestMapping 속성 produces="application/json; charset=UTF-8" 추가 -> AJAX 통신 실패로 뜸
		/*
		JSONObject jObj = new JSONObject();
		
		jObj.put("pi", pi);
		jObj.put("list", list);
		
		return jObj.toJSONString();
		*/
		
		// 2022.3.22(화) 23h 반환 방법4)
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("pi", pi);
		result.put("list", list);
		
		return result;
	}
	
	// 2022.3.17(목) 17h15 -> 2022.3.23(수) 1h40 기능 구현
	@ResponseBody
	@RequestMapping("confirmOrderNo.qu")
	public String ajaxConfirmOrderNo(Question q) {
//		System.out.println(q);
		/* 2022.3.24(목) 15h20 나의 생각 = 내가 처음 구현할 때 왜 굳이 Question 객체를 builder로 만들었지?
		int result = questionService.countOrderNo(Question.builder()
													.questionWriter(q.getQuestionWriter())
													.questionSeller(q.getQuestionSeller())
													.orderNo(q.getOrderNo())
													.build());
		*/
		
		return questionService.countOrderNo(q) > 0? "Y" : "N"; // 기존 문의 내역이 있으면 Y vs 없으면 N 반환 
	}
	
	// 2022.3.23(수) 3h35
	@ResponseBody
	@RequestMapping(value="searchSellerName.qu", produces="application/json; charset=utf-8")
	public String ajaxSearchSellerName(String sellerNameKeyword) {
		ArrayList<Seller> list = questionService.searchSellerName(sellerNameKeyword);
		// System.out.println(list); // 2022.3.23(수) 17h45 테스트 = [Seller(userNo=3, sellerName=King받는샐러드숍, sellerBRN=null, sellerPhone=null, sellerLocation=null, sellerIntro=null, sellerImage=null, sellerImagePath=null, sellerStatus=null), Seller(userNo=5, sellerName=기린네샐러드, sellerBRN=null, sellerPhone=null, sellerLocation=null, sellerIntro=null, sellerImage=null, sellerImagePath=null, sellerStatus=null), Seller(userNo=4, sellerName=토끼네샐러드, sellerBRN=null, sellerPhone=null, sellerLocation=null, sellerIntro=null, sellerImage=null, sellerImagePath=null, sellerStatus=null)]
		
		return new Gson().toJson(list);
	}
	
	// 2022.3.17(목) 18h25 -> 2022.3.23(수) 15h15 기능 구현
	@RequestMapping("buyerInsert.qu")
	public String insertBuyerQuestion(Question q, MultipartFile upfile, HttpSession session, Model model) {
		// 15h50 요청 form으로부터 questionSeller 안 넘어오는  문제 한참 해결
		// WARN : org.springframework.web.servlet.mvc.support.DefaultHandlerExceptionResolver - Resolved [org.springframework.validation.BindException: org.springframework.validation.BeanPropertyBindingResult: 1 errors<EOL>Field error in object 'question' on field 'questionSeller': rejected value []; codes [typeMismatch.question.questionSeller,typeMismatch.questionSeller,typeMismatch.int,typeMismatch]; arguments [org.springframework.context.support.DefaultMessageSourceResolvable: codes [question.questionSeller,questionSeller]; arguments []; default message [questionSeller]]; default message [Failed to convert property value of type 'java.lang.String' to required type 'int' for property 'questionSeller'; nested exception is java.lang.NumberFormatException: For input string: ""]]
		// resultMap="sellerResultset"에 USER_NO 컬럼이 없었음 + JavaScript로 questionSeller/seller.userNo 값 빼내는 방법 헤맴
//		System.out.println(q); // 2022.3.23(수) 18h 테스트 = Question(questionNo=0, questionWriter=2, questionSeller=6, category=product, orderNo=, answerMode=email,sms, questionTitle=소스 궁금해요, questionContent=1. 스파이시 소스 얼마나 맵나요?
		// 2. 소스 용량 얼마나 되나요?, createDate=null, answer=null, status=null)
//		System.out.println(upfile); // 2022.3.23(수) 18h 테스트 = null -> 요청 페이지에서 file input 태그의 name 속성 값 = upfile1(o) upfile(x) -> null pointer exception 발생 vs 2022.3.23(수) 18h30 테스트 시 MultipartFile[field="upfile", filename=, contentType=application/octet-stream, size=0]
		
		int result1 = questionService.insertBuyerQuestion(q);
		
		int result2 = 1;
		
		if (!upfile.getOriginalFilename().equals("")) {
			Attachment at = new Attachment(); // 2022.3.24(목) 14h50 나의 질문 = Attachment 객체를 이 메소드의 매개변수로 받아서 쓰는 것 vs 이렇게 객체 생성해서 쓰는 것, 어떤 것이 더 나은가/맞는가?
			
			String changeName = SaveFile.saveFile(upfile, session);
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName("resources/uploadFiles/" + changeName);
			
			result2 = questionService.insertQuestionAttachment(at);
		}
		
		if (result1 * result2 > 0) {
			session.setAttribute("alertMsg", "1:1문의 글 등록이 완료되었습니다. 등록된 글을 마이페이지에서 확인 가능합니다.");
			return "redirect:buyerList.qu";
		} else {
			model.addAttribute("errorMsg", "1:1문의 글 등록에 실패했습니다.");
			return "user/common/errorPage";
		}
		
	} // insertBuyerQuestion() 종료; 2022.3.24(목) 14h40 테스트 완료
	
	// 2022.3.25(금) 11h35
	@RequestMapping("sellerInsert.qu")
	public String insertSellerAnswer(Answer a, MultipartFile upfile, Attachment at, HttpSession session, Model model) {
		int result1 = questionService.insertSellerAnswer(a);
		
		int result2 = 1;
		
		if (!upfile.getOriginalFilename().equals("")) {
			String changeName = SaveFile.saveFile(upfile, session);
			
			at.setOriginName(upfile.getOriginalFilename());
			at.setChangeName("resources/uploadFiles/" + changeName);
			
			result2 = questionService.insertAnswerAttachment(at); // 나의 생각 = insertQuestionAttachment(at) 메소드/쿼리문 공유해서 재활용하고 싶음
		}
		
		if (result1 * result2 > 0) { // 답변 글 및 관련 첨부파일을 각 테이블에 INSERT 성공하면,
			questionService.updateAnswer(a.getQuestionNo());
			
			/* 아래 문자열 배열에 email이 포함된 경우 답변 내용을 이메일로 or/and sms가 포함된 경우 답변 내용을 문자 메시지로 전송
			String[] answerModes = a.getAnswerMode().split(",");
			*/		
			
			session.setAttribute("alertMsg", "1:1문의 답변 등록이 완료되었습니다.");
			return "redirect:sellerList.qu";
		} else {
			model.addAttribute("errorMsg", "1:1문의 답변 등록에 실패했습니다.");
			return "user/common/errorPage";
		}
	}
	
	// 2022.3.24(목) 18h10
	@RequestMapping("buyerDetail.qu")
	public ModelAndView selectBuyerQuestion(ModelAndView mv, int qno) {
//		System.out.println(qno);
		
		// 2022.3.25(금) 1h
		Question q = questionService.selectBuyerQuestion(qno);
		
		Answer a = null;
		
		if (q.getAnswer().equals("Y")) {
			a = questionService.selectAnswer(qno);
		}
		
		mv.addObject("q", q).addObject("a", a).setViewName("user/question/buyerQuestionDetailView");
		
		return mv;
	}
	
	@RequestMapping("updateForm.qu")
	public String questionUpdateForm(int qno) {
		return "user/question/buyerQuestionUpdateForm";
	}
	
	@RequestMapping("buyerUpdate.qu")
	public String updateBuyerQuestion(int qno) {
		return "redirect:buyerDetail.qu?qno=" + qno;
	}
	
	@RequestMapping("delete.qu")
	public String deleteBuyerQuestion(int qno, String filePath) {
		return "redirect:buyerList.qu";
	}
	
	// 2022.3.25(금) 3h
	@RequestMapping("buyerSearch.qu")
	public ModelAndView searchBuyerQuestion(ModelAndView mv, HttpServletRequest request, @RequestParam(value="cpage", defaultValue="1") int currentPage) {
		// http://localhost:8765/wemasal/buyerSearch.qu?startDate=&endDate=&searchAnswer=searchAnswerAll&category=categoryAll&condition=&keyword=
//		System.out.println(q);
		// 아무 것도 선택 안 하고 '검색' 버튼 클릭 시, Question(questionNo=0, questionWriter=2, questionSeller=0, category=, orderNo=null, answerMode=null, questionTitle=null, questionContent=null, createDate=null, answer=, status=null, sellerName=null, sellerPhone=null, originName=null, changeName=null, startDate=, endDate=, condition=, keyword=)
		
		/* 2022.3.25(금) Question 객체에 요청 값 받아와서 처음 테스트 시, 아무 것도 선택 안 하고 '검색' 버튼 클릭 시, list = [] vs 내가 의도한 바에 따르면 해당 구매자가 작성한 모든 문의 글이 보여야 함
		 * 
		 * hashmap에 요청 받은 값 담아서 5h30 테스트 시, 내가 의도한대로 작동하지 않음
		 * map = {condition=sellerName, answer=N, endDate=2022-03-25, questionWriter=2, category=상품 정보 문의, keyword=샐, startDate=2021-03-25}
		 * 
		 * listCount = 2
		 * Preparing: SELECT COUNT(*) FROM QUESTION Q LEFT JOIN SELLER ON (QUESTION_SELLER = USER_NO) WHERE QUESTION_WRITER = ? AND Q.STATUS = 'Y' AND CREATE_DATE BETWEEN ? and ? AND ANSWER = ? AND CATEGORY = ? AND SELLER_NAME LIKE '%' || ? || '%'
		 * Parameters: 2(String), 2021-03-25(String), 2022-03-25(String), N(String), 상품 정보 문의(String), 샐(String)
		 * 
		 * list = [Question(questionNo=4, questionWriter=0, questionSeller=3, category=상품 정보 문의, orderNo=1647571870181, answerMode=null, questionTitle=양상추 양이 적어요, questionContent=null, createDate=2022-03-24 14:41:01, answer=N, status=null, sellerName=King받는샐러드숍, sellerPhone=null, originName=null, changeName=null, startDate=null, endDate=null, condition=null, keyword=null),
		 * 		   Question(questionNo=1, questionWriter=0, questionSeller=3, category=상품 정보 문의, orderNo=null, answerMode=null, questionTitle=소스 질문 드립니다, questionContent=null, createDate=2022-03-24 14:18:11, answer=N, status=null, sellerName=King받는샐러드숍, sellerPhone=null, originName=null, changeName=null, startDate=null, endDate=null, condition=null, keyword=null)]
		 * Preparing: SELECT QUESTION_NO, TO_CHAR(CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') "CREATE_DATE", QUESTION_SELLER, SELLER_NAME, CATEGORY, QUESTION_TITLE, ORDER_NO, ANSWER FROM QUESTION Q LEFT JOIN SELLER ON (QUESTION_SELLER = USER_NO) WHERE QUESTION_WRITER = ? AND Q.STATUS = 'Y' AND CREATE_DATE BETWEEN ? and ? AND ANSWER = ? AND CATEGORY = ? AND SELLER_NAME LIKE '%' || ? || '%' ORDER BY CREATE_DATE DESC
		 * Parameters: 2(String), 2021-03-25(String), 2022-03-25(String), N(String), 상품 정보 문의(String), 샐(String)
		 * 
		 * 또는 검색 기준 뭔가 선택 안 한 경우 map = {condition=, answer=, endDate=2022-03-25, questionWriter=2, category=, keyword=, startDate=2022-02-25} -> listCount = 0, list = []
		 * 
		 * 5h55 테스트 시, mapper 쿼리문 if절에서 null(x) 빈 문자열(o)과 비교하는 조건문 -> 의도한대로 작동
		 * map = {condition=titleOrContent, answer=, endDate=, questionWriter=2, category=, keyword=용량, startDate=}
		 * 
		 * listCount = 1
		 * Preparing: SELECT COUNT(*) FROM QUESTION Q LEFT JOIN SELLER ON (QUESTION_SELLER = USER_NO) WHERE QUESTION_WRITER = ? AND Q.STATUS = 'Y' AND QUESTION_TITLE LIKE '%' || ? || '%' OR QUESTION_CONTENT LIKE '%' || ? || '%'
		 * Parameters: 2(String), 용량(String), 용량(String)
		 * 
		 * list = [Question(questionNo=1, questionWriter=0, questionSeller=3, category=상품 정보 문의, orderNo=null, answerMode=null, questionTitle=소스 질문 드립니다, questionContent=null, createDate=2022-03-24 14:18:11, answer=N, status=null, sellerName=King받는샐러드숍, sellerPhone=null, originName=null, changeName=null, startDate=null, endDate=null, condition=null, keyword=null)]
		 */
		
		String questionWriter = request.getParameter("questionWriter");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String answer = request.getParameter("answer");
		String category = request.getParameter("category");
		String condition = request.getParameter("condition");
		String keyword = request.getParameter("keyword");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("questionWriter", questionWriter);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		map.put("answer", answer);
		map.put("category", category);
		map.put("condition", condition);
		map.put("keyword", keyword);
//		System.out.println(map);
		
		int listCount = questionService.selectBuyerQuestionSearchListCount(map);
//		System.out.println(listCount);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 4, 8);
		
		ArrayList<Question> list = questionService.selectBuyerQuestionSearchList(pi, map);
//		System.out.println(list);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("startDate", startDate)
		  .addObject("endDate", endDate)
		  .addObject("answer", answer)
		  .addObject("category", category)
		  .addObject("condition", condition)
		  .addObject("keyword", keyword)
		  .setViewName("user/question/buyerQuestionListView");
		
		return mv;
	}
	
	// 2022.3.25(금) 9h25
	@RequestMapping("sellerList.qu")
	public ModelAndView selectSellerQuestionList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpServletRequest request, ModelAndView mv) {
		int sellerNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		
		PageInfo pi = Pagination.getPageInfo(questionService.selectSellerQuestionListCount(sellerNo), currentPage, 4, 8);
		
		ArrayList<Question> list = questionService.selectSellerQuestionList(pi, sellerNo);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("user/question/sellerQuestionListView");
		
		return mv;
	}
	
	// 2022.3.25(금) 10h20
	@RequestMapping("sellerDetail.qu")
	public ModelAndView selectSellerQuestion(ModelAndView mv, int qno) {
		Question q = questionService.selectSellerQuestion(qno);
		
		Answer a = null;
		
		if (q.getAnswer().equals("Y")) {
			a = questionService.selectAnswer(qno);
		}
		
		mv.addObject("q", q).addObject("a", a).setViewName("user/question/sellerQuestionDetailView");
		
		return mv;
	}
	
	// 2022.3.25(금) 14h15
	@ResponseBody
	@RequestMapping("answerRating.qu")
	public String ajaxUpdateScore(Answer a) {
		System.out.println(a);
		
		return questionService.updateScore(a) > 0? "success" : "fail";
	}

}

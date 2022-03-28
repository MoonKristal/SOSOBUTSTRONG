package com.sbs.wemasal.seller.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.customer.model.service.CustomerService;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.seller.model.service.SellerService;
import com.sbs.wemasal.seller.model.vo.Product;
import com.sbs.wemasal.member.model.vo.Member;


@Controller
public class SellerController {
	
	@Autowired
	private SellerService sellerService;
	
	@Autowired
	private CustomerService customerService;
	
	/**
	 * 상품조회/수정 리스트에 등록된 상품들 리스트 노출 & 페이징처리
	 * @param currentPage : 현재 페이지
	 * @param mv
	 * @return
	 */
	@RequestMapping("sellerProductList.se")
	public ModelAndView selectList(@RequestParam(value="pPage", defaultValue="1")int currentPage, ModelAndView mv, HttpSession session) {
		
		int uploader = ((Member)session.getAttribute("loginUser")).getUserNo(); // 로그인된 회원의 회원번호(식별자) 가져와서 변수에 담기
		
		int listCount = sellerService.selectProductCount(uploader); // 등록되어있는 상품 총 개수 조회
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		ArrayList<Product> list = sellerService.selectProduct(pi, uploader);
		
		mv.addObject("list",list).addObject("pi", pi).setViewName("user/seller/productList");
		
		return mv;
	}
	/**
	 * 상품등록 화면으로 이동
	 * @return
	 */
	@RequestMapping("productEnrollForm.se")
	public String productEnrollForm() {
		return "user/seller/sellerUploadForm";
	}
	/**
	 * 상세페이지 내 파일첨부, 이미지 로컬 서버에 저장하고 상세페이지 영역에 노출
	 * @param request
	 * @param response
	 */
	@RequestMapping("fileUpload.se")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response){
	
		   try {
		        String sFileInfo = ""; // 파일정보
	
		        String fileName = request.getHeader("file-name"); // 일반 원본 파일명을 받아서 변수에 저장
	
		        String fileName_ext = fileName.substring(fileName.lastIndexOf(".")+1); // 파일 확장자
	
		        fileName_ext = fileName_ext.toLowerCase(); // 확장자를 소문자로 변경
	
		        String filePath = request.getSession().getServletContext().getRealPath("/resources/uploadFiles/"); // 서버에 파일 저장경로
	
		        File file = new File(filePath);
	
		        if(!file.exists()) {
		           file.mkdirs();
		        }
	
		        String realFileNm = "";
	
		        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	
		        String today= formatter.format(new java.util.Date());
	
		        realFileNm = today+UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf("."));
	
		        String rlFileNm = filePath + realFileNm;
	
		        ///////////////// 서버에 파일쓰기 ///////////////// 
		        InputStream is = request.getInputStream();
	
		        OutputStream os=new FileOutputStream(rlFileNm);
	
		        int numRead;
	
		        byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	
		        while((numRead = is.read(b,0,b.length)) != -1){
	
		           os.write(b,0,numRead);
		        }
	
		        if(is != null) {
		           is.close();
		        }
		        
		        os.flush();
		        os.close();
	
		        sFileInfo += "&bNewLine=true"; // 정보출력
		        
		        sFileInfo += "&sFileName="+ fileName;; // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
	
		        sFileInfo += "&sFileURL=http://localhost:8765/wemasal/resources/uploadFiles/"+realFileNm; // 삽입한 이미지가 저정된 경로
	
		        PrintWriter print = response.getWriter();
	
		        print.print(sFileInfo);
		        print.flush();
		        print.close();
	
		   } catch (Exception e) {// 예외처리
		       e.printStackTrace();
		   }
	}
	/**
	 * 상품업로드 (첨부파일 有, 상품등록 작업시 파일첨부 필수제약[상품썸네일 용도])
	 * @param p : 상품정보
	 * @param thumbnail : 첨부파일
	 * @param at : 첨부파일 데이터 가공목적 객체
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("uploadProduct.se")
	public String uploadProduct(Product p, MultipartFile thumbnail, Attachment at, HttpSession session, Model model) {
			
		String changeName = saveFile(thumbnail, session); // 파일명 변경하고 서버에 파일저장 후 변경한 파일명 반환받아서 변수에 저장
		
		at.setOriginName(thumbnail.getOriginalFilename()); // 파일 원본명 얻어서 세팅
		at.setChangeName("resources/uploadFiles/" + changeName); // 서버저장 용도로 변경한 파일명에 저장경로 붙여서 세팅
		
		int result1 = sellerService.uploadProduct(p); // 상품정보 업로드
		
		int result2 = sellerService.uploadAttachment(at); // 첨부파일 업로드
		
		if(result1 * result2 > 0) { // 상품등록 성공
			session.setAttribute("alertMsg", "상품등록 완료");
			return "redirect:sellerProductList.se";
		} else { // 상품등록 실패
			if(result2 < 0) {
				new File(changeName + at.getChangeName()).delete();
		}
			model.addAttribute("errorMsg", "상품등록 실패");
			return "common/errorPage";
		}
		
	}
	/**
	 * 상품업로드시 첨부파일(썸네일) 파일명 수정 후 서버에 업로드 기능
	 * @param thumbnail : 상품 대표이미지
	 * @param session
	 * @return
	 */
	public String saveFile(MultipartFile thumbnail, HttpSession session) {
		
		String originName = thumbnail.getOriginalFilename(); // 첨부파일의 원본명
					
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // "20220221153740"(년월일시분초)
		
		int ranNum = (int)(Math.random() * 90000 + 10000); // 12135(5자리 랜덤값)
		
		String ext = originName.substring(originName.lastIndexOf(".")); // 확장자
					
		String changeName = currentTime + ranNum + ext;
					
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/"); // 물리적인 경로 받아서 변수에 저장
					
	try {
		thumbnail.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	/**
	 * 상품삭제(상품 상태변경 Y -> N)
	 * @param pno : 삭제할 상품번호(식별 값)
	 * @return 
	 */
	@RequestMapping("deleteProduct.se")
	public String deleteProduct(int pno, String filePath, HttpSession session) {
		
		int result = sellerService.deleteProduct(pno);
		
		if(result > 0) { // 상품의 상태 변경에 성공하면,
			new File(session.getServletContext().getRealPath(filePath)).delete(); // 상품삭제 성공하면 첨부파일 서버에서 삭제
			session.setAttribute("alertMsg", "상품이 삭제 되었습니다.");
			return "redirect:sellerProductList.se"; // 상품리스트 조회 재요청
		} else { // 상품의 상태 변경에 실패하면,
			session.setAttribute("alertMsg", "error - 상품 삭제 실패");
			return "common/errorPage"; // 에러 페이지로 이동
		}
	}
	/**
	 * 수정할 상품 상세조회 후 상품정보 가지고 상품수정 화면으로 이동
	 * @param pno : 수정할 상품번호(식별 값)
	 * @param mv
	 * @return
	 */
	@RequestMapping("updateProductForm.se")
	public ModelAndView ProductUpdateForm(int pno, ModelAndView mv) {
		
		Customer c = customerService.selectSaladDetailView(pno);
		
		mv.addObject("c",c).setViewName("user/seller/productUpdateForm");
		
		return mv;
	}
	
	/**
	 * 상품수정
	 * @param p
	 * @param reThumbnail
	 * @param at
	 * @param originFilePath
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("updateProduct.se")
	public String updateProduct(Product p, MultipartFile reThumbnail, Attachment at, String originFilePath, Model model, HttpSession session) {
		
		if(!reThumbnail.getOriginalFilename().equals("")) { // 수정할 첨부파일(썸네일)이 있으면
			
			String changeName = saveFile(reThumbnail, session); // 파일명 변경하고 서버에 파일저장 후 변경한 파일명 반환받아서 변수에 저장
			
			at.setOriginName(reThumbnail.getOriginalFilename()); // 파일 원본명 얻어서 세팅
			at.setChangeName("resources/uploadFiles/" + changeName); // 서버저장 용도로 변경한 파일명에 저장경로 붙여서 세팅
			at.setProductNo(p.getProductNo()); // 수정할 파일이 참조할 상품번호 세팅
			
			sellerService.updateAttachment(at); //
			
			new File(session.getServletContext().getRealPath(originFilePath)).delete(); // 기존에 있던  썸네일은 서버에서 삭제
		}
		
		int result = sellerService.updateProduct(p); // 상품수정
		
		if(result > 0) { // 상품수정 성공
			session.setAttribute("alertMsg", "상품수정이 완료 되었습니다.");
			return "redirect:sellerProductList.se";
		} else { // 상품수정 실패
			model.addAttribute("errorMsg", "상품 수정 실패");
			return "common/errorPage";
		}
	}
	 
}

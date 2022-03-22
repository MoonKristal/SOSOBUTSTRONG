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
import com.sbs.wemasal.seller.model.service.SellerService;
import com.sbs.wemasal.seller.model.vo.Product;
import com.sbs.wemasal.member.model.vo.Member;


@Controller
public class SellerController {
	
	@Autowired
	private SellerService sellerService;
	
	/**
	 * 상품조회/수정 리스트에 등록된 상품들 리스트 보여주는 메소드 & 페이징처리
	 * @param currentPage
	 * @param mv
	 * @return
	 */
	@RequestMapping("sellerProductList.se")
	public ModelAndView selectList(@RequestParam(value="pPage", defaultValue="1")int currentPage, ModelAndView mv, HttpServletRequest request) {
		
		int uploader = ((Member)request.getSession().getAttribute("loginUser")).getUserNo(); // 로그인된 회원의 회원번호(식별자) 가져와서 변수에 담기
		
		int listCount = sellerService.selectProductCount(uploader); // 등록되어있는 상품 총 개수 조회
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		ArrayList<Product> list = sellerService.selectProduct(pi, uploader);
		
		mv.addObject("list",list).addObject("pi", pi).setViewName("user/seller/productList");
		
		return mv;
	}
	/**
	 * 상품등록 화면으로 이동시켜주는 메소드
	 * @return
	 */
	@RequestMapping("productEnrollForm.se")
	public String productEnrollForm() {
		return "user/seller/sellerUploadForm";
	}
	/**
	 * 상세페이지 이미지첨부, 이미지 로컬 서버에 저장하고 상세페이지 영역에 보여주는 메소드
	 * @param request
	 * @param response
	 */
	@RequestMapping("fileUpload.se")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response){
	
		   try {
		        //파일정보
		        String sFileInfo = "";
	
		        //파일명을 받는다 - 일반 원본파일명
		        String fileName = request.getHeader("file-name");
	
		        //파일 확장자
		        String fileName_ext = fileName.substring(fileName.lastIndexOf(".")+1);
	
		        //확장자를소문자로 변경
		        fileName_ext = fileName_ext.toLowerCase();
	
		        //파일 저장경로
		        String filePath = request.getSession().getServletContext().getRealPath("/resources/uploadFiles/");
	
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
	
		        // 정보 출력
		        sFileInfo += "&bNewLine=true";
	
		        // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
		        sFileInfo += "&sFileName="+ fileName;;
	
		        sFileInfo += "&sFileURL=http://localhost:8765/wemasal/resources/uploadFiles/"+realFileNm;
	
		        PrintWriter print = response.getWriter();
	
		        print.print(sFileInfo);
		        print.flush();
		        print.close();
	
		   } catch (Exception e) {
		       e.printStackTrace();
		   }
	}
	/**
	 * 
	 */
	@RequestMapping("uploadProduct.se")
	public String uploadProduct(Product p, MultipartFile thumbnail, Attachment at, HttpSession session, Model model) {
			
		String changeName = saveFile(thumbnail, session);
		
		at.setOriginName(thumbnail.getOriginalFilename());
		at.setChangeName("resources/uploadFiles/" + changeName);
		
		//System.out.println(p);
		//System.out.println(at);
		
		int result1 = sellerService.uploadProduct(p); // 상품정보 업로드
		
		int result2 = sellerService.uploadAttachment(at); // 첨부파일 업로드
		
		if(result1 * result2 > 0) { // 성공 => 게시글 리스트 페이지(boardListView.jsp) => list.bo
			session.setAttribute("alertMsg", "상품등록 완료");
			return "redirect:sellerProductList.se";
		} else {
			
			if(result2 < 0) {
				new File(changeName + at.getChangeName()).delete();
			}
			model.addAttribute("errorMsg", "상품등록 실패");
			return "common/errorPage";
		}
		
	}
	
	public String saveFile(MultipartFile thumbnail, HttpSession session) {
		// 파일명 수정 작업 후 서버에 업로드 시키기("bono.png" => 2022022115374012135.png")
		String originName = thumbnail.getOriginalFilename(); // 첨부파일의 원본명("bono.png")
					
		// "20220221153740"(년월일시분초)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		// 12135(5자리 랜덤값)
		int ranNum = (int)(Math.random() * 90000 + 10000);
		// 확장자
		String ext = originName.substring(originName.lastIndexOf("."));
					
		String changeName = currentTime + ranNum + ext;
					
		// 업로드 시키고자 하는 폴더의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
					
	try {
		thumbnail.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	 
	 
}

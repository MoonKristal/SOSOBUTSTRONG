package com.sbs.wemasal.seller.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.common.template.Pagination;
import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.order.model.vo.Order;
import com.sbs.wemasal.seller.model.service.SettlementService;
import com.sbs.wemasal.seller.model.vo.DailySales;

// 2022.3.25(금) 15h15
@Controller
public class SettlementController {
	
	@Autowired
	private SettlementService settlementService;
	
	@RequestMapping("overview.st")
	public String selectSettlementOverview() {
		return "user/seller/settlementOverview";
	}
	
	// 2022.3.25(금) 15h25 -> 2022.3.28(월) 15h55 기능 구현
	@ResponseBody
	@RequestMapping(value="refreshOverview.st", produces="application/json; charset=utf-8")
	public String ajaxRefreshSettlementOverview(int num, HttpServletRequest request) {
		int sellerNo = ((Member)request.getSession().getAttribute("loginUser")).getUserNo();
		
		// '매출 현황' 조회
		if (num == 1) {
			DailySales ds1 = settlementService.selectSalesOverview(sellerNo);
			
			return new Gson().toJson(ds1);
		} else { // num = 2 -> '매출 통계' 그래프 조회
			// 2022.3.28(월) 18h25
			HashMap<String, String> map = new HashMap<String, String>();
			
			// 2022.3.28(월) 20h Java의 정석 p.536 참고
			Calendar today = Calendar.getInstance(); // 기본적으로 현재 날짜와 시간으로 설정됨
			
			Calendar currentDate = Calendar.getInstance();
			currentDate.add(Calendar.DATE, -30); // 30일 전
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
//						String today = sdf.format(cal.getTime());
			/*
			for (int i = 0; i < 31; i++) {
				cal.add(cal.DATE, -i);
				String date = sdf.format(cal.getTime());
				System.out.println(date); // 18h40 나의 의도와 달리 1, 2, 3, 53, 5, 6, 7, 7, 8, 9, 10, 10, 12일 전 등으로 찍힘
				ArrayList<DailySales> list = settlementService.selectDailyNewOrders(sellerNo, date);
			}
			*/
			
			ArrayList<DailySales> list = new ArrayList();
			
			for (int n = 1; currentDate.before(today) || currentDate.equals(today); currentDate.add(Calendar.DATE, 1)) {
//							System.out.println(sdf.format(startDate.getTime())); // 20220226 ~ 20220328 31개 날짜 찍힘
				map.put("sellerNo", String.valueOf(sellerNo));
				map.put("currentDate", sdf.format(currentDate.getTime())); // 22h20 vo 클래스의 필드 자료형 String으로 바꿔서 넘김
				
				DailySales ds2 = settlementService.selectSalesGraph(map);
				list.add(ds2);
			}
			
			return new Gson().toJson(list);
		}
	}
	
	// 2022.3.28(월) 18h5
	/*
	@RequestMapping("refreshOverview.st")
	public String refreshSettlementOverview(int num) {
		return "redirect:overview.st";
	}
	*/
	
	// 2022.3.28(월) 20h30
//	 @RequestMapping("refreshGraph.st")
//	 public String
	
	// 2022.3.29(화) 0h55
	@RequestMapping("detail.st")
	public ModelAndView selectSettlementDetailList(@RequestParam(value="cpage", defaultValue="1") int currentPage, HttpSession session, ModelAndView mv) {
		int sellerNo = ((Member)session.getAttribute("loginUser")).getUserNo();
		
		// 요약 정보 조회
		Order o = settlementService.selectSettlementSummary(sellerNo);
		
		// 상세 내역 목록 조회 + 페이징 처리
		PageInfo pi = Pagination.getPageInfo(settlementService.selectSettlementDetailListCount(sellerNo), currentPage, 4, 15);
		
		ArrayList<Order> list = settlementService.selectSettlementDetailList(pi, sellerNo);
		
		mv.addObject("o", o).addObject("pi", pi).addObject("list", list).setViewName("user/seller/settlementDetailList");
		
		return mv;
	}
	
	// 2022.3.29(화) 2h35
	@RequestMapping("downloadExcel.st")
	public void downloadExcel(HttpSession session, HttpServletResponse response) throws IOException {
		// POI 라이브러리의 SXSSFWorkbook 객체를 OutpuStream을 통해 파일로 내보내는 것
		
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("정산 내역 상세 조회");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		
		// 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    // 가는 경계선을 가짐
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    // 배경색은 초록색
	    headStyle.setFillForegroundColor(HSSFColorPredefined.GREEN.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    // 데이터는 가운데 정렬
	    headStyle.setAlignment(HorizontalAlignment.CENTER);
	    
	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);
	    
	    // 헤더 생성: ORDER_NO, (SELLER,) PRODUCT_NAME, USER_ID, STATUS, DELIVERY_COMPLETE_DATE, SETTLEMENT_EXPECTED_DATE, SETTLEMENT_STATUS, ORDER_PRICE, FEE, SETTLEMENT_AMOUNT
	    row = sheet.createRow(rowNum++);

	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문번호");

	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("상품명");

	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("구매자");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문 상태");
	    
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("정산 기준일");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("정산 예정일");
	    
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("정산 상태");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("결제 금액");
	    
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("매출 연동 수수료");
	    
	    cell = row.createCell(9);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("정산 금액");
	    
	    int sellerNo = ((Member)session.getAttribute("loginUser")).getUserNo();
	    ArrayList<Order> list = settlementService.selectSettlementDetailList(sellerNo);
	    
	    // 데이터 부분 생성: ORDER_NO, (SELLER,) PRODUCT_NAME, USER_ID, STATUS, DELIVERY_COMPLETE_DATE, SETTLEMENT_EXPECTED_DATE, SETTLEMENT_STATUS, ORDER_PRICE, FEE, SETTLEMENT_AMOUNT
	    for (Order o : list) {
	    	row = sheet.createRow(rowNum++);

	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getOrderNo());
	        
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getProductName());
	        
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getOrderer());
	        
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getStatus());
	        
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getDeliveryCompleteDate());
	        
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getSettlementExpectedDate());
	        
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getSettlementStatus());
	        
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getOrderPrice());
	        
	        cell = row.createCell(8);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getFee());
	        
	        cell = row.createCell(9);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(o.getSettlementAmount());
	    }
	    
	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=wemasalSettleDetailList.xlsx");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	} // downloadExcel() 영역 끝 -> 3h20 테스트 완료
	
	
	

}

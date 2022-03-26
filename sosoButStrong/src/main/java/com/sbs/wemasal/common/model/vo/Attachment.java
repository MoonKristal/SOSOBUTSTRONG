package com.sbs.wemasal.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attachment {
	
	private int fileNo; // 첨부파일 번호
	private String originName; // 원본 파일명
	private String changeName; // 수정 파일명
	private String uploadDate; // 업로드 날짜
	private int userNo; // 회원번호
	private int productNo; // 상품번호
	private int mainFileNo; // 메인페이지번호
	private int refCno; // 커뮤니티 글 번호
	private int refRno; // 리뷰번호
	private int refNno; // 공지글 번호
	private int refQno; // 문의글 번호
	private int refAno; // 답변글 번호
	
}

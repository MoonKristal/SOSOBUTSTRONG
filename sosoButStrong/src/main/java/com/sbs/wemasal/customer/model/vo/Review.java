package com.sbs.wemasal.customer.model.vo;

public class Review { // 상품리뷰 관련 가공 용도 VO
	
	private int reviewNo; //	REVIEW_NO	NUMBER
	private int refPno; //	REF_PNO	NUMBER
	private int reviewWriter; //	REVIEW_WRITER	NUMBER
	private String reviewContent; //	REVIEW_CONTENT	VARCHAR2(4000 BYTE)
	private String createDate; //	CREATE_DATE	DATE
	private String modifyDate; //	MODIFY_DATE	DATE
	private int score; //	SCORE	NUMBER
	private String status; //	STATUS	VARCHAR2(1 BYTE)
	
	private String userNo; // 리뷰 작성한 회원번호
	private String userId; // 리뷰 작성한 회원아이디
	private String changeName; // 상품등록 시 첨부한 썸네일 저장경로
	private String originName; // 상품등록 시 첨부한 썸네일 원본명
	
	public Review() {
		super();
	}

	public Review(int reviewNo, int refPno, int reviewWriter, String reviewContent, String createDate,
			String modifyDate, int score, String status, String userNo, String userId, String changeName,
			String originName) {
		super();
		this.reviewNo = reviewNo;
		this.refPno = refPno;
		this.reviewWriter = reviewWriter;
		this.reviewContent = reviewContent;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.score = score;
		this.status = status;
		this.userNo = userNo;
		this.userId = userId;
		this.changeName = changeName;
		this.originName = originName;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getRefPno() {
		return refPno;
	}

	public void setRefPno(int refPno) {
		this.refPno = refPno;
	}

	public int getReviewWriter() {
		return reviewWriter;
	}

	public void setReviewWriter(int reviewWriter) {
		this.reviewWriter = reviewWriter;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", refPno=" + refPno + ", reviewWriter=" + reviewWriter
				+ ", reviewContent=" + reviewContent + ", createDate=" + createDate + ", modifyDate=" + modifyDate
				+ ", score=" + score + ", status=" + status + ", userNo=" + userNo + ", userId=" + userId
				+ ", changeName=" + changeName + ", originName=" + originName + "]";
	}
}

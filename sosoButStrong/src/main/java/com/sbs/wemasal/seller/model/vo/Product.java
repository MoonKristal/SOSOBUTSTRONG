package com.sbs.wemasal.seller.model.vo;

public class Product { // 상품등록 시 상품정보 가공 용도 VO
	
	private int productNo; //PRODUCT_NO	NUMBER 상품번호
	private int uploader; //UPLOADER	NUMBER 작성자
	private String productName; //PRODUCT_NAME	VARCHAR2(500 BYTE) 상품명
	private String sellStatus; // VARCHAR2(5 BYTE) 판매상태  ON-> 판매중 / OFF-> 판매중지 / SO-> 일시품절,솔드아웃
	private int price; //PRICE	NUMBER 상품가격
	private String description; //DESCRIPTION	VARCHAR2(4000 BYTE) 상품설명(상세페이지)
	private String option; //OPTION	VARCHAR2(4000 BYTE) 상품옵션(구매옵션)
	private String pTag; // VARCHAR2(4000 BYTE) 상품태그
	private String createDate; //CREATE_DATE	DATE 상품등록일
	private String modifyDate; //MODIFY_DATE	DATE 상품수정일
	private String status; //STATUS	VARCHAR2(1 BYTE) 상품상태
	
	private String sellerName; // 상품등록한 판매자 명
	private String changeName; // 상품등록 시 첨부한 썸네일 저장경로
	
	public Product() {
		super();
	}

	public Product(int productNo, int uploader, String productName, String sellStatus, int price, String description,
			String option, String pTag, String createDate, String modifyDate, String status, String sellerName,
			String changeName) {
		super();
		this.productNo = productNo;
		this.uploader = uploader;
		this.productName = productName;
		this.sellStatus = sellStatus;
		this.price = price;
		this.description = description;
		this.option = option;
		this.pTag = pTag;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.status = status;
		this.sellerName = sellerName;
		this.changeName = changeName;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getUploader() {
		return uploader;
	}

	public void setUploader(int uploader) {
		this.uploader = uploader;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getSellStatus() {
		return sellStatus;
	}

	public void setSellStatus(String sellStatus) {
		this.sellStatus = sellStatus;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public String getpTag() {
		return pTag;
	}

	public void setpTag(String pTag) {
		this.pTag = pTag;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	@Override
	public String toString() {
		return "Product [productNo=" + productNo + ", uploader=" + uploader + ", productName=" + productName
				+ ", sellStatus=" + sellStatus + ", price=" + price + ", description=" + description + ", option="
				+ option + ", pTag=" + pTag + ", createDate=" + createDate + ", modifyDate=" + modifyDate + ", status="
				+ status + ", sellerName=" + sellerName + ", changeName=" + changeName + "]";
	}
}

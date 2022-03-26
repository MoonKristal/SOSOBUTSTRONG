package com.sbs.wemasal.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString	
public class Member {
	private int userNo;          // USER_NO	NUMBER
	private int userType; 	 	 //	USER_TYPE	NUMBER	No
	private String userId; 		 //	USER_ID	VARCHAR2(20 BYTE)	No
	private String userPwd;		 //	PASSWORD	VARCHAR2(20 BYTE)	No
	private String userName; 	 //	USER_NAME	VARCHAR2(20 BYTE)	No
	private String email; 	     //	EMAIL	VARCHAR2(50 BYTE)	No
	private String phone; 		 //	PHONE	VARCHAR2(13 BYTE)	No
	private String address; 	 //	ADDRESS	VARCHAR2(100 BYTE)	Yes
	private String gender;  	 //	GENDER	VARCHAR2(1 BYTE)	Yes
	private String birth;	 	     //	BIRTH	DATE	Yes
	private int point; 		 	 //	POINT	NUMBER	Yes
	private String status;	 	 //	STATUS	VARCHAR2(1 BYTE)	No

}

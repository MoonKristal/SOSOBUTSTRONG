package com.sbs.wemasal.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@Builder 
@NoArgsConstructor
@AllArgsConstructor
public class Cert {
   private String who; // 누구
   private String secret; // 인증번호
   private String when; //언제
}


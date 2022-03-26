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
   private String ipInfo;
   private String veriCode; 
   private Date certTime;
}
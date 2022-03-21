package com.sbs.wemasal.community.model.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SmarteditorVO {
	
	private MultipartFile filedata;
	private String callback;
	private String callback_func;
	
}

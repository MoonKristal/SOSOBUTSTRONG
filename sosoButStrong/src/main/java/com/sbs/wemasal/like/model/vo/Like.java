package com.sbs.wemasal.like.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Like {
	
	private int likeNo;
	private int userNo;
	private int comNo;
	private String myLike;
	private int likeCount;
	
}

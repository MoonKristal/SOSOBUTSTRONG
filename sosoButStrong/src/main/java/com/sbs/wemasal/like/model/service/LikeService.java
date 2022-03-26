package com.sbs.wemasal.like.model.service;

import com.sbs.wemasal.like.model.vo.Like;

public interface LikeService {
	
	// 좋아요 삭제(♥ -> ♡)
	int deleteLike(Like l);

	// 좋아요 추가 (♡ -> ♥)
	int insertLike(Like l);

}

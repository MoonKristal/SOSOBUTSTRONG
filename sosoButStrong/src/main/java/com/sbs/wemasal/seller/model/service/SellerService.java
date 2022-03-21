package com.sbs.wemasal.seller.model.service;

import org.springframework.stereotype.Service;

import com.sbs.wemasal.member.model.vo.Member;
import com.sbs.wemasal.seller.model.vo.Seller;

@Service
public interface SellerService {

	int insertSeller(Member m, Seller s);

	int sellerNameCheck(String checkName);

}

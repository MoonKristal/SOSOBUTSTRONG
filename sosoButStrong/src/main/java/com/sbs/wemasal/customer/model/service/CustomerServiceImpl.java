package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.customer.model.dao.CustomerDao;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;
import com.sbs.wemasal.member.model.vo.Seller;

@Service
public class CustomerServiceImpl implements CustomerService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CustomerDao customerDao;

	@Override
	public ArrayList<Customer> selectSaladList() {
		return customerDao.selectSaladList(sqlSession);
	}

	@Override
	public Customer selectSaladDetailView(int productNo) {
		return customerDao.selectSaladDetailView(sqlSession, productNo);
	}

	@Override
	public ArrayList<Review> selectProductReviewList(int productNo) {
		return customerDao.selectProductReviewList(sqlSession, productNo);
	}

	@Override
	public ArrayList<Review> selectMyReviewList(int userNo) {
		return customerDao.selectMyReviewList(sqlSession, userNo);
	}

	@Override
	public int deleteReview(int ReviewNo) {
		return customerDao.deleteReview(sqlSession, ReviewNo);
	}

	@Override
	public Review selectReviewForUpdate(int ReviewNo) {
		return customerDao.selectReviewForUpdate(sqlSession, ReviewNo);
	}

	@Override
	public int updateAttachment(Attachment at) {
		return customerDao.updateAttachment(sqlSession, at);
	}

	@Override
	public int updateReview(Review r) {
		return customerDao.updateReview(sqlSession, r);
	}

	@Override
	public int uploadReview(Review r) {
		return customerDao.uploadReview(sqlSession, r);
	}

	@Override
	public int uploadAttachment(Attachment at) {
		return customerDao.uploadAttachment(sqlSession, at);
	}

	@Override
	public ArrayList<Cart> selectMyCart(int userNo) {
		return customerDao.selectMyCart(sqlSession, userNo);
	}

	@Override
	public int addToCart(Cart c) {
		return customerDao.addToCart(sqlSession, c);
	}

	@Override
	public int deleteCart(int cartNo) {
		return customerDao.deleteCart(sqlSession, cartNo);
	}

	@Override
	public ArrayList<Seller> selectTop3SellerList() {
		return customerDao.selectTop3SellerList(sqlSession);
	}

}

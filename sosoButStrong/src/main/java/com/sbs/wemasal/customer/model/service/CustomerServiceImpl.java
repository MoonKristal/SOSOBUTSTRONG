package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.customer.model.dao.CustomerDao;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;

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

}

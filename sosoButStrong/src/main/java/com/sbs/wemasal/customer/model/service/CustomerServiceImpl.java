package com.sbs.wemasal.customer.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}

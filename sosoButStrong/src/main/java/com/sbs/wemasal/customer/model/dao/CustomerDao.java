package com.sbs.wemasal.customer.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;

@Repository
public class CustomerDao {

	public ArrayList<Customer> selectSaladList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("customerMapper.selectSaladList");
	}

	public Customer selectSaladDetailView(SqlSessionTemplate sqlSession, int productNo) {
		return sqlSession.selectOne("customerMapper.selectSaladDetailView", productNo);
	}

	public ArrayList<Review> selectProductReviewList(SqlSessionTemplate sqlSession, int productNo) {
		return (ArrayList)sqlSession.selectList("customerMapper.selectProductReviewList", productNo);
	}
	

}

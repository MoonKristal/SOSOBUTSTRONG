package com.sbs.wemasal.customer.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.customer.model.vo.Customer;

@Repository
public class CustomerDao {

	public ArrayList<Customer> selectSaladList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("customerMapper.selectSaladList");
	}

	public Customer selectSaladDetailView(SqlSessionTemplate sqlSession, int pno) {
		return sqlSession.selectOne("customerMapper.selectSaladDetailView", pno);
	}
	

}

package com.sbs.wemasal.customer.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.customer.model.vo.Customer;
import com.sbs.wemasal.customer.model.vo.Review;
import com.sbs.wemasal.member.model.vo.Seller;

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

	public ArrayList<Review> selectMyReviewList(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("customerMapper.selectMyReviewList", userNo);
	}

	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.update("customerMapper.deleteReview", reviewNo);
	}

	public Review selectReviewForUpdate(SqlSessionTemplate sqlSession, int reviewNo) {
		return sqlSession.selectOne("customerMapper.selectReviewForUpdate", reviewNo);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.update("customerMapper.updateAttachment", at);
	}

	public int updateReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.update("customerMapper.updateReview", r);
	}

	public int uploadReview(SqlSessionTemplate sqlSession, Review r) {
		return sqlSession.insert("customerMapper.uploadReview", r);
	}

	public int uploadAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("customerMapper.uploadAttachment", at);
	}

	public ArrayList<Cart> selectMyCart(SqlSessionTemplate sqlSession, int userNo) {
		return (ArrayList)sqlSession.selectList("customerMapper.selectMyCart", userNo);
	}

	public int addToCart(SqlSessionTemplate sqlSession, Cart c) {
		return sqlSession.insert("customerMapper.addToCart", c);
	}

	public int deleteCart(SqlSessionTemplate sqlSession, int cartNo) {
		return sqlSession.delete("customerMapper.deleteCart", cartNo);
	}

	public ArrayList<Seller> selectTop3SellerList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("customerMapper.selectTop3SellerList");
	}
	

}

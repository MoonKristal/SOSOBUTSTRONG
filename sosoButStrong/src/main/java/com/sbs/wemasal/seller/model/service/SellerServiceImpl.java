package com.sbs.wemasal.seller.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.seller.model.dao.SellerDao;
import com.sbs.wemasal.seller.model.vo.Product;

@Service
public class SellerServiceImpl implements SellerService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private SellerDao sellerDao;
	
	@Override
	public int selectProductCount(int uploader) {
		return sellerDao.selectProductCount(sqlSession, uploader);
	}

	@Override
	public ArrayList<Product> selectProduct(PageInfo pi, int uploader) {
		return sellerDao.selectProduct(sqlSession, pi, uploader);
	}

	@Override
	public int uploadProduct(Product p) {
		
		return sellerDao.uploadProduct(sqlSession, p);
	}
	
	@Override
	public int uploadAttachment(Attachment at) {
		
		return sellerDao.uploadAttachment(sqlSession, at);
	}

	@Override
	public int deleteProduct(int pno) {
		return sellerDao.deleteProduct(sqlSession, pno);
	}

	@Override
	public int updateProduct(Product p) {
		return sellerDao.updateProduct(sqlSession, p);
	}

	@Override
	public int updateAttachment(Attachment at) {
		return sellerDao.updateAttachment(sqlSession, at);
	}

}

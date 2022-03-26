package com.sbs.wemasal.seller.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.sbs.wemasal.common.model.vo.Attachment;
import com.sbs.wemasal.common.model.vo.PageInfo;
import com.sbs.wemasal.seller.model.vo.Product;

@Repository
public class SellerDao {
	
	public int selectProductCount(SqlSessionTemplate sqlSession, int uploader) {
		return sqlSession.selectOne("sellerMapper.selectProductCount", uploader);
	}

	public ArrayList<Product> selectProduct(SqlSessionTemplate sqlSession, PageInfo pi, int uploader) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("sellerMapper.selectProduct", uploader, rowBounds);
	}

	public int uploadAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.insert("sellerMapper.uploadAttachment", at);
	}

	public int uploadProduct(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.insert("sellerMapper.uploadProduct", p);
	}

	public int deleteProduct(SqlSessionTemplate sqlSession, int pno) {
		return sqlSession.update("sellerMapper.deleteProduct", pno);
	}

	public int updateProduct(SqlSessionTemplate sqlSession, Product p) {
		return sqlSession.update("sellerMapper.updateProduct", p);
	}

	public int updateAttachment(SqlSessionTemplate sqlSession, Attachment at) {
		return sqlSession.update("sellerMapper.updateAttachment", at);
	}

}

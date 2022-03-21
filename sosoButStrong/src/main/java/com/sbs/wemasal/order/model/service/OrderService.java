package com.sbs.wemasal.order.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.wemasal.cart.model.vo.Cart;
import com.sbs.wemasal.order.model.vo.Order;

public interface OrderService {	

	ArrayList<Cart> selectCart(int userNo);

	int insertOrder(Map<String, Object> map);

	

}

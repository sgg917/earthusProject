package com.us.order.model.dao;

import static com.us.common.JDBCTemplate.*;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.us.order.model.vo.Order;
import com.us.product.model.dao.ProductDao;

public class OrderDao {

	private Properties prop = new Properties();
	
	public OrderDao() {
		try {
			prop.loadFromXML(new FileInputStream( ProductDao.class.getResource("/db/sql/order-mapper.xml").getPath() ));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	// 주문내역 조회
	public ArrayList<Order> selectOrderList(Connection conn, int userNo) {
		ArrayList<Order> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOrderList");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Order(rset.getInt("order_no"),
								   rset.getInt("payment_amount"),
								   rset.getInt("del_status"),
								   rset.getInt("product_count"),
								   rset.getString("pro_code"),
								   rset.getString("pro_name"),
								   rset.getDate("order_date")
						));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
		
	}
	
	// 주문 상세 조회
	public ArrayList<Order> selectOrder(Connection conn, int orderNo){
		ArrayList<Order> olist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectOrder");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orderNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				olist.add(new Order(rset.getInt("order_no"),
						 		   rset.getString("payment"),
						 		   rset.getInt("points_used"),
						 		   rset.getString("shp_memo"),
						 		   rset.getInt("payment_amount"),
						 		   rset.getString("del_name"),
						 		   rset.getString("del_phone"),
						 		   rset.getString("del_zonecode"),
						 		   rset.getString("del_address"),
						 		   rset.getString("del_addr_detail"),
						 		   rset.getInt("del_status"),
						 		   rset.getString("pro_name"),
						 		   rset.getDate("order_date"),
						 		   rset.getString("pro_img_path"),
						 		   rset.getInt("price"),
						 		   rset.getInt("quantity"),
						 		   rset.getString("zonecode"),
						 		   rset.getString("user_name"),
						 		   rset.getString("phone"),
						 		   rset.getString("address"),
						 		   rset.getString("addr_detail")
						 		   
						));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return olist;
	}
	
	// 취소/교환/반품 페이지
	public ArrayList<Order> selectCeList(Connection conn, int userNo){
		ArrayList<Order> celist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectCeList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				celist.add(new Order(rset.getInt("order_no"),
									 rset.getInt("del_status"),
									 rset.getString("pro_name"),
									 rset.getDate("order_date"),
									 rset.getString("pro_img_path"),
									 rset.getInt("price"),
									 rset.getInt("quantity")
						));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return celist;
	}
}

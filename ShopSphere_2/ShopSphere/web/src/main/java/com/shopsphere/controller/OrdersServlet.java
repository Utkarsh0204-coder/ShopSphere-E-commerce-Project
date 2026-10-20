package com.shopsphere.controller;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
 @Override protected void doGet(HttpServletRequest req,HttpServletResponse resp)throws ServletException,IOException {
  User user=(User)req.getSession().getAttribute("user"); List<Map<String,Object>> orders=new ArrayList<>();
  try(Connection c=DBConnection.getConnection(); PreparedStatement p=c.prepareStatement("SELECT order_id,total_amount,payment_method,payment_status,order_status,created_at FROM orders WHERE user_id=? ORDER BY created_at DESC")){
   p.setInt(1,user.getUserId()); try(ResultSet r=p.executeQuery()){while(r.next()){Map<String,Object> row=new LinkedHashMap<>(); row.put("orderId",r.getInt("order_id"));row.put("total",r.getBigDecimal("total_amount"));row.put("paymentMethod",r.getString("payment_method"));row.put("paymentStatus",r.getString("payment_status"));row.put("status",r.getString("order_status"));row.put("createdAt",r.getTimestamp("created_at"));orders.add(row);}}
   req.setAttribute("orders",orders);req.getRequestDispatcher("/orders.jsp").forward(req,resp);
  }catch(Exception e){throw new ServletException("Unable to load orders",e);}
 }
}

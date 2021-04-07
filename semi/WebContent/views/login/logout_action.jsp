<%@page import="dao.member.MemberDTO"%>
<%@page import="dao.common.CommonDAO"%>
<%@page import="dao.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%
	request.getSession().setAttribute("LOGIN_ID", null);
	request.getSession().setAttribute("LOGIN_STAUTS", null);
	
	response.sendRedirect("/views/webtoon/webtoon.jsp");
%>
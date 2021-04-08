<%@page import="dao.member.MemberDTO"%>
<%@page import="dao.common.CommonDAO"%>
<%@page import="dao.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%!
public void setReturn(String isOk, String msg, HttpServletResponse response) {
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("msg", msg);
	jsonObject.put("isOk", isOk);
	
	try{
		response.getWriter().write(jsonObject.toString());		
	}catch(Exception e){
		System.out.println(e.getMessage());
	}	
}
%>
<%
	String msg = "";
	String type = "";
	String isOk = "";
	String member_id = request.getParameter("id");
	String member_pw = request.getParameter("password");
	
	//DAO
	CommonDAO commonDAO = new CommonDAO();
	MemberDAO memberDAO = new MemberDAO();

	//DTO
	MemberDTO memberDTO = new MemberDTO();
	
	//param check
	if(member_id == null || member_pw == null){
		msg = "데이터 오류";
		isOk = "N";
		
		setReturn(isOk, msg, response);
	}else{
		//PW 암호화 
		member_pw = commonDAO.encryptSHA256(member_pw);
		
		memberDTO.setMember_id(member_id);
		memberDTO.setMember_pw(member_pw);
		
		String member_type = "";
		member_type = memberDAO.getMemberType(member_id);
		
		if(member_type.equals("")){
			type = "TYPE_ERROR";
			isOk = "N";
			response.sendRedirect("login.jsp?type=" + type + "&isOk=" + isOk);
		}
		
		
		int chkID = memberDAO.chkMember(memberDTO);
		
		if(chkID == 0){
			type = "ID_ERROR";
			isOk = "N";
			response.sendRedirect("login.jsp?type=" + type + "&isOk=" + isOk);
		}else{
			int chkPW = memberDAO.chkPW(memberDTO);
			
			if(chkPW == 0){
				type = "PW_ERROR";
				isOk = "N";
				response.sendRedirect("login.jsp?type=" + type + "&isOk=" + isOk);
				
			}else{
				isOk = "Y";
				request.getSession().setAttribute("LOGIN_ID", memberDTO.getMember_id());
				request.getSession().setAttribute("LOGIN_STATUS", "Y");
				request.getSession().setAttribute("LOGIN_TYPE", member_type);
				response.sendRedirect("/views/webtoon/webtoon.jsp?isOk=" + isOk);
				
			}
		}
	}
	
	
	

%>
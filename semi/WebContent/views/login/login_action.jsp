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
	
	out.println("member_id : " + member_id);
	out.println("<br/>");
	out.println("member_pw : " + member_pw);
	
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
		
		int chkID = memberDAO.chkMember(memberDTO);
		
		if(chkID == 0){
			type = "ID_ERROR";
// 			msg = "ID가 존재하지 않습니다.";
			isOk = "N";
			response.sendRedirect("login.jsp?type=" + type + "&isOk=" + isOk);
		}else{
			int chkPW = memberDAO.chkPW(memberDTO);
			
			if(chkPW == 0){
				type = "PW_ERROR";
// 				msg = "비밀번호가 일치하지 않습니다. 다시 입력해주세요.";
				isOk = "N";
				response.sendRedirect("login.jsp?type=" + type + "&isOk=" + isOk);
				
			}else{
// 				type = "";
// 				msg = "로그인에 성공했습니다.";
				isOk = "Y";
				request.getSession().setAttribute("LOGIN_ID", memberDTO.getMember_id());
				request.getSession().setAttribute("LOGIN_STATUS", "Y");
				response.sendRedirect("/views/webtoon/webtoon.jsp?isOk=" + isOk);
			}
		}
	}
	
	
	

%>
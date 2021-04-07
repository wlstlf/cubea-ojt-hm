<%@page import="dao.common.CommonDAO"%>
<%@page import="dao.member.MemberDTO"%>
<%@page import="dao.member.MemberDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	//response
	String type = "";
	String isOk = "";
	String msg 	= "";
	
	//parameter
	String member_type = "";
	String member_name = "";
	String member_id = "";
	String member_email = "";
	String member_pw = "";
	
	if(request.getParameter("type") != null) 	 member_type = request.getParameter("type");
	if(request.getParameter("name") != null) 	 member_name = request.getParameter("name");
	if(request.getParameter("id") != null) 		 member_id = request.getParameter("id");
	if(request.getParameter("email") != null) 	 member_email = request.getParameter("email");
	if(request.getParameter("password") != null) member_pw = request.getParameter("password");
	
	//DTO
	MemberDTO memberDTO = new MemberDTO();
	
	memberDTO.setMember_type(member_type);
	memberDTO.setMember_name(member_name);
	memberDTO.setMember_id(member_id);
	memberDTO.setMember_email(member_email);
	
	//비밀번호 암호화
	CommonDAO commonDAO = new CommonDAO();
	
	if(!member_pw.equals("")){
		member_pw = commonDAO.encryptSHA256(member_pw);
	}
	
	memberDTO.setMember_pw(member_pw);
	
	//DAO
	MemberDAO memberDAO = new MemberDAO();
	
	int result = 0;	
	int chkMember = memberDAO.chkMember(memberDTO);
	
	//ID 중복체크
	if(member_name.equals("") && !member_id.equals("")){
		if(chkMember > 0){
			isOk = "N";
			msg  = "ID가 중복되었습니다. 다른 ID를 입력해주세요.";
			setReturn(isOk, msg, response);			
		}else{
			isOk = "Y";
			msg  = "사용 가능한 ID입니다.";
			setReturn(isOk, msg, response);
		}
	}	
	
	if(!member_name.equals("") && !member_id.equals("")){
		//등록 후 Process
		if(chkMember > 0){
			//ID 중복시
			type = "A";
			isOk = "N";
			msg  = "ID가 중복되었습니다.";
			response.sendRedirect("register.jsp?type=" + type + "&isOk=" + isOk);
	// 		setReturn(isOk, msg, response);
		}else{
			//등록 성공시
			memberDAO.setMember(memberDTO);
			isOk = "Y";
			msg = "등록에 성공하였습니다.";
	// 		setReturn(isOk, msg, response);
			response.sendRedirect("login.jsp?isOk=" + isOk);
		}
	}
	
	
	
	
	
	
%>

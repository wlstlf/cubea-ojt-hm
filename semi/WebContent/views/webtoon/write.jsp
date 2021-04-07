<%@page import="dao.webtoon.WebtoonDAO"%>
<%@page import="dao.webtoon.WebtoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/views/inc/common.jsp"%>
<%
	String session_login_id = (String) request.getSession().getAttribute("LOGIN_ID");	
	String session_login_status = (String) request.getSession().getAttribute("LOGIN_STATUS");
	
	//변수 선언
	String act = "I";
	
	String webtoon_idx		 = "";
	String webtoon_title	 = "";
	String webtoon_summary	 = "";
	String webtoon_content	 = "";
	String webtoon_author	 = session_login_id;
	String thum				 = "";
	String use_yn 			 = "";
	String use_yn_str		 = "";
	String sv_name			 = "";
	
	
	
	//null 처리
	if(request.getParameter("webtoon_idx") != null) 	webtoon_idx = request.getParameter("webtoon_idx"); 
	
	//DAO
	WebtoonDAO webtoonDAO = new WebtoonDAO();
	if(!webtoon_idx.equals("")){
		act = "U";
		
		//DTO
		WebtoonDTO webtoonDTO = new WebtoonDTO();
		
		//DAO
		webtoonDTO = webtoonDAO.getWebtoon(webtoon_idx);
		
		if(webtoonDTO != null){
			if(webtoonDTO.getWebtoon_title() != null) 	webtoon_title 	 = webtoonDTO.getWebtoon_title();
			if(webtoonDTO.getWebtoon_summary() != null) webtoon_summary	 = webtoonDTO.getWebtoon_summary();
			if(webtoonDTO.getWebtoon_content() != null) webtoon_content	 = webtoonDTO.getWebtoon_content();
			if(webtoonDTO.getWebtoon_author() != null) 	webtoon_author	 = webtoonDTO.getWebtoon_author();
			if(webtoonDTO.getThum() != null) 			thum			 = webtoonDTO.getThum();
			if(webtoonDTO.getUse_yn() != null) 			use_yn 			 = webtoonDTO.getUse_yn();
			if(webtoonDTO.getSv_name() != null) 		sv_name			 = webtoonDTO.getSv_name();
		}
	}
	
	//isOk, msg
	String isOk = "";
	String type  = "";
	
	if(request.getParameter("isOk") != null)  isOk = request.getParameter("isOk"); 
	if(request.getParameter("type") != null)  type = request.getParameter("type");
	
%>
<!DOCTYPE html>
<html>
<link href="http://netdna.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="/res/css/base.css">
<head>
<style type="text/css">
html, body{
     color: #8e9194; 
     background-color: #f4f6f9; 
}
.avatar-xl img {
    width: 110px;
}
.rounded-circle {
    border-radius: 50% !important;
}
img {
    vertical-align: middle;
    border-style: none;
}
.text-muted {
    color: #aeb0b4 !important;
}
.text-muted {
    font-weight: 300;
}
.form-control {
    display: block;
    width: 100%;
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
    font-weight: 400;
    line-height: 1.5;
    color: #4d5154;
    background-color: #ffffff;
    background-clip: padding-box;
    border: 1px solid #eef0f3;
    border-radius: 0.25rem;
    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}
</style>
<script type="text/javascript">
	let webtoon_idx = "<%=webtoon_idx %>";
	let isOk = "<%=isOk %>"; 
	let type = "<%=type %>"; 
		
	$(document).ready(function(){	
		
		if(isOk == "Y"){
			if(type == "SET_SUCC"){
				alert("등록에 성공하였습니다.");
				webtoon_idx = getParameter("webtoon_idx");
				location.href = "./write.jsp?webtoon_idx=" + webtoon_idx;
			}else if(type == "MOD_SUCC"){				
				alert("수정에 성공하였습니다.");
				webtoon_idx = getParameter("webtoon_idx");
				location.href = "./write.jsp?webtoon_idx=" + webtoon_idx;
			}
		}else{
			if(type == "SET_FAIL"){
				alert("등록에 실패하였습니다.");				
				location.href = "./write.jsp";
				
			}else if(type == "MOD_FAIL"){
				alert("수정에 실패하였습니다.");
				location.href = "./write.jsp?webtoon_idx=" + webtoon_idx;
			}
		}
	});

	function setForm(){
// 		if($("#webtoon_title").val() == ""){
// 			alert("제목을 입력해주세요.");
// 			$("#webtoon_title").focus();
// 			return false;
// 		}
// 		if($("#webtoon_content").val() == ""){
// 			alert("내용을 입력해주세요.");
// 			$("#webtoon_content").focus();
// 			return false;
// 		}
			
		$("#writeForm").submit();
	}
	
	function getParameter(name){
		name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    	return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	
	function delThum(){
		let data_ = {
			 webtoon_idx : "<%=webtoon_idx %>"
			,act : "delThum"
			,sv_name : "<%=sv_name %>"
		}
		
		$.ajax({
			type : "POST"
			,url : "./write_action.jsp"
			,data : data_			
			,success : function(result){
				var data = result.jsonObj;
				console.log(data);
				alert("삭제되었습니다.");
				$("#div_thum").hide();
			}
			,error : function(request, status, error){
				console.log("code : " + request.status + "\n" + "message :" + request.responseText + "\n" + "error : " + error);
				alert("오류가 발생했습니다. \n다시 시도해주세요.");
				return false;
			}
		});
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container bootstrap snippets bootdey m-auto">
	<%@ include file="../inc/top.jsp" %>
	<div class="row justify-content-center">
	    <div class="col-lg-12">
	        <h2 class="h3 mb-4 page-title">write</h2>
	        <div class="my-4">
	            <form enctype="multipart/form-data" class="form-horizontal" id="writeForm" name="writeForm" action="./write_action.jsp?act=<%=act %>" method="post">
	            <input type ="hidden" id="webtoon_idx" name="webtoon_idx" value="<%=webtoon_idx %>" />
	                <hr class="my-4" />
	                <div class="form-group">
                        <label for="webtoon_title">제목</label>
                        <input type="text" class="form-control" id="webtoon_title" name="webtoon_title" style="height:40px" value="<%=webtoon_title %>"/>
	                </div>
	                <div class="form-group">
                        <label for="firstname">요약</label>
                        <textarea class="form-control" id="webtoon_summary" name="webtoon_summary" style="height: 200px"><%=webtoon_summary %></textarea>
	                </div>
	                <div class="form-group">
                        <label for="firstname">내용</label>
                        <textarea class="form-control" id="webtoon_content" name="webtoon_content" style="height: 200px"><%=webtoon_content %></textarea>
	                </div>
	                <div class="form-group">
                        <label for="firstname">작성자</label>
                        <input type="text" class="form-control" id="webtoon_author" name="webtoon_author" style="height:40px" value="<%=webtoon_author%>" readonly/>
	                </div>
	                <div class="form-group">
	                	<label for="firstname">썸네일 이미지</label><br/>
<%
	if(!thum.equals("")){
%>	                	
					<div id="div_thum">
	                	<label for="secondname">현재 썸네일 : <%=thum %></label>&nbsp;&nbsp;&nbsp;
	                	<img src="/upload/<%=thum %>" width=600px>
	                	<button type="button" class="btn btn-sm btn-danger" onclick="delThum();">삭제하기</button><br/><br/>
	                </div>	
<%
	}
%>	                	
	                	
	                	<div class="spinner-border text-primary" role="status">
	                        <span class="visually-hidden">* 이미지 권장 사이즈 : 600 * 400</span>
	                	</div>
                        <br/>
	  				    <input class="form-control" type="file" id="thum" name="thum">
	                </div>
	                <div class="form-group">
	                	<label for="firstname">사용 여부</label>
<%
	if(webtoon_idx.equals("")){
		
%>	    
						<label><input type="radio" id="use_y" name="use_yn" value="Y" checked/>&nbsp;사용</label>&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="use_n" name="use_yn" value="N" />&nbsp;미사용</label>
<%
	}else{
%>
                    	<label><input type="radio" id="use_y" name="use_yn" value="Y" <%=use_yn.equals("Y") ? "checked" : "" %>/>&nbsp;사용</label>&nbsp;&nbsp;&nbsp;
						<label><input type="radio" id="use_n" name="use_yn" value="N" <%=use_yn.equals("N") ? "checked" : "" %>/>&nbsp;미사용</label>
<%
	}
%>						
						
	                </div>
	            </form>
                <button type="submit" class="btn btn-primary" onclick="setForm();">저장</button>
                <button type="submit" class="btn btn-primary" onclick="location.href = './webtoon.jsp'">목록</button>
	        </div>
	    </div>
	</div>
</div>
</body>
</html>
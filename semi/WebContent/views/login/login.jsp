<%@ page  contentType="text/html;charset=utf-8"  pageEncoding = "utf-8" %>
<%@page import="java.util.*"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@ page import="dao.mybatis.SqlSessionManager" %>
<%@ include file="/views/inc/head.jsp"%>
<%@ include file="/views/inc/common.jsp"%>
<!doctype html>
<%
	String isOk = request.getParameter("isOk");
	String type = request.getParameter("type");
	
	
%>
<html lang="en">
<script type="text/javascript">
	var isOk = "<%=isOk %>";
	var type = "<%=type %>";
	
	$(document).ready(function(){
		if(isOk == "Y"){
			alert("등록에 성공하였습니다. 로그인을 해주세요!");
			location.href = "./login.jsp";
		}else{
			if(type == "ID_ERROR") {
				alert("ID가 존재하지 않습니다.");
				location.href = "./login.jsp";
			}
			else if(type == "PW_ERROR"){
				alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				location.href = "./login.jsp";
			}
			else if(type == "TYPE_ERROR"){
				alert("멤버 타입이 존재하지 않습니다.");
				location.href = "./login.jsp";
			}
		}
	});
	
function setForm(){
		if($("#id").val() == ""){
			alert("ID를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if($("#password").val() == ""){
			alert("비밀번호를 입력해주세요.");
			$("#password").focus();
			return false;
		}
		
// 		$.ajax({
// 			 type : "post"
// 			,url : "login_action.jsp"
// 			,data : $("form[name=loginForm]").serialize()
// 			,dataType : "json"
// 			,success : function(result){
// 				console.log(result);
// 				location.href = "./login_action.jsp";
// 			}
// 			,error(xhr, status, error){
// 				alert("데이터를 전송하는데 오류가 발생했습니다.");
// 			}
// 		});
		$("#loginForm").submit();
		
	}
</script>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">
    <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">

    <title>login Form</title>
    

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/sign-in/">


    <style type="text/css">
    body{margin-top:20px;}              
	.modal-footer {   border-top: 0px; }
    </style>    
  </head>

  <body class="text-center">
   <div id="loginModal" class="modal show" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
  <div class="modal-content">
      <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h1 class="text-center">Login</h1>          
      </div>
      <div class="modal-body">
          <form class="form col-md-12 center-block" id="loginForm" name="loginForm" action="/views/login/login_action.jsp" method="post">
            <div class="form-group">
              <input type="text" class="form-control input-lg" placeholder="ID" id="id" name="id">
            </div>
            <div class="form-group">
              <input type="password" class="form-control input-lg" placeholder="Password" id="password" name="password">
            </div>
            <div class="form-group">
              <button type="button" class="btn btn-primary btn-lg btn-block" onclick="setForm();">Sign In</button>
              <span class="pull-right"><a href="/views/login/register.jsp">Register</a></span><span><a href="#">Need help?</a></span>
            </div>
          </form>
      </div>
      <div class="modal-footer">
          <div class="col-md-1accordion2">
          <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
    	  </div>	
      </div>
  </div>
  </div>
</div>
  </body>
</html>

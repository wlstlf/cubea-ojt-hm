<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="header">
	<h1 class="logo">
		<a href="./webtoon.jsp">
			<strong>Board</strong>
			<span>Board List</span>
		</a>
	</h1>

	<div class="ui_menu">
		<ul>
		
<%
if(session_login_status == null) session_login_status = "";

if(session_login_status.equals("Y")){
%>	
			<li class="out"><a onclick="logout_inc('<%=session_login_id %>');" href="javascript:;">로그아웃</a></li>
<%
}else{
%>		
			<li class="out"><a onclick="location.href = '/views/login/login.jsp'" href="javascript:;">로그인</a></li>
<%
}
%>
		</ul>
		<button type="button" class="login"><%=session_login_id %></button>
	</div>
</div>
<script type="text/javascript">
	function logout_inc(name){
		var result = window.confirm(name + "님 로그아웃 하시겠습니까?");
		if(result){
			location.href = "/views/login/logout_action.jsp";
// 			location.reload();
		}
	}
</script>

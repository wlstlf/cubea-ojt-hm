<%@page import="java.util.HashMap"%>
<%@ page  contentType="text/html;charset=utf-8"  pageEncoding = "utf-8" %>
<%@ page import="dao.member.MemberDAO"%>
<%@ include file="/views/inc/common.jsp"%>
<%-- <%@ include file="/views/inc/head.jsp"%> --%>

<%
	MemberDAO memberDAO = new MemberDAO();
	
	String type = request.getParameter("type");
	String isOk = request.getParameter("isOk");
	
%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	var type = "<%=type %>"; 
	var isOk = "<%=isOk %>"; 
	
	$(document).ready(function(){
		if(type="A" && isOk == "N"){
			alert("이미 사용 중인 ID입니다.");
			location.href = "./register.jsp";
		}
	});
	
	
	var setCount = 0;
	function setForm(){
		
		if($("#registerForm input:radio[name=type]:checked").val() === undefined){
			alert("가입 유형을 선택해주세요.");
			return false;
		}
		
		if($("#name").val() == ""){
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		if($("#id").val() == ""){
			alert("ID를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if($("#checkId").val() == "N"){
			alert("ID 중복체크를 진행해주세요.");
			return false;
		}
		if($("#email").val() == ""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
		}
		if($("#password").val() == ""){
			alert("비밀번호를 입력해주세요.");
			$("#password").focus();
			return false;
		}
		if($("#password2").val() == ""){
			alert("비밀번호를 한번 더 입력해주세요.");
			$("#password2").focus();
			return false;
		}
		if($("#password").val() != $("#password2").val()){
			alert("비밀번호가 일치하지 않습니다.");
			$("#password2").focus();
			return false;
		}
			
		$("#registerForm").submit();
				
// 		$.ajax({
// 			 type : "post"
// 			,url : "register_action.jsp"
// 			,data : $("form[name=registerForm]").serialize()
// 			,dataType : "json"
// 			,success : function(result){
// 				console.log(result);
// 				alert(result.msg);
				
// 				if(result.isOk == "N"){
// 					return false;
// 				}else {
// 					location.href = "./login.jsp";
// 				}
// 			}
// 			,error : function(xhr, status, error){
// 				alert("데이터를 전송하는데 오류가 발생했습니다.");
// 			}
// 		});
		
		
	}
	
	function chkId(){

		let data = {
				id : $("#id").val()
		}
		
		if($("#id").val() == ""){
			alert("ID를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		
// 		if($("#checkId").val() == "N"){
// 			alert("ID 중복체크를 진행해주세요.");
// 			return false;
// 		}
		
		setCount = 0;
		if(setCount == 0){
			setCount ++;
			$.ajax({
				 type : "post"
				,url : "./register_action.jsp"
				,data : data
				,dataType : "json"
				,success : function(result){
					const data = result;
					console.log(data.isOk);
					
					alert(data.msg);
					
					if(data.isOk == "Y"){
	// 					$("#reg_btn").attr('disabled', false);
						$("#email").focus();
						$("#checkId").val("Y");
						$("#checkId_btn").remove();
					}else{
						$("#id").focus();
						return false;
					}
					
				}
				,error : function(xhr, status, error){
					alert("데이터를 전송하는데 오류가 발생했습니다.");
					return false;
				}
			});
			
		}
	}
	

</script>
<head>
<link href="http://netdna.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<link rel="shortcut icon" href="">

<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link type="text/css" rel="stylesheet" href="/res/css/bootstrap.map.css"> -->
<!-- <link type="text/css" rel="stylesheet" href="/res/css/bootstrap.min.css"> -->
<style type="text/css">
body{
    margin-top:20px;
    background-color: #f2f3f8;
}
.card {
    margin-bottom: 1.5rem;
    box-shadow: 0 1px 15px 1px rgba(52,40,104,.08);
}

.card {
    position: relative;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: column;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid #e5e9f2;
    border-radius: .2rem;
}
</style>
</head>
<body>
	<div class="container h-100">
    		<div class="row h-100">
				<div class="col-sm-10 col-md-8 col-lg-6 mx-auto d-table h-100">
					<div class="d-table-cell align-middle">

						<div class="text-center mt-4">
							<h1 class="h2">Get started</h1>
							<p class="lead">
								Start creating the best possible user experience for you customers.
							</p>
						</div>

						<div class="card">
							<div class="card-body">
								<div class="m-sm-2">
									<form id="registerForm" name="registerForm" action="./register_action.jsp" method="post">
										<label>가입 유형</label>
										<div class="form-group">
											<input id="type_a" name="type"  type="radio" value="user">
											<label for="type_a">회원</label>&nbsp;&nbsp;&nbsp;
											<input id="type_b" name="type"  type="radio" value="admin">
											<label for="type_b">관리자</label>
										</div>
										<div class="form-check">
										</div>
										<div class="form-group">
											<label>이름</label>
											<input class="form-control form-control-lg" type="text" id="name" name="name" placeholder="Enter your name">
										</div>
										<div class="form-group">
											<label class="d-block">ID</label>
											<input class="form-control form-control-lg d-inline-block w-75" type="text" id="id" name="id" placeholder="Enter your id">
											<button class="btn btn-primary btn-lg align-top" type="button" id="checkId_btn" name="checkId_btn" value="" onclick="chkId();">중복확인</button>
											<input type="hidden" id="checkId" name="checkId" value="N">
											
										</div>
										<div class="form-group">
											<label>Email</label>
											<input class="form-control form-control-lg" type="email" id="email" name="email" placeholder="Enter your email">
										</div>
										<div class="form-group">
											<label>Password</label>
											<input class="form-control form-control-lg" type="password" id="password" name="password" placeholder="Enter password">
										</div>
										<div class="form-group">
											<label>Compare Password</label>
											<input class="form-control form-control-lg" type="password" id="password2" name="password2" placeholder="Enter password again">
										</div>
									</form>
										<div class="text-center mt-3">
											<button type="button" class="btn btn-lg btn-default" onclick="location.href='./login.jsp'">back to home</button>
											<button type="submit" id="reg_btn" name="reg_btn" class="btn btn-lg btn-primary" onclick="setForm();">Sign up</button>
										</div>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
</body>
</html>
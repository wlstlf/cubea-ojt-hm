<%@page import="java.util.HashMap"%>
<%@page import="dao.common.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.webtoon.WebtoonDAO"%>
<%@page import="dao.webtoon.WebtoonDTO"%>
<%@ include file="/views/inc/common.jsp"%>
<%	
	String session_login_id = "";
	String session_login_status = "";

	if(request.getSession().getAttribute("LOGIN_ID") != null && request.getSession().getAttribute("LOGIN_STATUS") != null){
		session_login_id = (String) request.getSession().getAttribute("LOGIN_ID");	
		session_login_status = (String) request.getSession().getAttribute("LOGIN_STATUS");
		
		if(session_login_status.equals("Y")){
			//${}에 저장해준다. 
			request.setAttribute("session_login_id", session_login_id);
			request.setAttribute("session_login_status", session_login_status);
		}
	}
	
	
	//DTO, DAO
	WebtoonDTO webtoonDTO = new WebtoonDTO();
	WebtoonDAO webtoonDAO = new WebtoonDAO();
	
	//search
	String skey = "";
	String sval = "";
	
	if(request.getParameter("skey") != null) 	skey = request.getParameter("skey"); 
	if(request.getParameter("sval") != null) 	sval = request.getParameter("sval"); 
	
	webtoonDTO.setSkey(skey);
	webtoonDTO.setSval(sval);
	
	//paging
	int pg = 1;
	int pp = 10;
	
	String req_pg = request.getParameter("pg");
	String req_pp = request.getParameter("pp");
	
	if(req_pg != null) {
		pg = Integer.parseInt(req_pg); 
	}
	if(req_pp != null){
		pp = Integer.parseInt(req_pp); 
	}

	PagingUtil pagingUtil = new PagingUtil();
	
	HashMap param = new HashMap();
	
	HashMap<String, String> countMap = new HashMap<String, String>();
	
// 	countMap.put("skey", skey);
// 	countMap.put("skey", s);
	
	int totalCount = webtoonDAO.getTotalCount(webtoonDTO);
	
	param = pagingUtil.paging(pg, pp, totalCount);
	
	Integer startRow = (Integer) param.get("startRow");
	Integer endRow = (Integer) param.get("endRow");
	Integer pageNum = (Integer) param.get("pageNum");
	Integer startPage = (Integer) param.get("startPage");
	Integer endPage = (Integer) param.get("endPage");
	
	webtoonDTO.setStartRow(startRow);
	webtoonDTO.setEndRow(endRow);
	
	
	//List
	List<WebtoonDTO> thisList = new ArrayList<WebtoonDTO>();
	
	//DAO	
	thisList = webtoonDAO.getWebtoonList(webtoonDTO);
	
	if(thisList != null)	{
		request.setAttribute("thisList", thisList);
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
<meta charset="UTF-8">
<title>Board</title>
<style type="text/css">
body{
    background:#eee;    
}
.main-box.no-header {
    padding-top: 20px;
}
.main-box {
    background: #FFFFFF;
    -webkit-box-shadow: 1px 1px 2px 0 #CCCCCC;
    -moz-box-shadow: 1px 1px 2px 0 #CCCCCC;
    -o-box-shadow: 1px 1px 2px 0 #CCCCCC;
    -ms-box-shadow: 1px 1px 2px 0 #CCCCCC;
    box-shadow: 1px 1px 2px 0 #CCCCCC;
    margin-bottom: 16px;
    -webikt-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
}
.table a.table-link.danger {
    color: #e74c3c;
}
.label {
    border-radius: 3px;
    font-size: 0.875em;
    font-weight: 600;
}
.user-list tbody td .user-subhead {
    font-size: 0.875em;
    font-style: italic;
}
.user-list tbody td .user-link {
    display: block;
    font-size: 1.25em;
    padding-top: 3px;
    margin-left: 60px;
}
a {
    color: #3498db;
    outline: none!important;
}
.user-list tbody td>img {
    position: relative;
    max-width: 50px;
    float: left;
    margin-right: 15px;
}

.table thead tr th {
    text-transform: uppercase;
    font-size: 0.875em;
    text-align : center;
}
.table thead tr th {
    border-bottom: 2px solid #e7ebee;
}
.table tbody tr td:first-child {
    font-size: 1.125em;
    font-weight: 300;
    text-align : center;
}
.table tbody tr td {
    font-size: 0.875em;
    vertical-align: middle;
    border-top: 1px solid #e7ebee;
    padding: 12px 8px;
    text-align : center;
}
a:hover{
text-decoration:none;
}
</style>
<script type="text/javascript">
	const session_login_id 	   = "<%=session_login_id %>";
	const session_login_status = "<%=session_login_status %>";
	
	let isOk = "<%=isOk %>"; 
	let type = "<%=type %>";
	
	$(document).ready(function(){
		if(isOk == "Y"){
			if(type == "DEL_SUCC"){
				alert("삭제에 성공하였습니다.");
				location.href = "./webtoon.jsp";
			}
		}else{
			if(type == "DEL_FAIL"){
				alert("삭제에 실패하였습니다.");				
				location.href = "./webtoon.jsp";
			}else if(type == "VAL_FAIL"){
				alert("필수값이 누락되었습니다.");				
				location.href = "./webtoon.jsp";
			}	
		}
		
		$("#pp").val(<%=pp %>).prop("selected", true);
	});
	
	function loc_write(webtoon_idx){
		
		if(webtoon_idx == "" || webtoon_idx === undefined){
			if(session_login_id == "" && session_login_status == ""){
				alert("로그인 해주세요.");
				return false;
			}
			location.href="./write.jsp";
		}
		else{
			location.href="./write.jsp?webtoon_idx="+webtoon_idx;
		}
		
	}
	
	function chg_pp(){
		let pp = $("#pp").val();
		let pg = "<%=pg %>";
		
		if(pg == "") pg=1;
		
		location.href = "./webtoon.jsp?pg=" + pg + "&pp=" + pp;
	}
	
	function search(){
		console.log("search");
		var skey = $("#skey").val();
		var sval = $("#sval").val();
		
		if(skey != "" && sval != ""){
			location.href = "./webtoon.jsp?skey="+skey+"&sval="+sval;
		}
		
		console.log("skey : " + skey);
		console.log("sval : " + sval);
	}
</script>
</head>
<body>
<hr>
<div class="container bootstrap snippets bootdey m-auto">
	<%@ include file="../inc/top.jsp" %>
    <div class="row">
        <div class="col-lg-12">
       		<form id="searchForm" name="searchForm" action="./write_action.jsp"><br/>
	            <div class="input-group">
					<select class="form-control" id="skey" name="skey" style="">
		                <option value="a" <%=skey.equals("a") ? "selected" : "" %>>제목</option>
		                <option value="b" <%=skey.equals("b") ? "selected" : "" %>>내용</option>
		                <option value="c" <%=skey.equals("c") ? "selected" : "" %>>작성자</option>
		            </select>
		            <input type="text" class="ml-2 py-2 w-75 h-100" id="sval" name="sval" value="<%=sval %>"/>
		            <div class="input-group-append">
			            <button type="button" class="btn btn btn-primary" onclick="search();">검색</button>
		            </div>
	            </div>
			</form>
        	<div class="btn-wrap mt-3 pb-3 text-right clearfix">
        		<select class="form-control large float-left d-inline-block" id="pp" name="pp" onchange="chg_pp();" style="width:150px">
					<option value="10" >10개씩 보기</option>
					<option value="20" >20개씩 보기</option>
					<option value="30" >30개씩 보기</option>
				</select> 
	        	<button type="submit" class="btn btn-primary" onclick="loc_write();">글 작성</button>
        	</div>
            <div class="main-box clearfix">
                <div class="main-box-body clearfix">
                    <div class="table-responsive" >
                    	<span class="d-block my-2 ml-3">총 개수 : <%= totalCount %></span>
                        <table class="table user-list">
                            <thead>
                                <tr>
                                <th><span>글 번호</span></th>
                                <th><span>썸네일</span></th>
                                <th><span>제목</span></th>
                                <th><span>등록일</span></th>
                                <th><span>작성자</span></th>
<!--                                 <th><span>Email</span></th> -->
                                <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                            	<c:when test="${fn:length(thisList) ne 0}">
                            		<c:forEach items="${thisList }" var="row" varStatus="i">
	                                <tr>
	                                    <td>${row.rnum }</td>
	                                    <td>
		                                    <c:if test="${row.sv_name ne null}">
		                                    	 <div>
 			                                     	<img src="/upload/${row.sv_name }" width="150px">
		                                    	 </div>
		                                    </c:if>
	                                    </td>
	                                    <td><a href="javascript:void(0)" class="" onclick="loc_write('${row.webtoon_idx}');">${row.webtoon_title }</a></td>
	                                    <td>${row.in_date_str }</td>
	                                    <td>${row.webtoon_author }</td>
<%-- 	                                    <td><button type="button" class="btn btn-sm btn-danger" onclick="location.href = './write_action.jsp?webtoon_idx=${row.webtoon_idx}&act=D&sv_name=${row.sv_name }'">삭제하기</button></td> --%>
	                                </tr>
	                                
                            		</c:forEach>
                            	</c:when>
                            </c:choose>
                            </tbody>
                            <tr>
								<td colspan="6" align="center">
<%
	if(endPage > pageNum) {
		endPage = pageNum;
	}
	
	if(startPage > pp){
%>
		<a href="./webtoon.jsp?pg=<%=startPage - 10%>&pp=<%=pp %>&skey=<%=skey %>&sval=<%=sval %>">[이전]</a>
<%
	}
%>								
<%
	
	for(int i=startPage; i<=endPage; i++){
		
		if(i == pg){
			
%>
								[<%=i %>]
<%		
		}else{
%>
			<a href="./webtoon.jsp?pg=<%=i %>&pp=<%=pp %>&skey=<%=skey %>&sval=<%=sval %>">[<%=i %>]</a>
<%			
			
		}
	}
	
	if(endPage < pageNum){
		
%>
			<a href="./webtoon.jsp?pg=<%=startPage + 10%>&pp=<%=pp %>&skey=<%=skey %>&sval=<%=sval %>">[다음]</a>
<%
		
	}
%>
								</td>
							</tr>	
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
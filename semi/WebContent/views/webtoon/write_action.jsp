<%@page import="dao.common.FileDAO"%>
<%@page import="dao.common.CommonDAO"%>
<%@page import="dao.common.FileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dao.webtoon.WebtoonDAO"%>
<%@page import="dao.webtoon.WebtoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
	public String getIp(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	    if (ip != null && ip.indexOf(",") > -1)  ip = ip.substring(0, ip.indexOf(","));
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("Proxy-Client-IP"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("WL-Proxy-Client-IP"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("HTTP_CLIENT_IP"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
	    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) ip = request.getRemoteAddr(); 
	    return ip;
	}
%>
<%
	request.setCharacterEncoding("UTF-8");	
	
	//파일 업로드를 위한 변수 선언
	MultipartRequest multi = null;
	
	String file_name = "";
	String ori_name = "";
	String file_type = "";
	long file_size = 0;
	
	// 파일 저장 경로
	// String savePath = "D:/Projects/workspace/projectName/WebContent/upload";
	String savePath = request.getRealPath("upload");
	out.println("파일 경로 : " + savePath);
	
	//15MB로 제한
	int sizeLimit = 1024*1024*15;
	
	//변수 선언
	String isOk = "";
	String type = "";
	String act  = "";
	
	String webtoon_idx 	 	 = "";
	String webtoon_title 	 = "";
	String webtoon_summary	 = "";
	String webtoon_content	 = "";
	String webtoon_author	 = "";
	String thum				 = "";
	String use_yn 			 = "";
	String in_admin			 = "";
	String up_admin			 = "";
	
	String sv_name = "";
	
	//DAO
	WebtoonDAO webtoonDAO = new WebtoonDAO();
	
	CommonDAO commonDAO = new CommonDAO();
	
	//INSERT 후 REDIRECT할 webtoon_idx
	int max_idx = webtoonDAO.getMaxIdx();
	
	
	if(request.getParameter("act") != null) act = request.getParameter("act");
	//등록시
	if(act.equals("I")){
		//MULTI START
		multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		//FILE process
		Enumeration files = multi.getFileNames();
		
		out.println("files.hasMoreElements() :    " + files.hasMoreElements());
		out.println("<br/>");
		out.println("multi.getFilesystemName(thum) :    " + multi.getFilesystemName("thum"));
		out.println("<br/>");
		
		
		boolean check = false;
		if(multi.getFilesystemName("thum") != null) check = true;
		
		if(check){
			while(files.hasMoreElements()){
				//업로드 한 파일
				String file = files.nextElement().toString();
				//업로드 한 파일의 진짜 이름
				ori_name = multi.getOriginalFileName(file);
				//업로드 한 파일의 renamepoliy로 unique하게 바꾼 이름을 가져온다.
				file_name = multi.getFilesystemName(file);
				//파일 타입
				file_type = multi.getContentType(file);
				//파일 크기 구하기
				File getFile = multi.getFile(file);
				file_size = file.length();
			}
		}
			
		
		 out.println("<br/>");
		 out.println("ori_name : " + ori_name);
		 out.println("<br/>");
		 out.println("file_name : " + file_name);
		 out.println("<br/>");
		 out.println("file_type : " + file_type);
		 out.println("<br/>");
		 out.println("file_size : " + file_size);
		
		
		//webtoon info
		if(multi.getParameter("webtoon_idx") != null) 		webtoon_idx = multi.getParameter("webtoon_idx"); 
		if(multi.getParameter("webtoon_title") != null) 	webtoon_title = multi.getParameter("webtoon_title"); 
		if(multi.getParameter("webtoon_summary") != null) 	webtoon_summary = multi.getParameter("webtoon_summary");
		if(multi.getParameter("webtoon_content") != null) 	webtoon_content = multi.getParameter("webtoon_content");
		if(multi.getParameter("webtoon_author") != null) 	webtoon_author = multi.getParameter("webtoon_author");
		if(multi.getParameter("use_yn") != null) 			use_yn = multi.getParameter("use_yn");
		//MULTI END
		
		//DTO
		WebtoonDTO webtoonDTO = new WebtoonDTO();
		FileDTO fileDTO = new FileDTO();
		
		//DTO SET
		in_admin = (String) request.getSession().getAttribute("LOGIN_ID");
		
		webtoonDTO.setWebtoon_idx(webtoon_idx);
		webtoonDTO.setWebtoon_title(webtoon_title);
		webtoonDTO.setWebtoon_content(webtoon_content);
		webtoonDTO.setWebtoon_summary(webtoon_summary);
		webtoonDTO.setWebtoon_author(webtoon_author);
		webtoonDTO.setUse_yn(use_yn);
		webtoonDTO.setThum(thum);
		webtoonDTO.setIn_admin(in_admin);		
		
		int file_result = 0;
		//FILE DTO CHECK
		if(check){
			webtoonDTO.setThum(ori_name);
			
			fileDTO.setFile_type(file_type);
			fileDTO.setPa_idx(Integer.toString(max_idx));
			fileDTO.setOri_name(ori_name);
			fileDTO.setSv_name(file_name);
			fileDTO.setIn_user(in_admin);
			fileDTO.setIn_ip(getIp(request));
			
			//파일 업로드
			file_result = commonDAO.file_upload(fileDTO);
		}
		
		//등록
		int result = webtoonDAO.setWebtoon(webtoonDTO);
		
		out.println("<br/>");
		out.println("result : " + result);
		
				
		out.println("<br/>");
		out.println("file_result : " + file_result);
		 
		//등록이 되었을때
		if(result == 1){
			isOk = "Y";
			type = "SET_SUCC";
			response.sendRedirect("./write.jsp?webtoon_idx=" + max_idx + "&isOk=" + isOk + "&type=" + type);
		}else{
			//등록 실패시
			isOk = "N";
			type = "SET_FAIL";
			response.sendRedirect("./write.jsp?isOk=" + isOk + "&type=" + type);
		}
 	}
	//수정시	
	else if(act.equals("U")){
		//MULTI START
		multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		boolean check = false;
		if(multi.getFilesystemName("thum") != null) check = true;
		
		//파라미터를 위한 변수들 생성
		if(multi.getParameter("webtoon_idx") != null) 		webtoon_idx = multi.getParameter("webtoon_idx");
		WebtoonDTO webtoonDTO = new WebtoonDTO();
		webtoonDTO = webtoonDAO.getWebtoon(webtoon_idx);
		
		//File PROCESS
		Enumeration files = multi.getFileNames();
		
		if(check){
			while(files.hasMoreElements()){
				//업로드 한 파일
				String file = files.nextElement().toString();
				//업로드 한 파일의 진짜 이름
				ori_name = multi.getOriginalFileName(file);
				//업로드 한 파일의 renamepoliy로 unique하게 바꾼 이름을 가져온다.
				file_name = multi.getFilesystemName(file);
				//파일 타입
				file_type = multi.getContentType(file);
				//파일 크기 구하기
				File getFile = multi.getFile(file);
				file_size = file.length();
				
				HashMap param = new HashMap<String, Object>();
				param.put("pa_idx", webtoon_idx);
				param.put("sv_name", webtoonDTO.getSv_name());
				
				//기존에 있던 썸네일 데이터 삭제
				commonDAO.delFile(param);
			}
		}
		
		//webtoon info
		if(multi.getParameter("webtoon_idx") != null) 		webtoon_idx = multi.getParameter("webtoon_idx");
		if(multi.getParameter("webtoon_title") != null) 	webtoon_title = multi.getParameter("webtoon_title"); 
		if(multi.getParameter("webtoon_summary") != null) 	webtoon_summary = multi.getParameter("webtoon_summary");
		if(multi.getParameter("webtoon_content") != null) 	webtoon_content = multi.getParameter("webtoon_content");
		if(multi.getParameter("webtoon_author") != null) 	webtoon_author = multi.getParameter("webtoon_author");
		if(multi.getParameter("thum") != null) 				thum = multi.getParameter("thum");
		if(multi.getParameter("use_yn") != null) 			use_yn = multi.getParameter("use_yn");
		
		//DTO
		webtoonDTO = new WebtoonDTO();
		FileDTO fileDTO = new FileDTO();
		
		//DTO SET
		webtoonDTO.setWebtoon_idx(webtoon_idx);
		webtoonDTO.setWebtoon_title(webtoon_title);
		webtoonDTO.setWebtoon_content(webtoon_content);
		webtoonDTO.setWebtoon_summary(webtoon_summary);
		webtoonDTO.setWebtoon_author(webtoon_author);
		webtoonDTO.setUse_yn(use_yn);
		
		
		//FILE DTO CHECK
		int file_result = 0;
		if(check){
			webtoonDTO.setThum(ori_name);
			
			fileDTO.setFile_type(file_type);
			fileDTO.setPa_idx(webtoon_idx);
			fileDTO.setOri_name(ori_name);
			fileDTO.setSv_name(file_name);
			fileDTO.setIn_user(in_admin);
			fileDTO.setIn_ip(getIp(request));
			
			//파일 업로드
			file_result = commonDAO.file_upload(fileDTO);
		}
		out.println("<br/>");
		out.println("file_result : " + file_result);
		
		//FILE DTO CHECK
		
		in_admin = (String) request.getSession().getAttribute("LOGIN_ID");
		webtoonDTO.setIn_admin(in_admin);		
		//MULTI END
		
		up_admin = (String) request.getSession().getAttribute("LOGIN_ID");
		webtoonDTO.setUp_admin(up_admin);
		
		int result = webtoonDAO.modWebtoon(webtoonDTO);
		
		//수정 성공
		if(result == 1){
			isOk = "Y";
			type = "MOD_SUCC";
			response.sendRedirect("./write.jsp?webtoon_idx=" + webtoon_idx + "&isOk=" + isOk + "&type=" + type);
		}else{
			//수정 실패
			isOk = "N";
			type = "MOD_FAIL";
			response.sendRedirect("./write.jsp?webtoon_idx=" + webtoon_idx + "&isOk=" + isOk + "&type=" + type);
		}
	}
	//삭제시	
	else if(act.equals("D")){
		if(request.getParameter("webtoon_idx") != null) webtoon_idx = request.getParameter("webtoon_idx"); 
		if(request.getParameter("sv_name") != null) sv_name = request.getParameter("sv_name"); 
		
		HashMap param = new HashMap<String, Object>();
		param.put("pa_idx", webtoon_idx);
		param.put("sv_name", sv_name);
		
		int result = webtoonDAO.delWebtoon(webtoon_idx);
		
		int file_result = 0;
		if(!sv_name.equals("")) file_result = commonDAO.delFile(param);
		
		
		out.println("<br/>");
		out.println("result :  " + result);
		out.println("<br/>");
		out.println("del result :  " + file_result);
		out.println("<br/>");
		out.println("del webtoon_idx :  " + webtoon_idx);
		out.println("<br/>");
		out.println("del sv_name :  " + sv_name);
		
		//삭제 성공
		if(result == 1){
			isOk = "Y";
			type = "DEL_SUCC";
			response.sendRedirect("./webtoon.jsp?isOk=" + isOk + "&type=" + type);
		}else{
			//수정 실패
			isOk = "N";
			type = "DEL_FAIL";
			response.sendRedirect("./webtoon.jsp?isOk=" + isOk + "&type=" + type);
		}
	} 
	else if(act.equals("delThum")){
		int result = 0;
		int result_file = 0;
		if(request.getParameter("webtoon_idx") != null) webtoon_idx = request.getParameter("webtoon_idx");
		if(request.getParameter("sv_name") != null) sv_name = request.getParameter("sv_name");
		
		
		HashMap param = new HashMap<String, Object>();
		param.put("pa_idx", webtoon_idx);
		param.put("sv_name", sv_name);
		
		
		if(!webtoon_idx.equals("") && !(sv_name.equals(""))){
			result = webtoonDAO.delThum(webtoon_idx); 
			result_file = commonDAO.delFile(param);	
		}
		//삭제 성공
		if(result == 1){
			
		}
	}
%>
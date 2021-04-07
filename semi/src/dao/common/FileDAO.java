package dao.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class FileDAO {
//	private final String FILE_DIR = "D:\\FILE_DIR\\";
	private final String FILE_DIR = "C:\\FILE_DIR\\RT\\"; //HM_HOME
	private final String URL	  = "jdbc:oracle:thin:@106.240.249.42:1521:orcl";
	private final String ID	 	  = "private_hm";
	private final String PW	  	  = "amho";
	
	private Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs 			= null;
	
	//JDBC DRIVER INFO
	public Connection getConnection() throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(URL, ID, PW);
			return conn;
			
		}catch(Exception e) {
			System.out.println("JDBC 연결 실패 : " + e.toString());
		}
		
		
		return null;
	}
	
	//DAO
	public int getNextval() throws Exception {
		int result = 0;
		
		try {
			String query = "SELECT FILE_MAKE_SEQ.NEXTVAL FROM DUAL";
			
			conn 	= this.getConnection();
			pstmt 	= conn.prepareStatement(query);
			
			rs 		= pstmt.executeQuery();			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("SQL 쿼리 에러");
		}
		
		return result;
	}
	
	public List<FileDTO> getList() {
		
		List<FileDTO> thisList = new ArrayList<FileDTO>();
		
		try {
			StringBuffer query = new StringBuffer();
			
			query.append("SELECT      										   										  \n");
			query.append("  DETAIL.WORD_IDX          										     					  \n");
			query.append("  ,WORD.WORD_TITLE      										     						  \n");
			query.append("  ,LISTAGG(      										    								  \n");
			query.append("  (SELECT WORD.WORD_TITLE FROM EPTS.CMTN_WORD WORD WHERE WORD.WORD_IDX = DETAIL.DETAIL_IDX) \n");
			query.append("  ,','      										     									  \n");
			query.append("  ) WITHIN GROUP(ORDER BY       												 		      \n");
			query.append("  (SELECT WORD.WORD_TITLE FROM EPTS.CMTN_WORD WORD WHERE WORD.WORD_IDX = DETAIL.DETAIL_IDX)      										     \n");
			query.append("  ) AS DETAIL_WORD_TITLE										     						  \n");
			query.append("FROM EPTS.CMTN_WORD_DETAIL DETAIL      										    		  \n");
			query.append("LEFT OUTER JOIN EPTS.CMTN_WORD WORD      										   		 	  \n");
			query.append("ON WORD.WORD_IDX = DETAIL.WORD_IDX      										   			  \n");
			query.append("WHERE DETAIL.TYPE  = '000010000200001'  										   			  \n"); //RT 검색
//			query.append("WHERE DETAIL.TYPE  = '000010000200002'  										   			  \n"); //UF 검색
			query.append("GROUP BY DETAIL.WORD_IDX, WORD.WORD_TITLE      									  	      \n");
			
			conn 	= this.getConnection();
			pstmt 	= conn.prepareStatement(query.toString());
			
			rs 		= pstmt.executeQuery();			
			while(rs.next()) {
				FileDTO fileDTO = new FileDTO();		
				
				fileDTO.setWord_title(rs.getString("word_title"));
				fileDTO.setDetail_word_title(rs.getString("detail_word_title"));
				
				thisList.add(fileDTO);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("SQL 쿼리 에러");
		}
		
		return thisList;
	}
	
	public void makeFile() {
		
		Calendar cal = Calendar.getInstance();
		
		String year = Integer.toString(cal.get(Calendar.YEAR));
		String month = Integer.toString(cal.get(Calendar.MONTH)+1);
		String day = Integer.toString(cal.get(Calendar.DATE));
		
		if(month.length() == 1) {
			month = "0" + month;
		}
		
		String nowtime = year + month + day;
		
		String hangle[] = {"가", "나", "다", "라", "마", "바", "사", "아", "자", "차", "카", "타", "파", "하"};
		
		String FILE_NAME = FILE_DIR + "";
		
		//디렉토리 체크
		File chkDir = new File(FILE_DIR);
		
		//디렉토리가 존재하지 않는다면
		if(!chkDir.exists()) {
			System.out.println("디렉토리 존재X");
			chkDir.mkdir();
			System.out.println("디렉토리 생성완료");
		}
		
		try {
			FileDTO fileDAO = new FileDTO();
			
			int count = this.getNextval();

			List<FileDTO> list = this.getList();
			
			File chkFile = new File(FILE_DIR + nowtime + "_" + count + ".txt");
			//이미 만들어진 파일 존재여부 체크
			if(!chkFile.exists()) {
				//파일이 존재하지 않는다면
				
				FILE_NAME = FILE_DIR + nowtime + "_" + count + ".txt";
				
				//ANSI encoding
				OutputStreamWriter fw = new OutputStreamWriter(new FileOutputStream(FILE_NAME), "UTF8");
				
				//파일안에 문자열 쓰기
				for(int i=0; i < list.size(); i++) {
					fw.write(list.get(i).getWord_title() + "," + list.get(i).getDetail_word_title() + "\r\n"); 
				}
				
				fw.flush();
				
				//객체 닫기
				fw.close();
				System.out.println("파일 생성 성공" + " -- 생성된 파일 이름 : " + FILE_NAME);
				
			}else {
				System.out.println("시퀀스 에러");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}


package dao.member;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.log4j.Logger;
import org.apache.log4j.chainsaw.Main;

import dao.mybatis.SqlSessionManager;

public class MemberDAO {
	private static final Logger logger = Logger.getLogger(MemberDAO.class);
	
	private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	private SqlSession sqlSession;
	
	public List<MemberDTO> getMemberList(){
		List<MemberDTO> list = new ArrayList<>();
		
		return null;
	}
	
	/* method 	: setMember
	 * param	: MemberDTO 
	 * result	: int
	 * desc		: 회원 등록 
	 * */
	public int setMember(MemberDTO memberDTO) {		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Member.setMember";
		
		logger.debug("■ Target NameSpace : " + target_name);
		
		int result = 0;
		
		try {
			result = sqlSession.insert(target_name, memberDTO);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
	
	/* method 	: chkMember
	 * param	: MemberDTO 
	 * result	: int
	 * desc		: DB에 아이디가 존재하는지 확인
	 * */
	public int chkMember(MemberDTO memberDTO) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Member.chkMember";
		
		logger.debug("■ Target NameSpace : " + target_name);
		
		int result = 0;
		
		try {
			result = sqlSession.selectOne(target_name, memberDTO);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return result;
	}
	
	/* method 	: chkPW
	 * param	: MemberDTO 
	 * result	: int
	 * desc		: PW 중복 체크
	 * */
	public int chkPW(MemberDTO memberDTO) {
		int result = 0;
		
		SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
		SqlSession sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Member.chkPW";
		
		logger.debug("■ Target NameSpace : " + target_name);
		
		try {
			result = sqlSession.selectOne(target_name, memberDTO);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
}

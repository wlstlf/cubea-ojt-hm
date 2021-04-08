package dao.webtoon;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import dao.mybatis.SqlSessionManager;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class WebtoonDAO {
	private SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	private SqlSession sqlSession;
	
	private final Logger logger = LoggerFactory.getLogger(WebtoonDAO.class);
	
	/* method 	: getWebtoonList
	 * param	: MemberDTO 
	 * result	: List
	 * desc		: 웹툰 리스트 출력 
	 * */
	public List<WebtoonDTO> getWebtoonList(WebtoonDTO webtoonDTO) {
		sqlSession = sqlSessionFactory.openSession();		
		String target_name = "Webtoon.getWebtoonList";
		
		logger.debug("Target NameSpace - " + target_name);
		
		List<WebtoonDTO> list = new ArrayList<WebtoonDTO>();
		
		try {
			list = sqlSession.selectList(target_name, webtoonDTO);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return list;
	}
	
	/* method 	: getTotalCount
	 * param	: WebtoonDTO 
	 * result	: int
	 * desc		: get totalCount
	 * */
	public int getTotalCount(WebtoonDTO webtoonDTO) {
		sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Webtoon.getTotalCount";
		logger.debug("Target NameSpace - " + target_name);
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		int result = 0;
		
		try {
			result = sqlSession.selectOne(target_name, webtoonDTO);
			  
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
	
	/* method 	: setWebtoon
	 * param	: MemberDTO 
	 * result	: int
	 * desc		: 회원 등록 
	 * */
	public int setWebtoon(WebtoonDTO webtoonDTO) {
		sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Webtoon.setWebtoon";
		
		logger.debug("Target NameSpace - " + target_name);
		
		int result = 0;
		
		try {
			result = sqlSession.insert(target_name, webtoonDTO);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		
		return result;
	}
	
	/* method 	: getNextVal
	 * param	:  
	 * result	: int
	 * desc		: getNextVal
	 * */
	public int getNextVal() {
		sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Webtoon.getNextVal";
		
		logger.debug("Target NameSpace - " + target_name);
		
		int result = 0;
		
		try {
			result = sqlSession.selectOne(target_name);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
	
	/* method 	: getWebtoon
	 * param	: MemberDTO 
	 * result	: WebtoonDTO
	 * desc		: 웹툰 조회
	 * */
	public WebtoonDTO getWebtoon(String webtoon_idx) {
		sqlSession = sqlSessionFactory.openSession();
		
		//DTO
		WebtoonDTO webtoonDTO = new WebtoonDTO();
		
		//Map
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("webtoon_idx", webtoon_idx);
		
		String target_name = "Webtoon.getWebtoon";
		
		logger.debug("Target NameSpace - " + target_name);
		
		try {
			webtoonDTO = new WebtoonDTO();
			webtoonDTO = sqlSession.selectOne(target_name, webtoon_idx);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return webtoonDTO;
	}
	
	/* method 	: modWebtoon
	 * param	: HashMap 
	 * result	: int
	 * desc		: max idx
	 * */
	public int modWebtoon(WebtoonDTO webtoonDTO) {
		sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Webtoon.modWebtoon";
		
		HashMap<String, String> param = new HashMap<String, String>();
		
		param.put("webtoon_title", webtoonDTO.getWebtoon_title());
		param.put("webtoon_content", webtoonDTO.getWebtoon_content());
		param.put("webtoon_summary", webtoonDTO.getWebtoon_summary());
		param.put("webtoon_author", webtoonDTO.getWebtoon_author());
		param.put("thum", webtoonDTO.getThum());
		param.put("up_admin", webtoonDTO.getUp_admin());
		param.put("use_yn", webtoonDTO.getUse_yn());
		param.put("webtoon_idx", webtoonDTO.getWebtoon_idx());
		
		int result = 0;
		
		try {
			result = sqlSession.update(target_name, param);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
	
	/* method 	: delWebtoon
	 * param	: HashMap 
	 * result	: int
	 * desc		: max idx
	 * */
	public int delWebtoon(String webtoon_idx) {
		sqlSession = sqlSessionFactory.openSession();
		
		String target_name = "Webtoon.delWebtoon";
		
		logger.debug("Target NameSpace - " + target_name);
		
		//map
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("webtoon_idx", webtoon_idx);
		
		int result = 0;
		
		try {
			result = sqlSession.delete(target_name, param);
			
			sqlSession.commit();			
		}catch(Exception e) {
			sqlSession.rollback();
			
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return result;
	}
	
	/* method 	: delThum
	 * param	:  
	 * result	: int
	 * desc		: delThum
	 * */
	public int delThum(String webtoon_idx) {
		sqlSession = sqlSessionFactory.openSession();
		
		System.out.println("webtoon_idx : " + webtoon_idx);
		
		String target_name = "Webtoon.delThum";
		
		logger.debug("Target NameSpace - " + target_name);
		
		int result = 0;
		
		try {
			result = sqlSession.update(target_name, webtoon_idx);
			
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

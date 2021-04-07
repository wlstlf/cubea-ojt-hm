package dao.common;

import java.util.HashMap;

public class PagingUtil {
	int pg = 0;
	int pp = 0;
	int startRow = 0;
	int endRow = 0;
	int startPage = 0;
	int endPage = 0;
	int pageNum = 0;
	int range = 10;
	
	public HashMap<String, Integer> paging(int pg, int pp, int totalCount){
		//pg = 1 pp = 10  startRow = (pg-1) * pp +1 endRow = pg * pp
		startRow = (pg-1) * pp + 1;
		endRow = pp * pg;
		startPage = ((pg-1)/range)*range+1;
		endPage = startPage + range - 1;
		pageNum = totalCount / pp + (totalCount % pp == 0 ? 0 : 1);
		
		HashMap<String, Integer> rtnMap = new HashMap<String, Integer>();
		
		rtnMap.put("startRow", startRow);
		rtnMap.put("endRow", endRow);
		rtnMap.put("pageNum", pageNum);
		rtnMap.put("startPage", startPage);
		rtnMap.put("endPage", endPage);
		
		return rtnMap;
	}
}

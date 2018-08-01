package bluedot.spectrum.commons.index.operate;

import java.util.LinkedList;
import java.util.Map;

/**
 * 
 * @author gzp
 * @date 2018年3月15日 
 * @description: 对外暴露的索引操作接口
 */
public interface IndexOperater {
	
	
	/**
	 * 索引的查询功能
	 * @param queryString  需要查询的字符串
	 * @return 返回封装好的 json 字符串
	 */
	String indexSearch(String queryString);
	
	/**
	 * 添加新的索引列
	 * @param id 索引数据表中的id
	 * @param indexString 索引字符串
	 * @param tableName 索引字符串的表名
	 * @param cloumnName 索引字符串的列名
	 */
	void addNewIndex(String id, String indexString, String tableName, String cloumnName);
	
	/**
	 * 更新索引
	 * @param indexString 旧的索引字符串
	 * @param newIndexString 新的索引字符串
	 */
	void updateIndex(String indexString, String newIndexString);
}

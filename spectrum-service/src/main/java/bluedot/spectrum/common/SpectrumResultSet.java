package bluedot.spectrum.common;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import bluedot.spectrum.commons.vo.SpectrumFile;

public class SpectrumResultSet {
	//采用链表方式存储，如果头插法即可保证最新在最前面，利于遍历输入无需排序
	private Map<Long,LinkedList<Report>> map = new HashMap<>();
	
	//增加结果光谱
	public void addSpectrumReport(Long id,Report report){
		LinkedList<Report> list = null;	
		if(!map.containsKey(id)){
			list = new LinkedList<>();
			list.addFirst(report);
			map.put(id, list);
		}else{
			list = map.get(id);
			list.addFirst(report);
		}
	}
	public LinkedList<Report> getSpectrumSet(Long id){
		if(!map.containsKey(id)){
			return null;
		}
		return map.get(id);
	}
	
	/**
	 * 更加索引得到光谱 index-1才是真正索引
	 * @param id
	 * @param index
	 * @return
	 */
	public Report getSpectrumByIndex(Long id,int index){
		if(!map.containsKey(id)){
			return null;
		}
		LinkedList<Report> list = map.get(id);
		if(list.size()<index){
			return null;
		}
		return list.get(index-1);
	}
	
	SpectrumResultSet(){}
}

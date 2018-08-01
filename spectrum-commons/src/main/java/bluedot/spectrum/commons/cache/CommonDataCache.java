package bluedot.spectrum.commons.cache;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map.Entry;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
/**
 * cache
 * @author Aaron
 *
 */
public class CommonDataCache implements DataCacheOperate{

	private LinkedHashMap<String,CacheData> FIFO;
	private LinkedHashMap<String,CacheData> LRU;
	private Lock lockFIFO;
	private Lock lockLRU;
	private int flag = 0;
	
	private CommonDataCache(){
		this.FIFO = new LinkedHashMap<>(16, 0.75f, false);
		this.LRU = new LinkedHashMap<>(16, 0.75f, true);
		this.lockFIFO = new ReentrantLock(true);
		this.lockLRU = new ReentrantLock(true);
	}

	//公平锁，分开锁，提高并发
	@Override
	public boolean add(CacheData value) {
		CacheData cacheData = null;
		try{
			this.lockFIFO.lock();
			cacheData = addToMap(this.FIFO,value);
		}catch (Exception e) {
			return false;
		}finally {
			this.lockFIFO.unlock();
		}
		//这里肯定不会有脏数据
		if(cacheData!=null&&cacheData.getCount()>=10){
			try{
				this.lockLRU.lock();
				cacheData = addToMap(this.LRU,value);
			}catch (Exception e) {
				return false;
			}finally {
				this.lockLRU.unlock();
			}
		}
		if(cacheData!=null){
			cacheData.setCount(5);
			add(cacheData);
		}
		return true;
	}
	
	/**
	 * 删除会返回值
	 * @param value
	 * @return
	 */
	private CacheData addToMap(LinkedHashMap<String,CacheData> map,CacheData value){
		int size = map.size();
		if(size<16){
			map.put(value.getKey(), value);
		}else{
			CacheData cacheData = deleteDefault(map);
			map.put(value.getKey(), value);
			return cacheData;
		}
		return null;
	}
	
	
	private CacheData deleteDefault(LinkedHashMap<String,CacheData> map) {
		Entry<String, CacheData> entry = map.entrySet().iterator().next();
		String key = entry.getKey();
		map.remove(key);
		if(map==this.FIFO){
			if(flag==3){
				checkCacheToLRU(map);
				flag=0;
			}else{
				flag++;
			}
		}
		return entry.getValue();
	}
	
	
	private void checkCacheToLRU(LinkedHashMap<String,CacheData> map) {
		Iterator<Entry<String, CacheData>> iterator = map.entrySet().iterator();
		while(iterator.hasNext()){
			Entry<String, CacheData> entry = iterator.next();
			int count = entry.getValue().getCount();
			if(count>=10){
				addToMap(this.LRU,entry.getValue());
			}
		}
	}

	//get不需要加锁 cachedata对象中的计数为原子类线程安全
	@Override
	public CacheData get(String key) {
		if(this.LRU.containsKey(key)){
			CacheData cacheData = this.LRU.get(key);
			cacheData.setCount(cacheData.getCount()+1);
			return cacheData;
		}else if(this.FIFO.containsKey(key)){
			CacheData cacheData = this.FIFO.get(key);
			cacheData.setCount(cacheData.getCount()+1);
			return cacheData;
		}
		return null;
	}

	
	
	private static class SingletonHolder {
		private static final CommonDataCache instance = new CommonDataCache();
	}
	
	public static final CommonDataCache getInsatance(){
        return SingletonHolder.instance;
    }
	
}

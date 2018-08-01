package bluedot.spectrum.commons.cache;

import java.util.concurrent.atomic.AtomicInteger;

public class CacheData {
	
	//原子类
	private volatile AtomicInteger count = new AtomicInteger(0);
	private String key;
	private Object value;
	
	public int getCount() {
		return count.get();
	}
	public void setCount(int value) {
		while(!this.count.compareAndSet(count.get(), value));
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return "CacheData [count=" + count + ", key=" + key + ", value=" + value + "]";
	}
	
}

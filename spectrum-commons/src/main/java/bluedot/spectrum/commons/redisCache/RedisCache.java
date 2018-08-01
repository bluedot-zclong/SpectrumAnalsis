package bluedot.spectrum.commons.redisCache;

public interface RedisCache {
	 
	public void put(String key,Object value);
	
	public Object get(String key);
	
}

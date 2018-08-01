package bluedot.spectrum.commons.redisCache;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import redis.clients.jedis.Jedis;

public class RedisCacheImpl implements RedisCache {

	private Jedis jedis;

	private RedisCacheImpl() {
		this.jedis = new Jedis("219.229.193.123",6379);
		System.out.println("连接成功");
		// 查看服务是否运行
		System.out.println("服务正在运行: " + jedis.ping());
	}

	@Override
	public void put(String key,Object value) {
		this.jedis.set(key.getBytes(), serialize(value));
	}

	@Override
	public Object get(String key) {
		byte[] byt=jedis.get(key.getBytes());
        Object obj=unserizlize(byt);
		return obj;
	}

	 //序列化 
    private static byte [] serialize(Object obj){
        ObjectOutputStream obi=null;
        ByteArrayOutputStream bai=null;
        try {
            bai=new ByteArrayOutputStream();
            obi=new ObjectOutputStream(bai);
            obi.writeObject(obj);
            byte[] byt=bai.toByteArray();
            return byt;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    //反序列化
    private static Object unserizlize(byte[] byt){
        ObjectInputStream oii=null;
        ByteArrayInputStream bis=null;
        bis=new ByteArrayInputStream(byt);
        try {
            oii=new ObjectInputStream(bis);
            Object obj=oii.readObject();
            return obj;
        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return null;
    }
	
	
	
	private static class SingletonHolder {
		private static final RedisCacheImpl instance = new RedisCacheImpl();
	}

	public static final RedisCacheImpl getInsatance() {
		return SingletonHolder.instance;
	}

}

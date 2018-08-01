package jxau.spectrum.frame.dataAccess.Session;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

import jxau.spectrum.frame.dataAccess.Proxy.MapperProxy;
import jxau.spectrum.frame.dataAccess.Proxy.SqlInvocationHandler;
import jxau.spectrum.frame.dataAccess.cache.InterfaceInfoCache;



public class Session {
	
	private InterfaceInfoCache interfaceInfoCache;
	
	public Session(){
		this.interfaceInfoCache = new InterfaceInfoCache();
	}
	
	public Object getMapper(Class clazz) {
		SqlInvocationHandler handler = new SqlInvocationHandler(getMapperProxy(clazz));
		return handler.getProxy(clazz);
	}
	
	/**
	 * 根据class返回maperproxy。保存进cache
	 * @param clazz
	 * @return
	 */
	private MapperProxy getMapperProxy(Class clazz){
		String name = clazz.getSimpleName();
		MapperProxy mapperProxy =null;
		mapperProxy = interfaceInfoCache.getMapperProxy(name);
		if(mapperProxy == null){
			mapperProxy = new MapperProxy(clazz);
			interfaceInfoCache.put(name, mapperProxy);
		}
		return mapperProxy;
	}
	
	
}

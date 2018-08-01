package jxau.spectrum.frame.dataAccess.cache;

import java.util.HashMap;
import java.util.Map;

import jxau.spectrum.frame.dataAccess.Proxy.MapperProxy;
/**
 * 接口信息缓存
 * @author Aaron
 *
 */
public class InterfaceInfoCache {
	
	private Map<String,MapperProxy> map;

	public InterfaceInfoCache(){
		this.map = new HashMap();
	}
	
	public void addNewMapperProxy(MapperProxy mapperProxy){
		String name = mapperProxy.getName();
		this.map.put(name, mapperProxy);
	}
	
	public MapperProxy getMapperProxy(String name){
		return this.map.get(name);
	}

	public void put(String name, MapperProxy mapperProxy) {
		this.map.put(name, mapperProxy);
	}
	
}

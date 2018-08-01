package jxau.spectrum.frame.dataAccess.ResultSetHandle;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jxau.spectrum.frame.dataAccess.Utils.StringUtils;

/**
 * 返回类型生成执行器
 * @author Aaron
 *
 */
public class ResultSetHandle {
	private HashMap<String,String> map;
	public ResultSetHandle(HashMap<String,String> map){
		this.map = map;
	}
	public Object resultInstance(ResultSet resultSet,String resultType){
		if(resultType.contains("java.util.HashMap")){
			return returnResultHashMap(resultSet);
		}else if(resultType.contains("java.util.List<HashMap>")){
			return returnResultListHashMap(resultSet);
		}else if(resultType.contains("java.util.List")&&!resultType.contains("HashMap")){
			List<Object> list = new ArrayList();
			int firstIndex = resultType.indexOf('<');
			int lastIndex = resultType.indexOf('>');
			String type = resultType.substring(firstIndex+1, lastIndex);
			type = map.get(type);
			try {
				while(resultSet.next()){
					Object obj = null;
					try {
						obj = returnOneInstance(resultSet,type,null);
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					} catch (InstantiationException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (NoSuchMethodException e) {
						e.printStackTrace();
					} catch (SecurityException e) {
						e.printStackTrace();
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}
					list.add(obj);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return list;
		}else{
			resultType = this.map.get(resultType);
			Object obj = null;
			try {
				while(resultSet.next()){
					obj = returnOneInstance(resultSet,resultType,obj);
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return obj;
		}
	
		
	}
	private Object returnOneInstance(ResultSet resultSet,String resultType,Object obj) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException, NoSuchMethodException, SecurityException, IllegalArgumentException, InvocationTargetException{
		HashMap<String,Object> map = new HashMap();
		ResultSetMetaData rsmd=resultSet.getMetaData();//使用 getMetaData() 方法从 ResultSet 中获取 ResultSetMetaData 对象。您可以使用此对象获得列的数目和类型以及每一列的名称。 
		int columnCount=rsmd.getColumnCount();
	
		for(int i=1;i<=columnCount;i++) {
			String key = rsmd.getColumnName(i);
			Object value = resultSet.getObject(i);
			map.put(key, value);
		}
		Class<?> clazz = Class.forName(resultType);
		Object instance = clazz.newInstance();//User
		
		Field[] fields = clazz.getDeclaredFields();
		for(int i=0;i<fields.length;i++){
			String key = fields[i].getName();
			String signature = null;
			String type = null;
			if(fields[i].getType().toString().contains("List")){
				signature = getGenericSignature(fields[i]);
				type = StringUtils.getListsubType(signature);
			}
			if(type!=null){
				
			}else{
				if(obj==null){
					Object value = map.get(key);
					Class paramterType = value.getClass();
					key = StringUtils.toUpperFristChar(key);
					Method method = clazz.getMethod("set"+key, value.getClass());
					method.invoke(instance, value);
				}
			}
		}
	
		return instance;
	}
	private HashMap<String,Object> returnResultHashMap(ResultSet resultSet){
		HashMap<String,Object> map = new HashMap();
		
		try {
			while(resultSet.next()){
				//获取表的列数
				ResultSetMetaData rsmd=resultSet.getMetaData();//使用 getMetaData() 方法从 ResultSet 中获取 ResultSetMetaData 对象。您可以使用此对象获得列的数目和类型以及每一列的名称。 
				int columnCount=rsmd.getColumnCount();
				//map存放行中的所有列key是列名 value是列值
				for(int i=1;i<=columnCount;i++) {
					String k=rsmd.getColumnName(i);
					Object v=resultSet.getObject(i);
					map.put(k, v);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	private List<HashMap<String,Object>> returnResultListHashMap(ResultSet resultSet){
		List<HashMap<String,Object>> list = new ArrayList();
		try {
			while(resultSet.next()){
				HashMap<String,Object> map = new HashMap();
				//获取表的列数
				ResultSetMetaData rsmd=resultSet.getMetaData();//使用 getMetaData() 方法从 ResultSet 中获取 ResultSetMetaData 对象。您可以使用此对象获得列的数目和类型以及每一列的名称。 
				int columnCount=rsmd.getColumnCount();
				//map存放行中的所有列key是列名 value是列值
				for(int i=1;i<=columnCount;i++) {
					String k=rsmd.getColumnName(i);
					Object v=resultSet.getObject(i);
					map.put(k, v);
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	private String getGenericSignature(Field field){
		try {
			Field signatureField = field.getClass().getDeclaredField("signature");
			signatureField.setAccessible(true);
			String value = (String) signatureField.get(field);
			return value;
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (NoSuchFieldException e) {
			e.printStackTrace();
		}
		return null;
	}
}

package jxau.spectrum.frame.dataAccess.ParamterHandle;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Paramter {

	private HashMap<String, Integer> paramMap; // 接口方法类中的参数名->参数索引
	private List<String> paramOrder;// sql语句中的参数名顺序
	private List<Object> paramValueList;// sql语句中的参数值顺序

	public Paramter(HashMap<String, Integer> paramMap) {
		this.paramMap = paramMap;
		this.paramOrder = new ArrayList();
		this.paramValueList = new ArrayList();
	}

	/**
	 * 根据提取出的sql参数名，映射接口方法中的参数值
	 * 
	 * @param param
	 *            接口中的参数值
	 */
	public void paramterMapper(Object[] param) {
		int length = param.length;
		// 无参
		if (length == 0) {
			return;
		}
		// 一个参数
		if (length == 1 && !param[0].getClass().getSimpleName().equals("HashMap")) {
			parseOneParam(param[0]);
		}
		// 单个hashmap
		if (length == 1 && param[0].getClass().getSimpleName().equals("HashMap")) {
			for (String key : paramOrder) {
				paramValueList.add(((HashMap) param[0]).get(key));
			}
		}

		// 多个参数,必须每个参数都要加注解 两次遍历以后优化!!!!!
		if (length != 1 && paramMap.size() == param.length) {
			parseMoreParam(param);
		}

	}

	/**
	 * 解析多个参数
	 * 
	 * @param param
	 */
	private void parseMoreParam(Object[] param) {
		for (String sqlParamName : paramOrder) {
			for (int i = 0; i < param.length; i++) {

				if (!sqlParamName.contains(".")) {
					Integer index = paramMap.get(sqlParamName);
					if (isBaiscType(param[index])) {
						paramValueList.add(param[index]);
						break;
					} else {
						// 异常
					}
				} else {
					String[] str = sqlParamName.split("\\.");
					String firstName = str[0];
					Integer index = paramMap.get(firstName);
					if (!isBaiscType(param[index])) {
						Map<String, Object> map = parseOneReference(param[index]);
						String name = null;
						Object value = null;
						for (int idx = 1; i < str.length; i++) {
							name = str[idx];
							value = (String) map.get(name);
							if (!isBaiscType(value)) {
								map = parseOneReference(value);
							}
						}

						paramValueList.add(value);
						break;

					} else {
						// 异常
					}
				}
			}

		}

	}

	public List<String> getParamOrder() {
		return paramOrder;
	}

	/**
	 * 解析一个参数的情况 分两种情况，单个简单类型，单个复杂类型
	 * 
	 * @param param
	 */
	private void parseOneParam(Object param) {
		if (isBaiscType(param)) {
			paramValueList.add(param);
		} else {
			// 如果sql语句中的参数名字是user.id 先取id再key取值
			Map<String, Object> map = parseOneReference(param);
			for (String name : paramOrder) {
				String[] str = name.split("\\.");
				Object value = null;
				for (int i = 1; i < str.length; i++) {
					name = str[i];
					value = map.get(name);
					if (!isBaiscType(value)) {
						map = parseOneReference(value);
					}
				}

				paramValueList.add(value);
			}
		}

	}

	/**
	 * 解析单个复杂引用类型
	 */
	private Map<String, Object> parseOneReference(Object param) {
		Map<String, Object> map = new HashMap();
		Field[] fields = param.getClass().getDeclaredFields();
		for (Field field : fields) {
			String name = field.getName();
			Object value = null;
			try {
				field.setAccessible(true);
				value = field.get(param);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
			map.put(name, value);
		}
		return map;
	}

	private boolean isBaiscType(Object param) {
		String paramSimpleName = param.getClass().getSimpleName();
		if (paramSimpleName.equals("Integer")) {
			return true;
		} else if (paramSimpleName.equals("Byte")) {
			return true;
		} else if (paramSimpleName.equals("Boolean")) {
			return true;
		} else if (paramSimpleName.equals("Short")) {
			return true;
		} else if (paramSimpleName.equals("Character")) {
			return true;
		} else if (paramSimpleName.equals("Long")) {
			return true;
		} else if (paramSimpleName.equals("Float")) {
			return true;
		} else if (paramSimpleName.equals("Double")) {
			return true;
		} else if (paramSimpleName.equals("String")) {
			return true;
		}
		return false;
	}

	public List<Object> getParamValueList() {
		return paramValueList;
	}

}

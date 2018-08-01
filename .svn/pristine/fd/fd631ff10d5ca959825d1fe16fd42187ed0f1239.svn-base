package jxau.spectrum.frame.dataAccess.Proxy;

import jxau.spectrum.frame.dataAccess.ParamterHandle.Paramter;
import jxau.spectrum.frame.dataAccess.Utils.StringUtils;

/**
 * 一个接口方法的信息
 * @author Aaron
 *
 */
public class MethodSqlInfo {

	private String sql;//sql语句
	private String paramterType;//参数类型
	private String result;		//接口方法中的返回值
	private Paramter paramter;  //参数类型

	

	public MethodSqlInfo(String sql, String paramterType, String result, Paramter paramter) {
		this.sql = sql;
		this.paramterType = paramterType;
		this.result = result;
		this.paramter = paramter;
	}

	/**
	 * 解析sql
	 * 然后解析参数组装成list数组
	 * @param param
	 */
	public void parse(Object[] param){
		//这里已经解析了sql并且将sql中的参数名list集合组装到了paramter参数中
		this.sql = StringUtils.replaceSubString(sql, paramter.getParamOrder());
		paramter.paramterMapper(param);
	}
	
	public String getSqlType(){
		String first = this.sql.split(" ")[0];
		first = first.toLowerCase();
		return first;
	}

	public String getSql() {
		return sql;
	}

	public Paramter getParamter() {
		return paramter;
	}
	
	public String getResult() {
		return result;
	}
}

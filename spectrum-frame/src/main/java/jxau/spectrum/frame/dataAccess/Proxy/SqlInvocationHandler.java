package jxau.spectrum.frame.dataAccess.Proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.ResultSet;

import jxau.spectrum.frame.dataAccess.Excuter.SqlExcuter;
import jxau.spectrum.frame.dataAccess.ResultSetHandle.ResultSetHandle;


public class SqlInvocationHandler implements InvocationHandler {

	// 目标对象   
    private MapperProxy target;  
      
    
    /** 
     * 构造方法 
     * @param target 目标对象  
     */  
    public SqlInvocationHandler(MapperProxy target) {  
        this.target = target;  
    }  
  
  
    /** 
     * 执行目标对象的方法 
     */  
    public Object invoke(Object proxy, Method method, Object[] param) throws Throwable {  
          
        // 在目标对象的方法执行之前简单的打印一下  
        System.out.println("------------------before------------------");  
        
        //找到方法名称
        String methodName = method.getName();
        MethodSqlInfo info = target.getMethodSqlInfo(methodName);
        //解析参数
        info.parse(param);
        //sql执行器执行 ,以后修改
        SqlExcuter excuter = new SqlExcuter();
        String type = info.getSqlType();
        ResultSet resultSet = null;
        int resultNumber = -1;
        if("select".equals(type)){
        	resultSet = excuter.query(info.getSql(),info.getParamter().getParamValueList());
        	ResultSetHandle resultSetHandle = new  ResultSetHandle(target.getMap());
        	return resultSetHandle.resultInstance(resultSet, info.getResult());
        }else{
        	resultNumber = excuter.excuterUpdate(info.getSql(),info.getParamter().getParamValueList());
        	return resultNumber;
        }
    }  
  
    /** 
     * 获取目标对象的代理对象 
     * @return 代理对象 
     */  
    public Object getProxy(Class clazz) {  
        return Proxy.newProxyInstance(Thread.currentThread().getContextClassLoader(),   
        		 new Class[] { clazz }, this);  
    }  
    
   
}  




package bluedot.spectrum.service;

import java.io.OutputStream;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.Part;

/**
 * 工具模块
 * @author zclong
 * 2018年1月20日
 */
public interface UtilService {
	/**
	 * 文件上传
	 * 2018年1月20日
	 * zclong
	 * @param param	传入part集合
	 */
	void upload(Collection<Part> param);
	
	/**
	 * 下载模块
	 * 2018年1月20日
	 * zclong
	 * @param url 下载文件url
	 * @return 返回文件输出流
	 */
	OutputStream download(String url);
	
	/**
	 * 发送邮件的工具类
	 * 2018年1月20日
	 * zclong	
	 * @param param	传入一个封装的类
	 */
	void sendMail(Class<?> param);
	
	/**
	 * 使用md5加密字符串
	 * 2018年1月20日
	 * zclong
	 * @param param	需要加密的字符串
	 * @return	加密后的字符串
	 */
	String md5(String param);
	
	/**
	 * 数据校验(是否为空或非法字符串)
	 * 2018年1月20日
	 * zclong
	 * @param param	需要校验的数据集合
	 * @return	返回校验的结果
	 */	
	Boolean dataValidation(Map<String, Object> param);
}

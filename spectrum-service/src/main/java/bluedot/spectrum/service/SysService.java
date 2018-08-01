package bluedot.spectrum.service;

/**
 * 系统维护模块
 * @author zclong
 * 2018年1月20日
 */
public interface SysService {
	/**
	 * 数据库备份
	 * 2018年1月20日
	 * zclong
	 * @param url 备份到目标文件下
	 * @return	备份结果
	 */
	boolean backup(String url);
	
	/**
	 * 数据库恢复
	 * 2018年1月20日
	 * zclong
	 * @param url 需要恢复的sql文件
	 * @return 返回恢复结果
	 */
	boolean recover(String url);
}

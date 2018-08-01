package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * Syslog -> syslog
 * 2018-01-21
 */
public class Syslog {
    private Long logId;
    
    /**
     * 用户真实姓名
     */
    private String userName;

    public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
     * 用户编号
     */
    private Long userId;

    /**
     * 用户ip地址
     */
    private String ip;

    /**
     * 操作具体内容
     */
    private String opetateContent;

    /**
     * 操作级别
     */
    private String logLever;

    /**
     * 功能编号
     */
    private Long functionId;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getLogId() {
        return logId;
    }

    public void setLogId(Long logId) {
        this.logId = logId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getOpetateContent() {
        return opetateContent;
    }

    public void setOpetateContent(String opetateContent) {
        this.opetateContent = opetateContent;
    }

    public String getLogLever() {
        return logLever;
    }

    public void setLogLever(String logLever) {
        this.logLever = logLever;
    }

    public Long getFunctionId() {
        return functionId;
    }

    public void setFunctionId(Long functionId) {
        this.functionId = functionId;
    }

    public Date getGmtCreate() {
        return gmtCreate;
    }

    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }

    public Date getGmtModified() {
        return gmtModified;
    }

    public void setGmtModified(Date gmtModified) {
        this.gmtModified = gmtModified;
    }
}
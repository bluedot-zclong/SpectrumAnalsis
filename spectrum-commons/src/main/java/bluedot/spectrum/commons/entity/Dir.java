package bluedot.spectrum.commons.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * Dir -> dir
 * 2018-01-21
 */
public class Dir implements Serializable{
    private Long dirId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 文件夹名称
     */
    private String dirName;

    /**
     * 文件夹所属类型，0表示光谱文件夹，1表示算法文件
     */
    private Integer dirTypeId;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getDirId() {
        return dirId;
    }

    public void setDirId(Long dirId) {
        this.dirId = dirId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getDirName() {
        return dirName;
    }

    public void setDirName(String dirName) {
        this.dirName = dirName;
    }

    public Integer getDirTypeId() {
		return dirTypeId;
	}

	public void setDirTypeId(Integer dirTypeId) {
		this.dirTypeId = dirTypeId;
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

	@Override
	public String toString() {
		return "Dir [dirId=" + dirId + ", userId=" + userId + ", dirName=" + dirName + ", dirTypeId=" + dirTypeId
				+ ", gmtCreate=" + gmtCreate + ", gmtModified=" + gmtModified + "]";
	}
    
}
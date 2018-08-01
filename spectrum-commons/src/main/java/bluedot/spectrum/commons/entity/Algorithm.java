package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * Algorithm -> algorithm
 * 2018-01-21
 */
public class Algorithm {
    /**
     * 自增，算法的主键
     */
    private Long algorithmId;

    /**
     * 算法编号16位 （20170101XXXXXXXX）后面为uuid,防止重复
     */
    private Integer algorithmVersion;

    /**
     * 用户上传时所命名（可修改）
     */
    private String algorithmName;

    /**
     * 算法类别,0代表预处理算法、1代表分析算法
     */
    private Integer algorithmSort;

    /**
     * 算法上传时间
     */
    private Date algorithmUploadtime;

    /**
     * 上传时对算法的描述（可修改)
     */
    private String algorithmDscription;

    /**
     * 算法语言类型
     */
    private String algorithmLanguage;

    /**
     * 算法本地文件路径
     */
    private String algorithmRealPath;

    /**
     * 文件夹id
     */
    private Long dirFileId;

    /**
     * 删除状态，0代表未删除，1代表在回收站，2代表彻底删除
     */
    private Integer isDeleted;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getAlgorithmId() {
        return algorithmId;
    }

    public void setAlgorithmId(Long algorithmId) {
        this.algorithmId = algorithmId;
    }

    public Integer getAlgorithmVersion() {
        return algorithmVersion;
    }

    public void setAlgorithmVersion(Integer algorithmVersion) {
        this.algorithmVersion = algorithmVersion;
    }

    public String getAlgorithmName() {
        return algorithmName;
    }

    public void setAlgorithmName(String algorithmName) {
        this.algorithmName = algorithmName;
    }

    public Integer getAlgorithmSort() {
        return algorithmSort;
    }

    public void setAlgorithmSort(Integer algorithmSort) {
        this.algorithmSort = algorithmSort;
    }

    public Date getAlgorithmUploadtime() {
        return algorithmUploadtime;
    }

    public void setAlgorithmUploadtime(Date algorithmUploadtime) {
        this.algorithmUploadtime = algorithmUploadtime;
    }

    public String getAlgorithmDscription() {
        return algorithmDscription;
    }

    public void setAlgorithmDscription(String algorithmDscription) {
        this.algorithmDscription = algorithmDscription;
    }

    public String getAlgorithmLanguage() {
        return algorithmLanguage;
    }

    public void setAlgorithmLanguage(String algorithmLanguage) {
        this.algorithmLanguage = algorithmLanguage;
    }

    public String getAlgorithmRealPath() {
        return algorithmRealPath;
    }

    public void setAlgorithmRealPath(String algorithmRealPath) {
        this.algorithmRealPath = algorithmRealPath;
    }

    public Long getDirFileId() {
        return dirFileId;
    }

    public void setDirFileId(Long dirFileId) {
        this.dirFileId = dirFileId;
    }

    public Integer getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Integer isDeleted) {
        this.isDeleted = isDeleted;
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
		return "Algorithm [algorithmId=" + algorithmId + ", algorithmVersion=" + algorithmVersion + ", algorithmName="
				+ algorithmName + ", algorithmSort=" + algorithmSort + ", algorithmUploadtime=" + algorithmUploadtime
				+ ", algorithmDscription=" + algorithmDscription + ", algorithmLanguage=" + algorithmLanguage
				+ ", algorithmRealPath=" + algorithmRealPath + ", dirFileId=" + dirFileId + ", isDeleted=" + isDeleted
				+ ", gmtCreate=" + gmtCreate + ", gmtModified=" + gmtModified + "]";
	}
    
    
}
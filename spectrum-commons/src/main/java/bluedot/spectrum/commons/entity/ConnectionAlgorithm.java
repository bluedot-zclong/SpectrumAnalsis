package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * ConnectionAlgorithm -> connection_algorithm
 * 2018-01-21
 */
public class ConnectionAlgorithm {
    /**
     * 组合线id，主键
     */
    private Long connectionAlgorithmId;

    /**
     * 检验线组合编号（20170101XXXXXXXX）后面为uuid,防止重复
     */
    private Integer connectionAlgorithmVersion;

    /**
     * 硬件ID(在硬件类型表和光谱类型表合并后放光谱类型名字)
     */
    private Long hardwareId;

    /**
     * 检验线名称
     */
    private String connectionAlgorithmName;

    /**
     * 分析算法ID(算法id外键)
     */
    private Long analysisAlgorithmId;

    /**
     * 预处理算法ID(算法id外键)
     */
    private Long pretreatmentAlgorithmId;

    /**
     * 国际标准，如国标
     */
    private String standardName;

    /**
     * 检验线组合状态，0代表未开、1代表公开、2代表审核中、3代表已删除
     */
    private Integer connectionAlgorithmState;

    /**
     * 组合线描述
     */
    private String connectionAlgorithmDescribe;

    /**
     * 用户id
     */
    private Long userId;

    private Date connectionAlgorithmSaveTime;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getConnectionAlgorithmId() {
        return connectionAlgorithmId;
    }

    public void setConnectionAlgorithmId(Long connectionAlgorithmId) {
        this.connectionAlgorithmId = connectionAlgorithmId;
    }

    public Integer getConnectionAlgorithmVersion() {
        return connectionAlgorithmVersion;
    }

    public void setConnectionAlgorithmVersion(Integer connectionAlgorithmVersion) {
        this.connectionAlgorithmVersion = connectionAlgorithmVersion;
    }

    public Long getHardwareId() {
        return hardwareId;
    }

    public void setHardwareId(Long hardwareId) {
        this.hardwareId = hardwareId;
    }

    public String getConnectionAlgorithmName() {
        return connectionAlgorithmName;
    }

    public void setConnectionAlgorithmName(String connectionAlgorithmName) {
        this.connectionAlgorithmName = connectionAlgorithmName;
    }

    public Long getAnalysisAlgorithmId() {
        return analysisAlgorithmId;
    }

    public void setAnalysisAlgorithmId(Long analysisAlgorithmId) {
        this.analysisAlgorithmId = analysisAlgorithmId;
    }

    public Long getPretreatmentAlgorithmId() {
        return pretreatmentAlgorithmId;
    }

    public void setPretreatmentAlgorithmId(Long pretreatmentAlgorithmId) {
        this.pretreatmentAlgorithmId = pretreatmentAlgorithmId;
    }

    public String getStandardName() {
        return standardName;
    }

    public void setStandardName(String standardName) {
        this.standardName = standardName;
    }

    public Integer getConnectionAlgorithmState() {
        return connectionAlgorithmState;
    }

    public void setConnectionAlgorithmState(Integer connectionAlgorithmState) {
        this.connectionAlgorithmState = connectionAlgorithmState;
    }

    public String getConnectionAlgorithmDescribe() {
        return connectionAlgorithmDescribe;
    }

    public void setConnectionAlgorithmDescribe(String connectionAlgorithmDescribe) {
        this.connectionAlgorithmDescribe = connectionAlgorithmDescribe;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUseriId(Long userId) {
        this.userId = userId;
    }

    public Date getConnectionAlgorithmSaveTime() {
        return connectionAlgorithmSaveTime;
    }

    public void setConnectionAlgorithmSaveTime(Date connectionAlgorithmSaveTime) {
        this.connectionAlgorithmSaveTime = connectionAlgorithmSaveTime;
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
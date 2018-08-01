package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * Report -> report
 * 2018-01-21
 */
public class Report {
    /**
     * 光谱分析报告编号
     */
    private Long reportId;

    /**
     * 用户编号
     */
    private Long userId;

    /**
     * 光谱类型名
     */
    private String spectrumTypeName;

    /**
     * 检测时间
     */
    private Date checkTime;

    /**
     * 标准含量
     */
    private String standardContent;

    /**
     * 执行标准
     */
    private String standards;

    /**
     * 单位
     */
    private String unit;

    /**
     * 是否合格，0表示合格，1表示不合格
     */
    private Integer regular;

    /**
     * 是否超标
     */
    private String limit;

    /**
     * 光谱的主键编号
     */
    private Long spectruminfoId;

    /**
     * 被检测物名字
     */
    private String detectedName;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getReportId() {
        return reportId;
    }

    public void setReportId(Long reportId) {
        this.reportId = reportId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getSpectrumTypeName() {
        return spectrumTypeName;
    }

    public void setSpectrumTypeName(String spectrumTypeName) {
        this.spectrumTypeName = spectrumTypeName;
    }

    public Date getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(Date checkTime) {
        this.checkTime = checkTime;
    }

    public String getStandardContent() {
        return standardContent;
    }

    public void setStandardContent(String standardContent) {
        this.standardContent = standardContent;
    }

    public String getStandards() {
        return standards;
    }

    public void setStandards(String standards) {
        this.standards = standards;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Integer getRegular() {
        return regular;
    }

    public void setRegular(Integer regular) {
        this.regular = regular;
    }

    public String getLimit() {
        return limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }

    public Long getSpectruminfoId() {
        return spectruminfoId;
    }

    public void setSpectruminfoId(Long spectruminfoId) {
        this.spectruminfoId = spectruminfoId;
    }

    public String getDetectedName() {
        return detectedName;
    }

    public void setDetectedName(String detectedName) {
        this.detectedName = detectedName;
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
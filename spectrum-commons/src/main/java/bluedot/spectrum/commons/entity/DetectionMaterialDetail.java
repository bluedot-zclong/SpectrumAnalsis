package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * DetectionMaterialDetail -> detection_material_detail
 * 2018-01-21
 */
public class DetectionMaterialDetail {
    /**
     * 检测物质细节id
     */
    private Long materialDetailId;

    /**
     * 报告ID
     */
    private Long reportId;

    /**
     * 检测的内容如：性激素、毒素、重金属等(换成json串)
     */
    private String materialName;

    /**
     * 数据值
     */
    private String materialValue;

    /**
     * 标准数据对应值
     */
    private String standardValue;

    /**
     * 该检测内容含量是否超标，0表示未超标，1表示超标
     */
    private Integer isExcessive;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getMaterialDetailId() {
        return materialDetailId;
    }

    public void setMaterialDetailId(Long materialDetailId) {
        this.materialDetailId = materialDetailId;
    }

    public Long getReportId() {
        return reportId;
    }

    public void setReportId(Long reportId) {
        this.reportId = reportId;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public String getMaterialValue() {
        return materialValue;
    }

    public void setMaterialValue(String materialValue) {
        this.materialValue = materialValue;
    }

    public String getStandardValue() {
        return standardValue;
    }

    public void setStandardValue(String standardValue) {
        this.standardValue = standardValue;
    }

    public Integer getIsExcessive() {
        return isExcessive;
    }

    public void setIsExcessive(Integer isExcessive) {
        this.isExcessive = isExcessive;
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
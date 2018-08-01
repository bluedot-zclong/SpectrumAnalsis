package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * DetectedObject -> detected_object
 * 2018-01-21
 */
public class DetectedObject {
    /**
     * 被检测物编号
     */
    private Long detectedObjectsId;

    /**
     * 被检测物分类编号
     */
    private Long detectedTypeId;

    /**
     * 被检测物名称
     */
    private String detectedObjectsName;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getDetectedObjectsId() {
        return detectedObjectsId;
    }

    public void setDetectedObjectsId(Long detectedObjectsId) {
        this.detectedObjectsId = detectedObjectsId;
    }

    public Long getDetectedTypeId() {
        return detectedTypeId;
    }

    public void setDetectedTypeId(Long detectedTypeId) {
        this.detectedTypeId = detectedTypeId;
    }

    public String getDetectedObjectsName() {
        return detectedObjectsName;
    }

    public void setDetectedObjectsName(String detectedObjectsName) {
        this.detectedObjectsName = detectedObjectsName;
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
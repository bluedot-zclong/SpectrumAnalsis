package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * ConnectionAlgorithmDetectionMaterial -> connection_algorithm_detection_material
 * 2018-01-21
 */
public class ConnectionAlgorithmDetectionMaterial {
    private Long cadmId;

    /**
     * 检验线-被检测物id做外键
     */
    private Long cadoId;

    /**
     * 检测内容名称
     */
    private String detectionMaterialName;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getCadmId() {
        return cadmId;
    }

    public void setCadmId(Long cadmId) {
        this.cadmId = cadmId;
    }

    public Long getCadoId() {
        return cadoId;
    }

    public void setCadoId(Long cadoId) {
        this.cadoId = cadoId;
    }

    public String getDetectionMaterialName() {
        return detectionMaterialName;
    }

    public void setDetectionMaterialName(String detectionMaterialName) {
        this.detectionMaterialName = detectionMaterialName;
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
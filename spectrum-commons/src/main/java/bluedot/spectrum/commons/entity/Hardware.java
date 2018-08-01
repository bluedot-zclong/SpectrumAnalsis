package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * Hardware -> hardware
 * 2018-01-21
 */
public class Hardware {
    /**
     * 设备编号
     */
    private Long hardwareId;

    /**
     * 硬件类型
     */
    private String hardwareType;

    /**
     * 设备名称
     */
    private String hardwareName;

    /**
     * 硬件支持的光谱编号唯一不能重复
     */
    private Long spectrumTypeId;

    /**
     * 是否可用（1：表示可用，0：表示不可用）
     */
    private Integer isDelete;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getHardwareId() {
        return hardwareId;
    }

    public void setHardwareId(Long hardwareId) {
        this.hardwareId = hardwareId;
    }

    public String getHardwareType() {
        return hardwareType;
    }

    public void setHardwareType(String hardwareType) {
        this.hardwareType = hardwareType;
    }

    public String getHardwareName() {
        return hardwareName;
    }

    public void setHardwareName(String hardwareName) {
        this.hardwareName = hardwareName;
    }

    public Long getSpectrumTypeId() {
        return spectrumTypeId;
    }

    public void setSpectrumTypeId(Long spectrumTypeId) {
        this.spectrumTypeId = spectrumTypeId;
    }

    public Integer getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(Integer isDelete) {
        this.isDelete = isDelete;
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
		return "Hardware [hardwareId=" + hardwareId + ", hardwareType=" + hardwareType + ", hardwareName="
				+ hardwareName + ", spectrumTypeId=" + spectrumTypeId + ", isDelete=" + isDelete + "]";
	}
    
}
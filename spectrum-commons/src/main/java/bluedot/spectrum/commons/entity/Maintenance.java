package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * Maintenance -> maintenance
 * 2018-01-21
 */
public class Maintenance {
    /**
     * 维护编号
     */
    private Long maintenanceId;

    /**
     * 维护名称
     */
    private String maintenanceName;

    /**
     * 0代表备份  1代表恢复
     */
    private Integer maintenanceType;

    /**
     * 备份/恢复的内容
     */
    private String maintenanceContent;

    /**
     * 维护/备份的描述
     */
    private String maintenanceDescribe;

    /**
     * 操作是备份时,备份文件的路径(恢复没有)
     */
    private String maintenanceFileAddress;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getMaintenanceId() {
        return maintenanceId;
    }

    public void setMaintenanceId(Long maintenanceId) {
        this.maintenanceId = maintenanceId;
    }

    public String getMaintenanceName() {
        return maintenanceName;
    }

    public void setMaintenanceName(String maintenanceName) {
        this.maintenanceName = maintenanceName;
    }

    public Integer getMaintenanceType() {
        return maintenanceType;
    }

    public void setMaintenanceType(Integer maintenanceType) {
        this.maintenanceType = maintenanceType;
    }

    public String getMaintenanceContent() {
        return maintenanceContent;
    }

    public void setMaintenanceContent(String maintenanceContent) {
        this.maintenanceContent = maintenanceContent;
    }

    public String getMaintenanceDescribe() {
        return maintenanceDescribe;
    }

    public void setMaintenanceDescribe(String maintenanceDescribe) {
        this.maintenanceDescribe = maintenanceDescribe;
    }

    public String getMaintenanceFileAddress() {
        return maintenanceFileAddress;
    }

    public void setMaintenanceFileAddress(String maintenanceFileAddress) {
        this.maintenanceFileAddress = maintenanceFileAddress;
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
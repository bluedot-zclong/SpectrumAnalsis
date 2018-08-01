package bluedot.spectrum.commons.entity;

import java.util.Date;

/**
 * SpectrumType -> spectrum_type
 * 2018-01-21
 */
public class SpectrumType {
    /**
     * 光谱类型编号
     */
    private Long spectrumtypeId;

    /**
     * 光谱类型
     */
    private String spectrumtypeName;

    /**
     * 创建时间
     */
    private Date gmtCreate;

    /**
     * 最后修改时间
     */
    private Date gmtModified;

    private static final long serialVersionUID = 1L;

    public Long getSpectrumtypeId() {
        return spectrumtypeId;
    }

    public void setSpectrumtypeId(Long spectrumtypeId) {
        this.spectrumtypeId = spectrumtypeId;
    }

    public String getSpectrumtypeName() {
        return spectrumtypeName;
    }

    public void setSpectrumtypeName(String spectrumtypeName) {
        this.spectrumtypeName = spectrumtypeName;
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
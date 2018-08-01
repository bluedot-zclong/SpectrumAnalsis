package bluedot.spectrum.commons.vo;

import java.util.Date;
import java.util.List;

import com.mysql.jdbc.CachedResultSetMetaData;

import bluedot.spectrum.commons.entity.Algorithm;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectedObject;
import bluedot.spectrum.commons.entity.ConnectionAlgorithmDetectionMaterial;

/**
 * @ClassName: DetechLine
 * @Description:TODO
 * @author: MangoDai
 * @date: 2018年4月21日 下午7:56:32
 * 
 */
public class DetechLine {
	private Long connectionAlgorithmId;

	private Integer connectionAlgorithmVersion;

	private String connectionAlgorithmName;

	private String standardName;

	private int connectionAlgorithmState;

	private String connectionAlgorithmDescribe;

	private Date connectionAlgorithmSaveTime;

	private Date gmtCreate;

	private Date gmtModified;

	private String userName;

	private String hardwareName;

	private Long analysisAlgorithmId;

	private Long pretreatmentAlgorithmId;

	/**
	 * 预处理算法
	 */
	private Algorithm pretreatmentAlgorithm;

	/**
	 * 分析算法
	 */
	private Algorithm analysisAlgorithm;

	private List<ConnectionAlgorithmDetectedObject> cado;

	private List<ConnectionAlgorithmDetectionMaterial> cadm;

	public Algorithm getPretreatmentAlgorithm() {
		return pretreatmentAlgorithm;
	}

	public List<ConnectionAlgorithmDetectedObject> getCado() {
		return cado;
	}

	public void setCado(List<ConnectionAlgorithmDetectedObject> cado) {
		this.cado = cado;
	}

	public List<ConnectionAlgorithmDetectionMaterial> getCadm() {
		return cadm;
	}

	public void setCadm(List<ConnectionAlgorithmDetectionMaterial> cadm) {
		this.cadm = cadm;
	}

	public void setPretreatmentAlgorithm(Algorithm pretreatmentAlgorithm) {
		this.pretreatmentAlgorithm = pretreatmentAlgorithm;
	}

	public Algorithm getAnalysisAlgorithm() {
		return analysisAlgorithm;
	}

	public void setAnalysisAlgorithm(Algorithm analysisAlgorithm) {
		this.analysisAlgorithm = analysisAlgorithm;
	}

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

	public String getConnectionAlgorithmName() {
		return connectionAlgorithmName;
	}

	public void setConnectionAlgorithmName(String connectionAlgorithmName) {
		this.connectionAlgorithmName = connectionAlgorithmName == null ? null : connectionAlgorithmName.trim();
	}

	public String getStandardName() {
		return standardName;
	}

	public void setStandardName(String standardName) {
		this.standardName = standardName == null ? null : standardName.trim();
	}

	public int getConnectionAlgorithmState() {
		return connectionAlgorithmState;
	}

	public void setConnectionAlgorithmState(int connectionAlgorithmState) {
		this.connectionAlgorithmState = connectionAlgorithmState;
	}

	public String getConnectionAlgorithmDescribe() {
		return connectionAlgorithmDescribe;
	}

	public void setConnectionAlgorithmDescribe(String connectionAlgorithmDescribe) {
		this.connectionAlgorithmDescribe = connectionAlgorithmDescribe == null ? null
				: connectionAlgorithmDescribe.trim();
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName == null ? null : userName.trim();
	}

	public String getHardwareName() {
		return hardwareName;
	}

	public void setHardwareName(String hardwareName) {
		this.hardwareName = hardwareName == null ? null : hardwareName.trim();
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
}
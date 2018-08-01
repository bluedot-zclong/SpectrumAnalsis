package bluedot.spectrum.utils.upload;
/**
 * 文件vo类
 * @ClassName: FileEntry
 * @author WFP
 * @date 2018年3月18日 下午3:45:56
 * @Description: TODO
 *
 */
public class FileEntry {
	//file类型
	private String mimeType;	//文件类型
		
	private String filePath;	//存储路径
	
	private String fileName;	//上传文件名
	
	
	private boolean isSimpleField;
	
	private String paramName;
	
	private String paramValue;

	public String getMimeType() {
		return mimeType;
	}

	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public boolean isSimpleField() {
		return isSimpleField;
	}

	public void setSimpleField(boolean isSimpleField) {
		this.isSimpleField = isSimpleField;
	}

	public String getParamName() {
		return paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getParamValue() {
		return paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}
	
}

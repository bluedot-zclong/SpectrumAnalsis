package bluedot.spectrum.utils.upload;

public enum FileDirType {
	ALGORITHM("算法"),SPECTRUM("光谱"),OTHER("其他");

	String type;

	private FileDirType(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}	
}

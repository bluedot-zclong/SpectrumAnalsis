package bluedot.spectrum.dao.entry;

public class DataResult<T> {
	
	//结果类型
	private Integer type;
	//结果主体
	private T boy;
	
	public DataResult(Integer type, T boy) {
		this.type = type;
		this.boy = boy;
	}
	
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public T getBoy() {
		return boy;
	}
	public void setBoy(T boy) {
		this.boy = boy;
	}
	
}

package bluedot.spectrum.utils.algorithm.cache;
/**
 * 
 * @ClassName: AlgorithmEntry
 * @author WFP
 * @date 2018年3月10日 下午2:14:27
 * @Description: 算法缓存链表
 *
 * @param <K> 键
 * @param <V> 值
 */
public class AlgorithmEntry<K,V>{
	private AlgorithmEntry pre;
	private AlgorithmEntry next;
	private K key;
	private V value;
	
	public AlgorithmEntry(K key,V value){
		this.key = key;
		this.value = value;
	}
	
	public AlgorithmEntry() {
		super();
	}
	public AlgorithmEntry getPre() {
		return pre;
	}
	public void setPre(AlgorithmEntry pre) {
		this.pre = pre;
	}
	public AlgorithmEntry getNext() {
		return next;
	}
	public void setNext(AlgorithmEntry next) {
		this.next = next;
	}
	public K getKey() {
		return key;
	}
	public void setKey(K key) {
		this.key = key;
	}
	public V getValue() {
		return value;
	}
	public void setValue(V value) {
		this.value = value;
	}
	
}

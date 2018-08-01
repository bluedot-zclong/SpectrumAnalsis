package bluedot.spectrum.utils.algorithm.cache;

import java.util.HashMap;
import java.util.concurrent.ConcurrentHashMap;

import bluedot.spectrum.commons.algorithm.method.PretreatmentAlgorithm;
/**
 * 
 * @ClassName: AlgorithmCache
 * @author WFP
 * @date 2018年3月10日 上午11:23:32
 * @Description: 算法缓存
 *
 * @param <K>
 * @param <V>
 */
public class AlgorithmCache<K, V> {
	
	private final int MAX_CACHE_SIZE;
	private AlgorithmEntry first;
	private AlgorithmEntry last;
	
	private ConcurrentHashMap<String, AlgorithmEntry<String, PretreatmentAlgorithm>> concurrentHashMap;
	
	public AlgorithmCache(int mAX_CACHE_SIZE) {
		MAX_CACHE_SIZE = mAX_CACHE_SIZE;	
		concurrentHashMap = EnumSingleton.ALGORItHMCACHE.getInstance();
	}
	
	public void put (K key, AlgorithmEntry<String, PretreatmentAlgorithm> algorithmEntry2) {
		AlgorithmEntry algorithmEntry = getAlgorithmEntry(key);
		
		if(algorithmEntry == null){
			if(concurrentHashMap.size()>MAX_CACHE_SIZE){
				concurrentHashMap.remove(last.getKey());
				removeLast();
			}
			
			algorithmEntry = new AlgorithmEntry<>();
			algorithmEntry.setKey(key);
		}
		algorithmEntry.setValue(algorithmEntry2);
		moveToFirst(algorithmEntry);
		concurrentHashMap.put( (String) key, algorithmEntry);
	}
	
	public AlgorithmEntry<K, V> get (K key){
		AlgorithmEntry<K, V> algorithmEntry = (AlgorithmEntry<K, V>) getAlgorithmEntry(key);
		if(algorithmEntry == null)return null;
		moveToFirst(algorithmEntry);
		return algorithmEntry;
	}
	
	public void remove(K key){
		AlgorithmEntry<K, V> algorithmEntry = (AlgorithmEntry<K, V>) getAlgorithmEntry(key);
		if(algorithmEntry != null){
			if(algorithmEntry.getPre() != null){
				algorithmEntry.getPre().setNext(algorithmEntry.getNext());
			}
			if(algorithmEntry.getNext() != null){
				algorithmEntry.getNext().setPre(algorithmEntry.getPre());
			}
			if(first == algorithmEntry){
				first = algorithmEntry.getNext();
			}
			if(last == algorithmEntry){
				last = algorithmEntry.getPre();
			}
		}
		concurrentHashMap.remove(key);
	}
	
	private void moveToFirst(AlgorithmEntry<K, V> algorithmEntry){
		if(first == algorithmEntry){
			return;
		}
		if(algorithmEntry.getPre() != null ){
			algorithmEntry.getPre().setNext(algorithmEntry.getNext());
		}
		if(algorithmEntry.getNext() != null){
			algorithmEntry.getNext().setKey(algorithmEntry.getPre());
		}
		if(last == algorithmEntry){
			last = last.getPre();
		}
		if(first == null || last ==null){
			first = last = algorithmEntry;
			return;
		}
		
		algorithmEntry.setNext(first);
		first = algorithmEntry;
		algorithmEntry.setPre(null);
		
	}
	private void removeLast(){
		if(last != null){
			last = last.getPre();
			if(last == null)
				first = null;
			else
				last.setNext(null);
		}
	}
	
	private AlgorithmEntry<String, PretreatmentAlgorithm> getAlgorithmEntry(K key){
		return concurrentHashMap.get(key);
	}

	@Override
	public String toString(){
		StringBuilder sb = new StringBuilder();
		AlgorithmEntry<K, V> algorithmEntry = first;
		while(algorithmEntry != null){
			sb.append(String.format("%s:%s", algorithmEntry.getKey(),algorithmEntry.getValue()));
			algorithmEntry = algorithmEntry.getNext();
		}
		return sb.toString();
		
	}
}

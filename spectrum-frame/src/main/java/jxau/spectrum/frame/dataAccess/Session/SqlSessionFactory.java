package jxau.spectrum.frame.dataAccess.Session;

public class SqlSessionFactory {
	
	private static class SingletonHolder {
		private static final SqlSessionFactory INSTANCE = new SqlSessionFactory();
	}

	private SqlSessionFactory(){}

	public static final SqlSessionFactory getInstance() {
		return SingletonHolder.INSTANCE;
	} 
	
	public Session getSession(){
		return new Session();
	}
}

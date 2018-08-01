package bluedot.spectrum.commons.index.exception;
/**
 * 
 * @author Harold
 * @date 2018年3月21日 
 * @description: 空文件名异常
 */
public class NullFileNameException extends Exception{
	public NullFileNameException(){

    }

    public  NullFileNameException(String message){
        super(message);
    }
}

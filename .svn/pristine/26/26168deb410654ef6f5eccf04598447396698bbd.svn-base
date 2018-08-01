package jxau.spectrum.frame.web.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**   
 * @ClassName:  DevMode   
 * @Description: 开发者模式
 * @author: MangoDai
 * @date:   2018年4月21日 下午4:15:07   
 * 
 */
@Documented // 声明注解
@Target(ElementType.FIELD) // 表示该注解作用字段上
@Retention(RetentionPolicy.RUNTIME) // 作用的范围，声明为运行时状态
public @interface DevMode {
	// 值是value
	boolean value() default false;
}


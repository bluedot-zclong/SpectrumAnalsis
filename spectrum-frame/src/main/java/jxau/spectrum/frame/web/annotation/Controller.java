package jxau.spectrum.frame.web.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义Controller注解
 * @author zclong
 * 2018年1月4日
 */
@Documented // 声明注解
@Target(ElementType.TYPE) // 表示该注解作用在类上
@Retention(RetentionPolicy.RUNTIME) // 作用的范围，声明为运行时状态
public @interface Controller {
	// 值是value
	String value() default "";
}

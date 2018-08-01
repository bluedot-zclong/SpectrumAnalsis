package jxau.spectrum.frame.web.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义RequestParam注解
 * @author zclong
 * 2018年1月4日
 */
@Documented // 声明注解
@Target(ElementType.PARAMETER) // 表示该注解作用在参数上
@Retention(RetentionPolicy.RUNTIME) // 作用的范围，声明为运行时状态
public @interface RequestParam {
	// 值是value
	String value() default "";
}

package bluedot.spectrum.utils;

import org.apache.commons.lang3.StringUtils;

/**
 * ConvertUtils 字符串转换
 * @author zclong
 * 2018年1月20日
 */
public class ConvertUtils {

    public static Boolean toBoolean(String value) {
        return toBoolean(value, null);
    }

    public static Boolean toBoolean(String value, Boolean defaultValue) {
        if (StringUtils.isBlank(value)) {
            return defaultValue;
        }
        value = value.trim().toLowerCase();
        if ("1".equals(value) || "true".equals(value)) {
            return Boolean.TRUE;
        } else if ("0".equals(value) || "false".equals(value)) {
            return Boolean.FALSE;
        }
        throw new RuntimeException("Can not parse [" + value + "] to Boolean value.");
    }

    public static Integer toInt(String value) {
        return toInt(value, null);
    }

    public static Integer toInt(String value, Integer defaultValue) {
        if (StringUtils.isBlank(value)) {
            return defaultValue;
        }
        value = value.trim();
        if (value.startsWith("N") || value.startsWith("n")) {
            return -Integer.parseInt(value.substring(1));
        }
        return Integer.parseInt(value);
    }

    public static Long toLong(String value) {
        return toLong(value, null);
    }

    public static Long toLong(String value, Long defaultValue) {
        if (StringUtils.isBlank(value)) {
            return defaultValue;
        }
        value = value.trim();
        if (value.startsWith("N") || value.startsWith("n")) {
            return -Long.parseLong(value.substring(1));
        }
        return Long.parseLong(value);
    }

}

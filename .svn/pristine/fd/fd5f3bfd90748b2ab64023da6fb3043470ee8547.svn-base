package bluedot.spectrum.web.core.config;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.Serializable;
import java.util.Properties;

import bluedot.spectrum.utils.ConvertUtils;




/**
 * 加载properties文件
 * @author zclong
 * 2018年1月20日
 */
public abstract class ActionConfig implements Serializable {
    private static final long serialVersionUID = 1L;
    protected static Properties prop;

    
    /**
     * Load property file.
     *
     * @see #loadPropertyFile(String, String)
     */
    public static Properties loadPropertyFile(String fileName) {
        return loadPropertyFile(fileName, "UTF-8");
    }
    /**
     * Load property file.
     * Example:<br>
     * loadPropertyFile("db_username_pass.txt", "UTF-8");
     *
     * @param fileName the file in CLASSPATH or the sub directory of the CLASSPATH
     * @param encoding the encoding
     */
    public static Properties loadPropertyFile(String fileName, String encoding) {
        Properties properties;
        try (
                InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName);
                Reader reader = new InputStreamReader(inputStream, encoding)
        ) {
            properties = new Properties();
            properties.load(reader);
        } catch (IOException e) {
            throw new RuntimeException("Error loading properties file.", e);
        }
        return properties;
    }

    protected void unloadPropertyFile() {
        prop = null;
    }

    private Properties getProp() {
        if (prop == null) {
            throw new IllegalStateException("Load propties file by invoking loadPropertyFile(String fileName) method first.");
        }
        return prop;
    }

    public String getProp(String key) {
        return getProp().getProperty(key);
    }

    public String getProp(String key, String defaultValue) {
        return getProp().getProperty(key, defaultValue);
    }

    public Integer getPropToInt(String key) {
        return getPropToInt(key, null);
    }

    public Integer getPropToInt(String key, Integer defaultValue) {
        String value = getProp().getProperty(key);
        return ConvertUtils.toInt(value, defaultValue);
    }

    public Boolean getPropToBoolean(String key) {
        return getPropToBoolean(key, null);
    }

    public Boolean getPropToBoolean(String key, Boolean defaultValue) {
        String value = getProp().getProperty(key);
        return ConvertUtils.toBoolean(value, defaultValue);
    }

}

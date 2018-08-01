package bluedot.spectrum.freemarker.config;

import freemarker.template.Configuration;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.net.URL;
import java.util.Properties;

/**
 * @Author: 【WFP】
 * @Time: 2018/1/15
 * @decription:
 */
public enum FreeMarkerConfig implements Serializable{
    INSTANCE;

    private Configuration configuration = new Configuration(Configuration.VERSION_2_3_23);

    private FreeMarkerConfig(){
    	configuration.setDefaultEncoding("UTF-8");
    	
    	Properties props = new Properties();
    	props.setProperty("template_update_delay", "10");
    	props.setProperty("locale", "zh_CN");
    	props.setProperty("datetime_format", "yyyy-MM-dd");
    	props.setProperty("date_format", "yyyy-MM-dd");
    	props.setProperty("number_format", "#.##");
    	try {
			configuration.setSettings(props);
		} catch (TemplateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    public Configuration getConfiguration() {
        return configuration;
    }
}

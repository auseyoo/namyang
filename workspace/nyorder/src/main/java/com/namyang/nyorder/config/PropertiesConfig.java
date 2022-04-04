package com.namyang.nyorder.config;

import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

//@Configuration
public class PropertiesConfig {
	
	//@Bean 
	public PropertiesFactoryBean messageProperties() { 
		
		PropertiesFactoryBean bean = new PropertiesFactoryBean();
		bean.setFileEncoding("UTF-8");
		bean.setLocation(new ClassPathResource("message/messages.properties")); 
		return bean; 
	}

	

}

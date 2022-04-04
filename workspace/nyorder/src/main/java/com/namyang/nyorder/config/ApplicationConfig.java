package com.namyang.nyorder.config;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.annotation.SessionScope;

import com.namyang.nyorder.comm.vo.UserInfo;



//ApplicationConfig.java는 스프링 설정파일이다.
/* 레이어드 아키텍처에서 Controller가 사용하는 Bean들에 대해 설정을 한다.
* dao, service를 컴포넌트 스캔하여 찾도록 한다.
* 해당 패키지에 @Repository나 @Service가 붙어 있는 클래스가 있다면
* 자동으로 빈(Bean)으로 생성하게 된다.
* 어노테이션으로 트랜잭션을 관리하기 위해 @EnableTransactionManagement를 설정하였다.
*/
@Configuration
@EnableAspectJAutoProxy
@ComponentScan(
        basePackages = "com.namyang.nyorder",
        useDefaultFilters = false,
//        excludeFilters = {
//                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Controller.class),
//                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = RestController.class)
//        },
        includeFilters = {
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Configuration.class),
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Service.class),
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Repository.class),
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Mapper.class),
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Component.class),
                @ComponentScan.Filter(type=FilterType.ANNOTATION, classes = Bean.class)
                
        }
)

public class ApplicationConfig{

}

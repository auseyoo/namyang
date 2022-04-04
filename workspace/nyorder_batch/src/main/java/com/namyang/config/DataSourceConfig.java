package com.namyang.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
@MapperScan(value = {"com.namyang.common.mapper", "com.namyang.common.dao"})
public class DataSourceConfig {
	
//    @Bean(name = "dataSource")
//    @ConfigurationProperties(prefix = "spring.datasource")
//    public DataSource dataSource() {
//        return DataSourceBuilder.create().build();
//    }
	
	@Value("${spring.datasource.username}")
	private String username;
	
	@Value("${spring.datasource.password}")
	private String password;
	
	@Value("${spring.datasource.jdbcUrl}")
	private String url;
	
	
	@Value("${spring.datasource2.driverClassName}")
	private String driverClassName2;
	
	@Value("${spring.datasource2.username}")
	private String username2;
	
	@Value("${spring.datasource2.password}")
	private String password2;
	
	@Value("${spring.datasource2.jdbcUrl}")
	private String url2;
	
	
	@Value("${spring.datasource3.driverClassName}")
	private String driverClassName3;
	
	@Value("${spring.datasource3.username}")
	private String username3;
	
	@Value("${spring.datasource3.password}")
	private String password3;
	
	@Value("${spring.datasource3.jdbcUrl}")
	private String url3;
	
	@Bean
	@Qualifier("dataSource")
	@Primary
	public DataSource oingDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
				
		hikariConfig.setDriverClassName(driverClassName2);
		hikariConfig.setUsername(username);
		hikariConfig.setPassword(password);
		hikariConfig.setJdbcUrl(url);
		hikariConfig.setMaximumPoolSize(10);		
		//hikariConfig.setIdleTimeout(6000000);		
		
		return new HikariDataSource(hikariConfig);
	}
	
	public DataSource pamsDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		
		hikariConfig.setDriverClassName(driverClassName2);
		hikariConfig.setUsername(username2);
		hikariConfig.setPassword(password2);
		hikariConfig.setJdbcUrl(url2);
		//hikariConfig.setMaximumPoolSize(10);		
		//hikariConfig.setIdleTimeout(6000000);		
		
		return new HikariDataSource(hikariConfig);
	}
	
	public DataSource oracleDataSource() {
		HikariConfig hikariConfig = new HikariConfig();
		
		hikariConfig.setDriverClassName(driverClassName3);		
		hikariConfig.setUsername(username3);
		hikariConfig.setPassword(password3);
		hikariConfig.setJdbcUrl(url3);
		//hikariConfig.setMaximumPoolSize(10);		
		//hikariConfig.setIdleTimeout(6000000);		
		
		return new HikariDataSource(hikariConfig);
	}


    @Bean(name = "sqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource);
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mappers/*.xml"));
        
        return sessionFactoryBean.getObject();
    }
    
    @Bean(name = "pamsSqlSessionFactory")
    public SqlSessionFactory pamsSqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(pamsDataSource());
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mappers/pams/*.xml"));
        
        return sessionFactoryBean.getObject();
    }
    
    @Bean(name = "oracleSqlSessionFactory")
    public SqlSessionFactory oracleSqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sessionFactoryBean = new SqlSessionFactoryBean();
        sessionFactoryBean.setDataSource(oracleDataSource());
        sessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mappers/oracle/*.xml"));
        
        return sessionFactoryBean.getObject();
    }

    @Bean(name = "sqlSessionTemplate")
    public SqlSessionTemplate sqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
        //return new SqlSessionTemplate(sqlSessionFactory);
        return new SqlSessionTemplate(sqlSessionFactory, ExecutorType.BATCH);
    }
    
    @Bean(name = "pamsSqlSessionTemplate")
    public SqlSessionTemplate pamsSqlSessionTemplate() throws Exception {
        //return new SqlSessionTemplate(sqlSessionFactory);
        return new SqlSessionTemplate(pamsSqlSessionFactory(), ExecutorType.BATCH);
    }
    
    @Bean(name = "oracleSqlSessionTemplate")
    public SqlSessionTemplate oracleSqlSessionTemplate(SqlSessionFactory sqlSessionFactory) throws Exception {
        //return new SqlSessionTemplate(sqlSessionFactory);
        return new SqlSessionTemplate(oracleSqlSessionFactory(), ExecutorType.BATCH);
    }

}

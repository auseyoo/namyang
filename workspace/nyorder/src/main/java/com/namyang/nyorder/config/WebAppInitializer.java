package com.namyang.nyorder.config;

import javax.servlet.Filter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.ShallowEtagHeaderFilter;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import com.namyang.nyorder.config.db.DatabaseConfig;
import com.namyang.nyorder.config.security.SecurityConfig;


/* web.xml파일을 대신하는 자바 Config 설정파일이다. Spring MVC를 사용하는 경우에
 * AbstractAnnotationConfigDispatcherServletInitializer를 상속받아서 구현하면 편리
 */
public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
	
    //WebApplicationInitializer를 직접구현하는 샘플. 대신에 AbstractAnnotationConfigDispatcherServletInitializer를 사용하기로 함

	/**
    @Override 
    public void onStartup(ServletContext servletContext) throws ServletException {

        // Create the 'root' Spring application context
        AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
        rootContext.register(getRootConfigClasses());

        // Manage the lifecycle of the root application context
        servletContext.addListener(new ContextLoaderListener(rootContext));

        // Create the dispatcher servlet's Spring application context
        AnnotationConfigWebApplicationContext appContext = new AnnotationConfigWebApplicationContext();
        appContext.register(getServletConfigClasses());
        
        // Register and map the dispatcher servlet
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("appServlet", new DispatcherServlet(appContext));
        dispatcher.setLoadOnStartup(1); 
        dispatcher.addMapping("/");
        dispatcher.setInitParameter("throwExceptionIfNoHandlerFound", "true");

    }
	*/
	
	// Spring Config 파일을 설정한다
    //@Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[]{
        	ApplicationConfig.class 
        	,SecurityConfig.class
        	,DatabaseConfig.class
        	//,JpaConfig.class
        };
    }

    // Spring WEB Config 파일을 설정한다.
    // WebConfig는 Bean을 RootConfig에서 설정한 곳에서부터 찾는다.
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[]{WebMvcConfiguration.class};
    }

    /* getServletMapping()은 DispatcherServlet이 매핑되기 위한 하나 혹은 여러 개의 패스를 지정한다.
     * 위의 코드에서는 애플리케이션 기본 서블릿인 /에만 매핑이 되어 있다. 
     * 그리고 이것은 애플리케이션으로 들어오는 모든 요청을 처리한다. 
     * 원래 서블릿에서는 / 을 처리하는 DefaultServlet이 설정되어 있다. 
     */
    @Override
    protected String[] getServletMappings() {
        return new String[]{"*.do", "*.pop"};
    }

    //DispatcherServlet 앞에 동작하는 필터를 설정
    @Override
    protected Filter[] getServletFilters() {
        CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
        encodingFilter.setEncoding("UTF-8");
        encodingFilter.setForceEncoding(true);

        return new Filter[]{new ShallowEtagHeaderFilter(), encodingFilter};
    }
    
    @Override
    protected DispatcherServlet createDispatcherServlet(WebApplicationContext servletAppContext) 
    {
        final DispatcherServlet servlet = (DispatcherServlet) super.createDispatcherServlet(servletAppContext);
        servlet.setThrowExceptionIfNoHandlerFound(true);
        return servlet;
    }
    
    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        boolean done = registration.setInitParameter("throwExceptionIfNoHandlerFound", "true"); // -> true
        
        System.out.println("customizeRegistration  : " + done);
        
        if(!done) throw new RuntimeException();
    }
    
//	@Override
//	public void customizeRegistration(ServletRegistration.Dynamic registration) {
//		// throw an exception on NoHandlerFound (404 error, page not found exception)
//        registration.setInitParameter("throwExceptionIfNoHandlerFound", "true");
//                
//    }
    
}

package com.namyang.nyorder.comm.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.apache.lucene.search.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.search.jpa.FullTextEntityManager;
import org.hibernate.search.jpa.FullTextQuery;
import org.hibernate.search.jpa.Search;
import org.hibernate.search.query.dsl.QueryBuilder;
import org.hibernate.service.ServiceRegistry;

import com.namyang.nyorder.comm.vo.TComm;

//@Service
public class TCommServiceImpl implements TCommService {

	//@Autowired
	//private TCommDao tCommDao;
	
	@PersistenceContext(type = PersistenceContextType.EXTENDED)
    private EntityManager em;
		 
	@Transactional
	@Override
	public void add(TComm tcomm) {
		//tCommDao.add(tcomm);
	}
 
//	@Transactional(readOnly = true)
//	@Override
//	public List<TComm> listTComm() {
//		return tCommDao.listTComm();
//	}
	
	
	@Transactional(readOnly = true)
	@Override
	public List<TComm> listTComm(TComm tcomm) {
		
		// CriteriaBuilder 인스턴스를 작성한다.
		CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
		
		// CriteriaQuery 인스턴스를 생성한다. Board 제네릭 형식으로...
		CriteriaQuery<TComm> criteriaQuery = criteriaBuilder.createQuery(TComm.class);
		
		// Root는 영속적 엔티티를 표시하는 쿼리 표현식이다. SQL의 FROM 과 유사함
		Root<TComm> root = criteriaQuery.from(TComm.class);
		
		// SQL의 WHERE절이다. 조건부는 CriteriaBuilder에 의해 생성
		Predicate restrictions = criteriaBuilder.equal(root.get("commGrpCd"), tcomm.getCommGrpCd());
		criteriaQuery.where(restrictions);

		// ORDER BY절. CriteriaQuery로 생성
		criteriaQuery.orderBy(criteriaBuilder.desc(root.get("ordr")));

		// 뭔가 복잡해 보여도 별거 없다. TypedQuery는 실행 결과를 리턴하는 타입이다.
		TypedQuery<TComm> boardListQuery = em.createQuery(criteriaQuery).setFirstResult(1).setMaxResults(1000);

		List<TComm> boardList = boardListQuery.getResultList();

		return boardList;
	}
	
    
	/**		
    public List<TComm> searchNewsroom(String keyword) {
        FullTextEntityManager fullTextEntityManager = Search.getFullTextEntityManager(em);
        
        QueryBuilder queryBuilder = fullTextEntityManager.getSearchFactory().buildQueryBuilder()
                .forEntity(TComm.class)
                .get();
        Query query = queryBuilder.keyword()
                .onFields("commGrpCd")
                .matching(keyword)
                .createQuery();
        FullTextQuery fullTextQuery = fullTextEntityManager.createFullTextQuery(query, TComm.class);
        List<TComm> newsrooms = (List<TComm>) fullTextQuery.getResultList();
        return newsrooms;
    }
    
    public static Session getCurrentSessionFromConfig() {
    	//SessionFactory in Hibernate 5 example
    	Configuration config = new Configuration();
    	config.configure();
    	// local SessionFactory bean created
    	SessionFactory sessionFactory = config.buildSessionFactory();
    	Session session = sessionFactory.getCurrentSession();
    	return session;
    }
    
    public static Session getCurrentSession() {
    	// Hibernate 5.4 SessionFactory example without XML
    	Map<String, String> settings = new HashMap<>();
    	
    	settings.put("connection.driver_class", "com.mysql.jdbc.Driver");
    	settings.put("dialect", "org.hibernate.dialect.MySQL8Dialect");
    	settings.put("hibernate.connection.url", "jdbc:mysql://localhost/hibernate_examples");
    	settings.put("hibernate.connection.username", "root");
    	settings.put("hibernate.connection.password", "password");
    	settings.put("hibernate.current_session_context_class", "thread");
    	settings.put("hibernate.show_sql", "true");
    	settings.put("hibernate.format_sql", "true");

    	ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
	                                    .applySettings(settings).build();

    	MetadataSources metadataSources = new MetadataSources(serviceRegistry);
    	// metadataSources.addAnnotatedClass(Player.class);
    	Metadata metadata = metadataSources.buildMetadata();

    	// here we build the SessionFactory (Hibernate 5.4)
    	SessionFactory sessionFactory = metadata.getSessionFactoryBuilder().build();
    	Session session = sessionFactory.getCurrentSession();
    	return session;
    }
	 */
	@Override
	public List<TComm> listTComm() {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}

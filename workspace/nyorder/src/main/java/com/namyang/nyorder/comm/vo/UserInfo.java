package com.namyang.nyorder.comm.vo;

import java.io.Serializable;
import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.annotation.SessionScope;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Component
@SessionScope
public class UserInfo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String bizNo;
	private String emplCd;
	private String password;
	private String name;
	private String auth;
	private int enabled;
	
	private String agenSeq;
	private String agenCd;
	private String agenNm;
	private String emplSeq;
	private String saleCd;
	
	private String hexPassword;
	private String tmpPwdYn;
	
	private List<MenuVO> menuVOList;
	private List<MenuVO> bkmkMenuList;

}

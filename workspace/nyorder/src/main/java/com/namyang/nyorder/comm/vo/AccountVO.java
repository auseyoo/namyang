package com.namyang.nyorder.comm.vo;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class AccountVO implements UserDetails{

	private String id;
	private String bizNo;
	private String emplCd;
	private String password;
	private String rolecode;
	private int failCnt;
	private boolean isAccountNonExpired;
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired;
	private boolean enabled;
	
	private String agenSeq;
	private String agenCd;
	private String agenNm;
	private String emplSeq;	
	private String saleCd;
	private String emplNm;

	private String hexPassword;
	private String tmpPwdYn;
	
	private String emplIp; 
	private String emplMch;
	
	private List<MenuVO> menuVOList;
	
	private List<MenuVO> bkmkMenuList;
	
	private Collection <? extends GrantedAuthority> authorities;
	
	public List<MenuVO> getBkmkMenuList() {
		return bkmkMenuList;
	}

	public void setBkmkMenuList(List<MenuVO> bkmkMenuList) {
		this.bkmkMenuList = bkmkMenuList;
	}	
	
	public List<MenuVO> getMenuVOList() {
		return menuVOList;
	}

	public void setMenuVOList(List<MenuVO> menuVOList) {
		this.menuVOList = menuVOList;
	}

	public String getSaleCd() {
		return saleCd;
	}

	public void setSaleCd(String saleCd) {
		this.saleCd = saleCd;
	}
	public String getRolecode() {
		return rolecode;
	}

	public void setRolecode(String rolecode) {
		this.rolecode = rolecode;
	}
	
	public String getAgenSeq() {
		return agenSeq;
	}

	public void setAgenSeq(String agenSeq) {
		this.agenSeq = agenSeq;
	}

	public String getAgenCd() {
		return agenCd;
	}

	public void setAgenCd(String agenCd) {
		this.agenCd = agenCd;
	}

	public String getAgenNm() {
		return agenNm;
	}

	public void setAgenNm(String agenNm) {
		this.agenNm = agenNm;
	}

	public String getEmplSeq() {
		return emplSeq;
	}

	public void setEmplSeq(String emplSeq) {
		this.emplSeq = emplSeq;
	}

	public String getHexPassword() {
		return hexPassword;
	}

	public void setHexPassword(String hexPassword) {
		this.hexPassword = hexPassword;
	}

	public String getTmpPwdYn() {
		return tmpPwdYn;
	}

	public void setTmpPwdYn(String tmpPwdYn) {
		this.tmpPwdYn = tmpPwdYn;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public String getBizNo() {
		return bizNo;
	}

	public void setBizNo(String bizNo) {
		this.bizNo = bizNo;
	}
	
	public String getEmplCd() {
		return emplCd;
	}

	public void setEmplCd(String emplCd) {
		this.emplCd = emplCd;
	}

	public String getEmplNm() {
		return emplNm;
	}

	public void setEmplNm(String emplNm) {
		this.emplNm = emplNm;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setAccountNonExpired(boolean isAccountNonExpired) {
		this.isAccountNonExpired = isAccountNonExpired;
	}

	public void setAccountNonLocked(boolean isAccountNonLocked) {
		this.isAccountNonLocked = isAccountNonLocked;
	}

	public void setCredentialsNonExpired(boolean isCredentialsNonExpired) {
		this.isCredentialsNonExpired = isCredentialsNonExpired;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

	public int getFailCnt() {
		return failCnt;
	}

	public void setFailCnt(int failCnt) {
		this.failCnt = failCnt;
	}

	// UserDetails�� �ʼ� �޼����
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.password;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.id;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return this.isAccountNonExpired;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return this.isAccountNonLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return this.isCredentialsNonExpired;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return this.enabled;
	}

	public String getEmplIp() {
		return emplIp;
	}

	public void setEmplIp(String emplIp) {
		this.emplIp = emplIp;
	}

	public String getEmplMch() {
		return emplMch;
	}

	public void setEmplMch(String emplMch) {
		this.emplMch = emplMch;
	}

}

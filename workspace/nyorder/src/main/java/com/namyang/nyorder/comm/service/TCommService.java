package com.namyang.nyorder.comm.service;

import java.util.List;

import com.namyang.nyorder.comm.vo.TComm;

public interface TCommService {
	
	void add(TComm tcomm);
	
	List<TComm> listTComm();
	
	//List<TComm> searchNewsroom(String keyword);
	
	List<TComm> listTComm(TComm tcomm);
}

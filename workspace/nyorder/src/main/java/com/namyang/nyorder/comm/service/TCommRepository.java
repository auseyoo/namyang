package com.namyang.nyorder.comm.service;


import org.springframework.data.jpa.repository.JpaRepository;
import com.namyang.nyorder.comm.vo.TComm;

public interface TCommRepository extends JpaRepository<TComm, Integer> {

}

package com.namyang.nyorder.comm.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.namyang.nyorder.comm.dao.MenuMapper;
import com.namyang.nyorder.comm.vo.MenuRoleVO;
import com.namyang.nyorder.comm.vo.MenuVO;
import com.namyang.nyorder.comm.vo.UserInfo;
import com.namyang.nyorder.util.StringUtil;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 메뉴 관리 Service Implement
 * 파일명  : MenuServiceImpl.java
 * 작성자  : YESOL
 * 작성일  : 2021. 12. 31.
 *
 * 설 명  :
 * --------------------------------------------------
 *   변경일             변경자           변경내역
 * --------------------------------------------------
 * 2021. 12. 31.    YESOL     최조 프로그램 작성
 *
 ****************************************************/
@Service
public class MenuServiceImpl implements MenuService{

	@Autowired
	private MenuMapper menuMapper;
	
	@Resource(name="userInfo")
	UserInfo userInfo;
	
	/**
	 *	메뉴 리스트 조회  ( 개인 권한 )
	 */
	public List<MenuVO> selectLeftMenuList(MenuVO menuParam) {
		return menuMapper.selectLeftMenuList(menuParam);
	}

	/**
	 *  메뉴 전체 리스트 조회
	 */
	public List<MenuRoleVO> selectMenuAllList(MenuVO menuParam) {
		return menuMapper.selectMenuAllList(menuParam);
	}

	/**
	 * 요청 페이지 메뉴 위치 조회  ( Location )
	 */
	public List<MenuVO> selectBreadcrumb(MenuVO menuParam) {
		return menuMapper.selectBreadcrumb(menuParam);
	}

	/**
	 * 메뉴 리스트 저장
 	 */
	@Transactional
	public String saveMenueList(List<MenuRoleVO> vo) throws Exception {
		
		for(MenuRoleVO one : vo) {
			one.setAgenSeq(userInfo.getAgenSeq());
			one.setEmplSeq(userInfo.getEmplSeq());
			if( StringUtil.isEmpty(one.getMenuSeq())) {
				menuMapper.addMenu(one);
			}else {
				menuMapper.updateMenuList(one);
			}
		}
		return "저장되었습니다.";
	}

	/**
	 * 즐겨찾기 등록 / 수정
	 */
	@Transactional
	public int updateBkmk(MenuRoleVO menu) throws Exception {
		return menuMapper.updateBkmk(menu);
	}

	/**
	 * 즐겨찾기 목록 조회
	 */
	public List<MenuVO> selectLeftBkmkMenuList(MenuVO menuParam) {
		return menuMapper.selectLeftBkmkMenuList(menuParam);
	}


}

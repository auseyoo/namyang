package com.namyang.nyorder.comm.dao;

import java.util.List;

import com.namyang.nyorder.comm.vo.MenuRoleVO;
import com.namyang.nyorder.comm.vo.MenuVO;

/**
 * 시스템명 : 남양유업 대리점주문 시스템
 * 업무명  : 메뉴 관리 Mapper
 * 파일명  : MenuMapper.java
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
public interface MenuMapper {

	/**
	 * @Method Name : selectMainMenuList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 리스트 조회  ( 개인 권한 )
	 * @param menuParam
	 * @return List<MenuVO>
	 */
	public List<MenuVO> selectLeftMenuList(MenuVO menuParam);

	/**
	 * @Method Name : selectMenuAllList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 전체 리스트 조회
	 * @param menuParam
	 * @return List<MenuRoleVO>
	 */
	public List<MenuRoleVO> selectMenuAllList(MenuVO menuParam);

	/**
	 * @Method Name : selectBreadcrumb
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 요청 페이지 메뉴 위치 조회  ( Location )
	 * @param menuParam
	 * @return List<MenuVO>
	 */
	public List<MenuVO> selectBreadcrumb(MenuVO menuParam);

	/**
	 * @Method Name : updateMenuList
	 * @작성일 : 2021. 12. 31.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 정보 저장
	 * @param vo
	 * @return int
	 */
	public int updateMenuList(MenuRoleVO vo) throws Exception;

	/**
	 * @Method Name : updateBkmk
	 * @작성일 : 2022. 1. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 즐겨찾기 등록/수정
	 * @param menu
	 * @return String
	 */
	public int updateBkmk(MenuRoleVO menu) throws Exception;

	/**
	 * @Method Name : getLeftBkmkMenuList
	 * @작성일 : 2022. 1. 10.
	 * @작성자 : YESOL
	 * @Method 설명 : 즐겨찾기 목록 조회
	 * @param menuParam
	 * @return List<MenuVO>
	 */
	public List<MenuVO> selectLeftBkmkMenuList(MenuVO menuParam);

	/**
	 * @Method Name : addMenu
	 * @작성일 : 2022. 2. 3.
	 * @작성자 : YESOL
	 * @Method 설명 : 메뉴 등록
	 * @param one
	 * @return int
	 */
	public int addMenu(MenuRoleVO one);


}

DELETE FROM T_AGEN_ACCT_INFO;
DELETE FROM T_AGEN_AREA;
DELETE FROM T_AGEN_COMM;
DELETE FROM T_AGEN_EMPL WHERE EMPL_SEQ <> 0;
DELETE FROM T_AGEN_MENU_ROLE;
DELETE FROM T_CST_BILCT;
DELETE FROM T_CST_DLY_ORDR;
DELETE FROM T_CST_MST;
DELETE FROM T_CST_PRD;
DELETE FROM T_CST_PRD_STPG;
DELETE FROM T_CST_PRD_UNTPC;
DELETE FROM T_CST_PTTN;
DELETE FROM T_CST_SALE;
DELETE FROM T_ORD_DLV;
DELETE FROM T_ORD_DLY_DTL;
DELETE FROM T_ORD_MST;
DELETE FROM T_ORD_PRD;
DELETE FROM T_ORD_RTGD;
DELETE FROM T_ORD_STUS_MST;
DELETE FROM T_ORD_STUS_PRD;
DELETE FROM T_PRD_AGEN_GRP;
DELETE FROM T_PRD_DTL;
DELETE FROM T_PRD_HOP;

/*
T_AGEN_EMPL_PWD
T_AGEN_EMPL_ROLE
T_COMM
T_COMM_MENU
T_COMM_MENU_ROLE
*/
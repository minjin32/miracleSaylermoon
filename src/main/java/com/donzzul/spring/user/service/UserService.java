package com.donzzul.spring.user.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.donzzul.spring.common.PageInfo;
import com.donzzul.spring.user.domain.CustomUserDetails;
import com.donzzul.spring.user.domain.User;

public interface UserService {
 
	public User loginUser(User user);
	public int checkLoginDup(HashMap<String, String> map);
	public int checkIdDup(String userId);
	public int checkPhoneDup(String userPhone);
	public int checkCardAvail(HashMap<String, String> map);
	public int checkCardDup(HashMap<String, String> map);
	public int checkNickDup(String userNick);
	public int checkPVerifyDup(String partnerVerify);
	public int checkEmailDup(String userEmail);
	public int insertDreamUser(User user);
	public int insertMzUser(User user);
	public int insertPartnerUser(User user);
	public User selectOneUserByNo(int userNo);
	public int updateToNull(int userNo);
	public int updateMzUser(User user);
	public int updatePartnerUser(User user);
	public int deleteUser(int userNo);
	public int deleteRequestUser(int userNo);
	public int checkPwDup(HashMap<String, String> map);
	public int resetPw(HashMap<String, String> map);
	public int checkFindIdDup(HashMap<String, String> map);
	public int checkFindPwDup(HashMap<String, String> map);
	public String findId(HashMap<String, String> map);
	public int checkEmailDupNotMe(User user);
	public int checkPhoneDupNotMe(User user);
	public ArrayList<User> selectUserListThree();
	public int getListCount(HashMap<String, String> pageType);
	public ArrayList<User> selectAllUserList(PageInfo pi, HashMap<String, String> userType);
	public User getUsersByID(String userId);
	public User getUsersByNo(String userNo);
	public int countSocialUser(String socialId);
	public int insertSocialUser(HashMap<String, String> map);
}

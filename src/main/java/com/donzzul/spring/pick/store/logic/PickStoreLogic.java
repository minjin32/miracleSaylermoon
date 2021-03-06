package com.donzzul.spring.pick.store.logic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.donzzul.spring.common.PageInfo;
import com.donzzul.spring.pick.domain.Pick;
import com.donzzul.spring.pick.store.PickStore;
import com.donzzul.spring.user.domain.User;

@Repository
public class PickStoreLogic implements PickStore{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertPick(HashMap<String, Integer> hash) {
		return sqlSession.insert("pickMapper.insertPick", hash);
	}

	@Override
	public int deletePick(int pickNo) {
		return sqlSession.delete("pickMapper.deletePick", pickNo);
	}

	@Override
	public Pick checkPick(HashMap<String, Integer> pickParam) {
		return sqlSession.selectOne("pickMapper.checkPick", pickParam);
	}
	
	@Override
	public List<Pick> selectAllPick(int userNo, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		System.out.println("store" + pi.getCurrentPage());
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("pickMapper.selectAllList",userNo, rowBounds);
	}
	
	
	// 드림 마이페이지
	@Override
	public ArrayList<Pick> dreamPickUpToThree(int userNo) {
		return (ArrayList)sqlSession.selectList("pickMapper.dreamPickUpToThree",userNo);
	}

	@Override
	public ArrayList<Pick> pickListByDream(int userNo, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("pickMapper.pickListByDream",userNo,rowBounds);
	}

	@Override
	public int pickListCount(int userNo) {
		return sqlSession.selectOne("pickMapper.pickListCount",userNo);
	}


}

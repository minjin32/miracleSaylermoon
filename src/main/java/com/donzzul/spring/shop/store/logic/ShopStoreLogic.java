package com.donzzul.spring.shop.store.logic;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.donzzul.spring.common.PageInfo;
import com.donzzul.spring.shop.domain.MainMenu;
import com.donzzul.spring.shop.domain.MenuPhoto;
import com.donzzul.spring.shop.domain.Shop;
import com.donzzul.spring.shop.store.ShopStore;

@Repository
public class ShopStoreLogic implements ShopStore {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<Shop> selectShopMap(PageInfo pi, HashMap<String, String> selectedLocation) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("shopMapper.selectAllList", selectedLocation, rowBounds);
	}
	
	@Override
	public ArrayList<Shop> selectShopMap(HashMap<String, String> selectedLocation) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectAllList", selectedLocation);
	}

	@Override
	public ArrayList<Shop> searchMapKeyword(PageInfo pi, String searchKeyword) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("shopMapper.selectMapKeyword", searchKeyword, rowBounds);
	}
	
	@Override
	public ArrayList<Shop> searchMapKeyword(String searchKeyword) {
		return (ArrayList)sqlSession.selectList("shopMapper.selectMapKeyword", searchKeyword);
	}
	
	@Override
	public ArrayList<Shop> selectShopTheme(PageInfo pi, String themeWord) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("shopMapper.selectShopTheme", themeWord, rowBounds);
	}

	@Override
	public ArrayList<Shop> searchShop(String searchKeyWord) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Shop selectShopOne(int shopNo) {
		return sqlSession.selectOne("shopMapper.selectOne", shopNo);
	}

	@Override
	public ArrayList<MainMenu> selectMainMenu(int shopNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<MenuPhoto> selectMenuPhoto(int shopNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectListCount(HashMap<String, String> selectedLocation) {
		return sqlSession.selectOne("shopMapper.selectListCount", selectedLocation);
	}
	
	@Override
	public int selectKeyListCount(String searchKeyword) {
		return sqlSession.selectOne("shopMapper.selectListCountKey", searchKeyword);
	}
	
	@Override
	public int selectShopThemeCount(String themeWord) {
		return sqlSession.selectOne("shopMapper.selectThemeCount", themeWord);
	}
	
    @Override
    public ArrayList<Shop> selectAllShopListDESC() {
       return (ArrayList)sqlSession.selectList("shopMapper.selectAllShopDESC");
    }

    @Override
    public ArrayList<Shop> selectAllShopListASC() {
       return (ArrayList)sqlSession.selectList("shopMapper.selectAllShopASC");
    }

}
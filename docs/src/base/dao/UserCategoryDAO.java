package base.dao;

import java.util.ArrayList;
import java.util.List;

import base.api.Category;
import base.api.User;
import base.api.UserCategory;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class UserCategoryDAO extends BaseDAO<Category> {

	private static UserCategoryDAO dao;

	private UserCategoryDAO() {
		super("t_user_category");
	}

	public static UserCategoryDAO getInstance() {
		if (dao == null) {
			dao = new UserCategoryDAO();
		}
		return dao;
	}
	
	public List<Category> listByUser(User user) {
		if(user == null){
			return new ArrayList<Category>();
		}
		String sql;
		List<Category> objs;
		if(user.getAdmin() == 1){//如果是管理员就加载所有类别
			sql = "select * from t_category where parentId=0 order by id";
			objs = JDBCUtil.queryObjectList(sql, Category.class);
		}else{//如果不是管理员就加载有权限的类别
			sql = "select c.* from t_user_category uc,t_category c where uc.categoryId=c.id and userId=? order by id";
			objs = JDBCUtil.queryObjectList(sql, Category.class, user.getId());
		}
		looperChildren(objs);//把所有子都塞好
		List<Category> tempList = new ArrayList<Category>();
		tempList.addAll(objs);
		for(int i = 0; i < objs.size(); i++){
			Category child = objs.get(i);
			if(child.getParentId() != 0){
				child = tempList.remove(i);
				Category parent = looperParent(child);
				if(!tempList.contains(parent)){
					tempList.add(parent);//把所有父，都虚拟好
				}
				tempList.remove(child);//删除
			}
		}
		return tempList;
	}

	public List<Category> listByUser(int userId) {
		User user = UserDAO.getInstance().load(userId);
		return listByUser(user);
	}
	
	public List<Category> listBySimpleUser(int userId) {
		User user = UserDAO.getInstance().load(userId);
		if(user == null){
			return new ArrayList<Category>();
		}
		String sql = "select c.* from t_user_category uc,t_category c where uc.categoryId=c.id and userId=? order by id";
		return JDBCUtil.queryObjectList(sql, Category.class, user.getId());
	}
	
	//补全所有的子分类
	private void looperChildren(List<Category> objs){
		for(Category category : objs){
			List<Category> children = listByParent(category.getId());
			if(children != null && children.size() > 0){
				category.setChildren(children);
				looperChildren(children);
			}
		}
	}
	
	//补全所有的父分类
	private Category looperParent(Category child){
		if(child.getParentId() != 0){
			Category parent = CategoryDAO.getInstance().load(child.getParentId());
			List<Category> children = new ArrayList<Category>();
			children.add(child);
			parent.setChildren(children);
			return looperParent(parent);
		}else{
			return child;
		}
	}
	
	private List<Category> listByParent(int parentId) {
		String sql = "select * from t_category where parentId=? order by id";
		return JDBCUtil.queryObjectList(sql, Category.class, parentId);
	}
	
	public List<User> listByCategory(int categoryId) {
		Category category = CategoryDAO.getInstance().load(categoryId);
		if(category == null){
			return new ArrayList<User>();
		}
		List<Integer> categorys = new ArrayList<Integer>();
		looperParent(category, categorys);
		String ids = "";
		for(Integer id : categorys){
			ids += id + ",";
		}
		ids = ids.substring(0, ids.length() - 1);
		String sql = "select u.* from t_user_category uc, t_user u where u.id=uc.userId and uc.categoryId in (" + ids + ")";
		return JDBCUtil.queryObjectList(sql, User.class);
	}
	
	//加载所有的父分类
	private void looperParent(Category child, List<Integer> categorys){
		categorys.add(child.getId());
		if(child.getParentId() != 0){
			Category parent = CategoryDAO.getInstance().load(child.getParentId());
			looperParent(parent, categorys);
		}
	}
	
	//补全所有的子分类,并设置选中状态
	public void looperChildren(List<Category> objs, List<Category> temp){
		for(Category category : objs){
			List<Category> children = listByParent(category.getId());
			if(children != null && children.size() > 0){
				category.setChildren(children);
				looperChildren(children);
			}
			if(temp.contains(category)){
				category.setChecked(true);
			}else{
				category.setChecked(false);
			}
		}
	}
	
	//检查这个人对这个类别是否有权限（即，对该类别和该类别的父类别）
	public boolean checkPermission(int categoryId, int userId){
		//根类别的父
		if(categoryId == 0){
			return false;
		}
		//全部
		if(categoryId == -1){
			return true;
		}
		//我的
		if(categoryId == -2){
			return true;
		}
		String sql = "select uc.* from t_user_category uc where uc.userId="+userId+" and uc.categoryId=" + categoryId;
		List<UserCategory> result = JDBCUtil.queryObjectList(sql, UserCategory.class);
		if(result != null && result.size() > 0){
			return true;
		}else{
			Category category = CategoryDAO.getInstance().load(categoryId);
			return checkPermission(category.getParentId(), userId);
		}
	}
	
	public List<User> listBySimpleCategory(int categoryId, int index, int pagesize) {
		String sql = "select u.* from t_user_category uc, t_user u where u.id=uc.userId and uc.categoryId=? order by u.id limit ?,?";
		return JDBCUtil.queryObjectList(sql, User.class, categoryId, index, pagesize);
	}
	
	public long listBySimpleCategoryCount(int categoryId) {
		String sql = "select count(u.id) from t_user_category uc, t_user u where u.id=uc.userId and uc.categoryId=? ";
		return JDBCUtil.queryCount(sql, categoryId);
	}
	
	public UserCategory query(int categoryId, int userId){
		String sql = "select uc.* from t_user_category uc where uc.userId="+userId+" and uc.categoryId=" + categoryId;
		return JDBCUtil.queryObject(sql, UserCategory.class);
	}
}

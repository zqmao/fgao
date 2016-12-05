package base.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import base.util.JDBCUtil;
import base.util.ReflectUtil;

public abstract class BaseDAO {
	private String tableName;

	public BaseDAO(String tableName) {
		this.tableName = tableName;
	}

	/**
	 * 保存或更新obj对象
	 * 返回值是新增或修改记录的id
	 * @param obj
	 */
	public int saveOrUpdate(Object obj) {
		try {
			Map<String, Object> valueMap = ReflectUtil.getValus(obj);
			int id = (Integer) valueMap.get("id");
			List<Object> values = new ArrayList<Object>();
			if (id == 0) {// save
				String sqlStr = buildSaveSql(valueMap, values);
				return JDBCUtil.updateOrSave(sqlStr, values);
			} else {// update
				String sqlStr = buildUpdateSql(valueMap, values);
				return JDBCUtil.updateOrSave(sqlStr, values);
			}
		} catch (Exception e) {
			System.out.println("保存或更新用户信息出错!");
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * 删除obj对象
	 * 
	 * @param obj
	 * @return
	 */
	public boolean delete(Object obj) {
		try {
			Map<String, Object> valueMap = ReflectUtil.getValus(obj);
			int id = (Integer) valueMap.get("id");
			return delete(id);
		} catch (Exception e) {
			System.out.println("删除信息出错!");
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * 删除obj对象
	 * 
	 * @param obj
	 * @return
	 */
	public boolean delete(int id) {
		try {
			String sqlStr = buildDeleteSql();
			return JDBCUtil.delete(sqlStr, id);
		} catch (Exception e) {
			System.out.println("删除信息出错!");
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 构保存Object对象的sql字符
	 * 
	 * @param valueMap
	 * @param values
	 * @return
	 */
	private String buildSaveSql(Map<String, Object> valueMap,
			List<Object> values) {
		StringBuffer sql = new StringBuffer();
		sql.append("insert into ").append(this.tableName).append("(");
		valueMap.remove("id");
		for (Map.Entry<String, Object> entry : valueMap.entrySet()) {
			sql.append(entry.getKey()).append(", ");
			values.add(entry.getValue());
		}
		sql.delete(sql.lastIndexOf(","), sql.length());//
		sql.append(") values (");
		for (int i = 0; i < valueMap.size(); i++) {
			sql.append("?, ");
		}
		sql.delete(sql.lastIndexOf(","), sql.length());// 
		sql.append(")");
		return sql.toString();
	}

	/**
	 * 构�?更新对象的sql字符�?
	 * 
	 * @param valueMap
	 * @param values
	 * @return
	 */
	private String buildUpdateSql(Map<String, Object> valueMap,
			List<Object> values) {
		StringBuffer sql = new StringBuffer();
		sql.append("update ").append(this.tableName).append(" set");
		Integer id = (Integer) valueMap.remove("id");
		for (Map.Entry<String, Object> entry : valueMap.entrySet()) {
			sql.append(" ").append(entry.getKey()).append("=?,");
			values.add(entry.getValue());
		}
		sql.delete(sql.lastIndexOf(","), sql.length());// 
		sql.append(" where id=?");
		values.add(id);
		return sql.toString();
	}

	private String buildDeleteSql() {
		StringBuffer sql = new StringBuffer();
		sql.append("delete from ").append(this.tableName);
		sql.append(" where id=?");
		return sql.toString();
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

}

package base.dao.core;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import base.util.ReflectUtil;

public abstract class BaseDAO<T> implements IDao<T>{
	
	private Class<T> entityClass;
	private String tableName;

	@SuppressWarnings("unchecked")
	public BaseDAO(String tableName) {
		this.tableName = tableName;
		
		Type genType = getClass().getGenericSuperclass();  
        Type[] params = ((ParameterizedType) genType).getActualTypeArguments();  
        entityClass = (Class<T>) params[0];
	}
	
	/**
	 * 保存或更新obj对象
	 * 返回值是新增或修改记录的id
	 * @param obj
	 */
	public int saveOrUpdate(Object obj) {
		try {
			Map<String, Object> valueMap = ReflectUtil.getValues(obj);
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
			Map<String, Object> valueMap = ReflectUtil.getValues(obj);
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
	 * @param id
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
	 * load obj对象
	 * 
	 * @param id
	 * @return
	 */
	public T load(int id) {
		try {
			String sqlStr = buildLoadSql();
			return JDBCUtil.queryObject(sqlStr, entityClass, id);
		} catch (Exception e) {
			System.out.println("加载信息出错!");
			e.printStackTrace();
		}
		return null;
	}
	
	public T queryForEq(String key, String value) {
		try {
			String sqlStr = buildQuerySql(key);
			return JDBCUtil.queryObject(sqlStr, entityClass, value);
		} catch (Exception e) {
			System.out.println("根据key/value加载信息出错!");
			e.printStackTrace();
		}
		return null;
	}
	
	public List<T> queryForAll() {
		try {
			String sqlStr = buildQueryAllSql();
			return JDBCUtil.queryObjectList(sqlStr, entityClass);
		} catch (Exception e) {
			System.out.println("查询所有列表出错!");
			e.printStackTrace();
		}
		return null;
	}
	
	public List<T> queryForLimit(int index, int pageSize) {
		try {
			String sqlStr = buildQueryLimitSql();
			return JDBCUtil.queryObjectList(sqlStr, entityClass, index, pageSize);
		} catch (Exception e) {
			System.out.println("加载limit信息出错!");
			e.printStackTrace();
		}
		return null;
	}
	
	public long queryCount() {
		try {
			String sqlStr = buildQueryCountSql();
			return JDBCUtil.queryCount(sqlStr);
		} catch (Exception e) {
			System.out.println("加载数量出错!");
			e.printStackTrace();
		}
		return 0L;
	}
	
	public QueryBuilder creatBuilder() {
		return new QueryBuilder();
	}
	
	public class QueryBuilder{
		
		private Map<String, Object> mParams = new HashMap<String, Object>();
		private Map<String, Boolean> mOrders = new HashMap<String, Boolean>();
		private int mIndex = 0;
		private int mPageSize = 0;
		
		
		public QueryBuilder eq(String key, Object value) {
			if(mParams != null) {
				mParams.put(key, value);
			}
			return this;
		}
		
		public QueryBuilder orderBy(String key, boolean desc) {
			if(mOrders != null) {
				mOrders.put(key, desc);
			}
			return this;
		}
		
		public QueryBuilder limit(int index, int pageSize) {
			mIndex = index;
			mPageSize = pageSize;
			return this;
		}
		
		public List<T> queryList() {
			String sqlStr = buildQueryAllSql();
			StringBuffer buffer = new StringBuffer(sqlStr);
			Set<String> keySet = mParams.keySet();
			Object[] values = new Object[keySet.size() + 2];
			if(!mParams.isEmpty()) {
				buffer.append(" where ");
			}
			int index = 0;
			for(String key : mParams.keySet()) {
				buffer.append(" " + key + "=? and");
				values[index] = mParams.get(key);
				index ++;
			}
			if(buffer.toString().endsWith("and")) {
				sqlStr = buffer.substring(0, buffer.length() - 3);
			}
			
			String orders = "";
			StringBuffer ordersBuffer = new StringBuffer();
			if(!mOrders.isEmpty()) {
				ordersBuffer.append(" order by ");
			}
			for(String key : mOrders.keySet()) {
				ordersBuffer.append(" " + key + (mOrders.get(key) ? " desc" : " asc") + ",");
			}
			if(ordersBuffer.toString().endsWith(",")) {
				orders = ordersBuffer.substring(0, ordersBuffer.length() - 1);
			}
			sqlStr += orders;
			
			if(mPageSize != 0) {
				sqlStr += " limit ?,? ";
				values[keySet.size()] = mIndex;
				values[keySet.size() + 1] = mPageSize;
			}
			return JDBCUtil.queryObjectList(sqlStr, entityClass, values);
		}
		
		public long queryCount() {
			String sqlStr = buildQueryCountSql();
			StringBuffer buffer = new StringBuffer(sqlStr);
			Set<String> keySet = mParams.keySet();
			Object[] values = new Object[keySet.size() + 2];
			if(!mParams.isEmpty()) {
				buffer.append(" where ");
			}
			int index = 0;
			for(String key : mParams.keySet()) {
				buffer.append(" " + key + "=? and");
				values[index] = mParams.get(key);
				index ++;
			}
			if(buffer.toString().endsWith("and")) {
				sqlStr = buffer.substring(0, buffer.length() - 3);
			}
			
			return JDBCUtil.queryCount(sqlStr, values);
		}
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
	 * 构造更新对象的sql
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
	
	private String buildLoadSql() {
		return buildQuerySql("id");
	}
	
	private String buildQuerySql(String key) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(this.tableName);
		sql.append(" where "+key+"=?");
		return sql.toString();
	}
	
	private String buildQueryAllSql() {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(this.tableName);
		return sql.toString();
	}
	
	private String buildQueryLimitSql() {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(this.tableName).append(" limit ?, ? ");
		return sql.toString();
	}
	
	private String buildQueryCountSql() {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(id) from ").append(this.tableName);
		return sql.toString();
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

}

package base.dao.core;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class JDBCUtil {

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection("proxool.mysql");
	}

	/**
	 * 更新或者保存数据
	 * 
	 * @param sql
	 * @return
	 */
	@SuppressWarnings("resource")
	public static int updateOrSave(String sqlStr, List<Object> values) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			int size = values.size();
			for (int i = 0; i < size; i++) {
				ps.setObject((i + 1), values.get(i));
			}
			int result = ps.executeUpdate();
			ps = con.prepareStatement("select @@identity");
			rs = ps.executeQuery();
			int id = 0;
			if (rs.next()) {
				//只有保存的时候,才会返回id
				id = (Integer) rs.getInt(1);
			}
			if(result > 0 && id != 0){
				return id;
			}else{
				return 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return 0;
	}

	public static boolean delete(String sqlStr, int id) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			ps.setInt(1, id);
			int result = ps.executeUpdate();
			return result > 0 ? true : false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(null, ps, con);
		}
		return false;
	}

	/**
	 * 释放数据库的连接等资源
	 * 
	 * @param rs
	 * @param ps
	 * @param conn
	 */
	public static void free(ResultSet rs, PreparedStatement ps, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (ps != null) {
				ps.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 这个函数查询出来的将查出来的所有列的值放在list里面 每一条list记录有很多Object,用数组存储
	 * 
	 * @param sqlStr
	 * @param params
	 *            参数值
	 * @return
	 */
	public static <T> List<T> queryObjectList(String sqlStr, Class<T> clazz, Object... params) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		List<T> objs = new ArrayList<T>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSet(ps, sqlStr, params);
			while (rs.next()) {
				objs.add(getObject(rs, clazz));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return objs;
	}
	
	/**
	 * 这个函数查询出来的将查出来的所有列的值放在list里面 每一条list记录有很多Object,用数组存储
	 * 
	 * @param sqlStr
	 * @param params
	 *            参数值
	 * @return
	 */
	public static <T> List<T> querySQL(String sqlStr) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		List objs = new ArrayList();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ResultSetMetaData rsd = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = ps.executeQuery(sqlStr);
			while (rs.next()) {
				
				rsd = rs.getMetaData();
				int cols = rsd.getColumnCount();// 所有列数
				JSONObject obj = new JSONObject();
				for (int i = 0; i < cols; i++) {
					String columnName = rsd.getColumnName(i + 1);
					obj.put(columnName, rs.getObject(i + 1));
				}
				objs.add(JSON.parseObject(obj.toJSONString()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return objs;
	}

	/**
	 * 查询一个对象，而这个对象的所有属性值存放在数组中
	 * 
	 * @param sqlStr
	 * @param params
	 *            参数值
	 * @return
	 */
	public static <T> T queryObject(String sqlStr, Class<T> clazz, Object... params) {
		//System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSet(ps, sqlStr, params);
			if (rs.next()) {
				return getObject(rs, clazz);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return null;
	}
	/**
	 * 查询，
	 * 
	 * @param sqlStr
	 * @param list
	 *            参数值
	 * @return
	 */
	public static <T> T searchObject(String sqlStr, Class<T> clazz,Object... params){
		System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSet(ps, sqlStr, params);
			if (rs.next()) {
				return getObject(rs, clazz);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return null;
	}
	/**
	 * 查询，
	 * 
	 * @param sqlStr
	 * @param list
	 *            参数值
	 * @return
	 */
	public static <T> List<T> searchList(String sqlStr, Class<T> clazz,List<Object> list){
		System.out.println("JDBCUtil SQL: " + sqlStr);
		List<T> objs = new ArrayList<T>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSetList(ps, sqlStr, list);
			while (rs.next()) {
				objs.add(getObject(rs, clazz));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return objs;
	}
	
	
	/**
	 * 查询一个对象，而这个对象的所有属性值存放在数组中
	 * 
	 * @param sqlStr
	 * @param params
	 *            参数值
	 * @return
	 */
	public static long queryCount(String sqlStr, Object... params) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSet(ps, sqlStr, params);
			if (rs.next()) {
				return Long.parseLong(rs.getObject(1).toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return 0L;
	}
	
	//搜索
	public static long searchCount(String sqlStr, List<Object> list) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(sqlStr);
			rs = getResultSetList(ps, sqlStr, list);
			if (rs.next()) {
				return Long.parseLong(rs.getObject(1).toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			free(rs, ps, con);
		}
		return 0L;
	}
	private static ResultSet getResultSet(PreparedStatement ps, String sqlStr, Object[] params) throws Exception{
		int size = params.length;
		for (int i = 0; i < size; i++) {
			if(params[i] != null) {
				ps.setObject((i + 1), params[i]);
			}
		}
		return ps.executeQuery();
	}
	private static ResultSet getResultSetList(PreparedStatement ps, String sqlStr,List<Object> list) throws Exception{
		int size = list.size();
		for (int i = 0; i < size; i++) {
			ps.setObject((i + 1), list.get(i));
		}
		return ps.executeQuery();
	}

	private static <T> T getObject(ResultSet rs, Class<T> clazz) throws Exception{
		ResultSetMetaData rsd = rs.getMetaData();
		int cols = rsd.getColumnCount();// 所有列数
		JSONObject obj = new JSONObject();
		for (int i = 0; i < cols; i++) {
			String columnName = rsd.getColumnName(i + 1);
			obj.put(columnName, rs.getObject(i + 1));
		}
		return JSON.parseObject(obj.toJSONString(), clazz);
	}
}

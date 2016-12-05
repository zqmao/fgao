package base.util;

import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JDBCUtil {

	private static final String Url = "jdbc:mysql://localhost:3306/db_fgao?characterEncoding=UTF-8";
	private static final String User = "root";
	private static final String Password = "12344";
	private static final String Driver = "com.mysql.jdbc.Driver";
	private static Connection con = null;
	private static PreparedStatement ps = null;
	private static ResultSet rs = null;

	static {
		try {
			Class.forName(Driver);// 注册驱动
		} catch (ClassNotFoundException e) {
			throw new ExceptionInInitializerError(e);
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(Url, User, Password);
	}

	/**
	 * 更新或者保存数据
	 * 
	 * @param sql
	 * @return
	 */
	public static int updateOrSave(String sqlStr, List<Object> values) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
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
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (conn != null) {
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
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
		try {
			rs = getResultSet(sqlStr, params);
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
	public static <T> T queryObject(String sqlStr, Class<T> clazz, Object... params) {
		System.out.println("JDBCUtil SQL: " + sqlStr);
		try {
			rs = getResultSet(sqlStr, params);
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
	
	private static ResultSet getResultSet(String sqlStr, Object... params) throws Exception{
		con = getConnection();
		ps = con.prepareStatement(sqlStr);
		int size = params.length;
		for (int i = 0; i < size; i++) {
			ps.setObject((i + 1), params[i]);
		}
		return ps.executeQuery();
	}

	private static <T> T getObject(ResultSet rs, Class<T> clazz) throws Exception{
		ResultSetMetaData rsd = rs.getMetaData();
		int cols = rsd.getColumnCount();// 所有列数
		T result = null;
		try {
			result = clazz.newInstance();
		} catch (InstantiationException e1) {
			e1.printStackTrace();
		} catch (IllegalAccessException e1) {
			e1.printStackTrace();
		}
		for (int i = 0; i < cols; i++) {
			String columnName = rsd.getColumnName(i + 1);
			String columnTypeClassName = rsd.getColumnClassName(i + 1);
			columnName = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
			if(columnTypeClassName.contains("Integer")){
				Method m = clazz.getMethod("set" + columnName, int.class);
				m.invoke(result, rs.getInt(i + 1));
			}else if(columnTypeClassName.contains("Float")){
				Method m = clazz.getMethod("set" + columnName, float.class);
				m.invoke(result, rs.getFloat(i + 1));
			}else if(columnTypeClassName.contains("Long")){
				Method m = clazz.getMethod("set" + columnName, long.class);
				m.invoke(result, rs.getLong(i + 1));
			}else if(columnTypeClassName.contains("Boolean")){
				Method m = clazz.getMethod("set" + columnName, boolean.class);
				m.invoke(result, rs.getBoolean(i + 1));
			}else if(columnTypeClassName.contains("String")){
				Method m = clazz.getMethod("set" + columnName, String.class);
				m.invoke(result, rs.getString(i + 1));
			}
		}
		return result;
	}
}

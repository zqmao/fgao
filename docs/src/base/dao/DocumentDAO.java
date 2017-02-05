package base.dao;

import java.util.List;

import base.api.Document;
import base.util.JDBCUtil;


public class DocumentDAO extends BaseDAO {

	private static DocumentDAO dao;

	private DocumentDAO() {
		super("t_document");
	}

	public static DocumentDAO getInstance() {
		if (dao == null) {
			dao = new DocumentDAO();
		}
		return dao;
	}

	public List<Document> list(int categoryId, int index, int pagesize) {
		String sql = "select * from t_document where id != 0 and categoryId=? order by id limit ?,? ";
		List<Document> objs = JDBCUtil.queryObjectList(sql, Document.class, categoryId, index, pagesize);
		return objs;
	}
	
	public long listCount(int categoryId) {
		String sql = "select count(id) from t_document where categoryId=? ";
		return JDBCUtil.queryCount(sql, categoryId);
	}

	public Document load(int id) {
		String sql = "select * from t_document where id=?";
		return JDBCUtil.queryObject(sql, Document.class, id);
	}
	
	public Document query(String name) {
		String sql = "select * from t_document where name=?";
		return JDBCUtil.queryObject(sql, Document.class, name);
	}
}

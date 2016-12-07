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

	public List<Document> list(int categoryId) {
		String sql = "select * from t_document where id != 0 and categoryId=? order by id";
		List<Document> objs = JDBCUtil.queryObjectList(sql, Document.class, categoryId);
		return objs;
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

package base.dao;

import java.util.List;

import base.api.Document;
import base.dao.core.BaseDAO;
import base.dao.core.JDBCUtil;


public class DocumentDAO extends BaseDAO<Document> {

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

	public List<Document> list(int categoryId, int userId, String key, int index, int pagesize) {
		String sub = "";
		if(categoryId == -1){
		}else if(categoryId == -2){
			sub = " and userId="+userId;
		}else{
			sub = " and categoryId="+categoryId;
		}
		String sql = "select * from t_document where id != 0 "+sub+" and (title like ? or content like ?) order by id limit ?,? ";
		List<Document> objs = JDBCUtil.queryObjectList(sql, Document.class, "%"+key+"%", "%"+key+"%", index, pagesize);
		return objs;
	}
	
	public long listCount(int categoryId, int userId, String key) {
		String sub = "";
		if(categoryId == -1){
		}else if(categoryId == -2){
			sub = " and userId="+userId;
		}else{
			sub = " and categoryId="+categoryId;
		}
		String sql = "select count(id) from t_document where (title like ? or content like ?)" + sub;
		return JDBCUtil.queryCount(sql, "%"+key+"%", "%"+key+"%");
	}
	
	public Document query(String name) {
		String sql = "select * from t_document where name=?";
		return JDBCUtil.queryObject(sql, Document.class, name);
	}
}

package base.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import base.api.Bug;
import base.api.BugOperation;
import base.api.User;
import base.api.vo.BugOperationVO;
import base.api.vo.BugVO;
import base.dao.BugDAO;
import base.dao.BugOperationDAO;
import base.dao.UserDAO;
import base.util.DateUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

public class BugServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public BugServlet() {
		super();
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {// 查询列表
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			int option = Integer.parseInt(request.getParameter("option"));
			String select = request.getParameter("selectUser");
			int selectUser = 0;
			if(select == null || select.length() == 0){
				selectUser = currentUser.getId();
			}else{
				selectUser = Integer.parseInt(select);
			}
			int index = (page - 1) * rows;
			//0，全部；1，我创建的；2，我处理的；3，我完成的；4，我参与过的
			long total = 0;
			List<Bug> result = null;
			if(option == 0){
				result = BugDAO.getInstance().list(index, rows);
				total = BugDAO.getInstance().listCount();
			}else if(option == 1){
				result = BugDAO.getInstance().listUserCreate(selectUser, index, rows);
				total = BugDAO.getInstance().listUserCreateCount(selectUser);
			}else if(option == 2){
				result = BugDAO.getInstance().listUserHandle(selectUser, index, rows);
				total = BugDAO.getInstance().listUserHandleCount(selectUser);
			}else if(option == 3){
				result = BugDAO.getInstance().listUserFinish(selectUser, index, rows);
				total = BugDAO.getInstance().listUserFinishCount(selectUser);
			}else if(option == 4){
				result = BugDAO.getInstance().listUserPart(selectUser, index, rows);
				total = BugDAO.getInstance().listUserPartCount(selectUser);
			}
			for(Bug bug : result){
				List<BugOperation> bugOps = BugOperationDAO.getInstance().list(bug.getId());
				if(bugOps.size() > 0){
					BugOperation bugOp = bugOps.get(0);
					User user = UserDAO.getInstance().load(bugOp.getTargetId());
					bug.setCurrentName(user != null ? user.getName() : "人员消失");
				}else{
					bug.setCurrentName("未指派");
				}
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		} else if ("add".equals(sign)) {// 增加
			String category = (String) request.getParameter("category");
			String title = (String) request.getParameter("title");
			String createRemark = (String) request.getParameter("createRemark");
			String bugId = (String) request.getParameter("bugId");
			Bug bug = null;
			if(bugId == null || bugId.length() == 0){
				bug = new Bug();
			}else{
				bug = BugDAO.getInstance().load(Integer.parseInt(bugId));
			}
			bug.setCategory(category);
			bug.setCreateRemark(createRemark);
			bug.setTitle(title);
			if(currentUser != null){
				bug.setCreaterId(currentUser.getId());
				bug.setCreaterName(currentUser.getName());
				bug.setCreateTime(System.currentTimeMillis());
				bug.setFinisherName("未完成");
			}else{
				responseError("需要登录");
				return;
			}
			int bId = BugDAO.getInstance().saveOrUpdate(bug);
			if (bug.getId() == 0) {
				//新建的时候，自动指派给自己
				BugOperation bugOp = new BugOperation();
				bugOp.setBugId(bId);
				bugOp.setOperaterId(currentUser.getId());
				bugOp.setRemark("");
				bugOp.setTargetId(currentUser.getId());
				bugOp.setTime(System.currentTimeMillis());
				BugOperationDAO.getInstance().saveOrUpdate(bugOp);
				responseSuccess("增加成功");
			} else {
				responseSuccess("修改成功");
			}
		} else if ("delete".equals(sign)) {// 删除
			String bugIds = (String) request.getParameter("bugIds");
			for(String bugId : bugIds.split(",")){
				BugDAO.getInstance().delete(Integer.parseInt(bugId));
				BugDAO.getInstance().deleteOp(Integer.parseInt(bugId));
			}
			responseSuccess("删除成功");
		} else if ("finish".equals(sign)) {// 完成
			String bugIds = (String) request.getParameter("bugIds");
			String finishRemark = (String) request.getParameter("finishRemark");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			for(String bugId : bugIds.split(",")){
				Bug bug = BugDAO.getInstance().load(Integer.parseInt(bugId));
				bug.setFinisherId(currentUser.getId());
				bug.setFinisherName(currentUser.getName());
				bug.setFinishTime(System.currentTimeMillis());
				bug.setFinishRemark(finishRemark);
				BugDAO.getInstance().saveOrUpdate(bug);
			}
			responseSuccess("修改成功");
		} else if ("current".equals(sign)) {// 查询某个bug当前处理人员
			String bugId = (String) request.getParameter("bugId");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			List<BugOperation> result = BugOperationDAO.getInstance().list(Integer.parseInt(bugId));
			if(result.size() > 0){
				BugOperation bugOp = result.get(0);
				User user = UserDAO.getInstance().load(bugOp.getTargetId());
				responseSuccess(user != null ? user.getName() : "人员消失");
			}else{
				responseError("没有指派数据");
			}
		} else if ("passBug".equals(sign)) {// 查询某个bug当前处理人员
			String bugId = (String) request.getParameter("bugId");
			String passUser = (String)request.getParameter("passUser");
			String remark = (String)request.getParameter("remark");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			BugOperation bugOp = new BugOperation();
			bugOp.setBugId(Integer.parseInt(bugId));
			bugOp.setOperaterId(currentUser.getId());
			bugOp.setRemark(remark);
			bugOp.setTargetId(Integer.parseInt(passUser));
			bugOp.setTime(System.currentTimeMillis());
			BugOperationDAO.getInstance().saveOrUpdate(bugOp);
			responseSuccess("保存成功");
		} else if ("listOperation".equals(sign)) {// 查询某个bug当前处理人员
			String bugId = (String) request.getParameter("bugId");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			List<BugOperation> result = BugOperationDAO.getInstance().list(Integer.parseInt(bugId));
			JSONArray array = new JSONArray();
			for(BugOperation bugOp : result){
				BugOperationVO vo = new BugOperationVO();
				vo.setId(bugOp.getId());
				vo.setBugId(bugOp.getBugId());
				User target = UserDAO.getInstance().load(bugOp.getTargetId());
				User operater = UserDAO.getInstance().load(bugOp.getOperaterId());
				vo.setTarget(target != null ? target.getName() : "人员消失");
				vo.setOperater(operater != null ? operater.getName() : "人员消失");
				vo.setTime(DateUtil.toString(bugOp.getTime()));
				vo.setRemark(bugOp.getRemark());
				array.add(JSON.toJSON(vo));
			}
			JSONObject obj = new JSONObject();
			obj.put("total", result.size());
			obj.put("rows", JSON.toJSON(array));
			responseSuccess(JSON.toJSON(obj));
		} else if ("detail".equals(sign)) {// 查询某个bug详情
			String bugId = (String) request.getParameter("bugId");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			Bug bug = BugDAO.getInstance().load(Integer.parseInt(bugId));
			BugVO vo = new BugVO();
			vo.setCategory(bug.getCategory());
			vo.setCreateInfo(bug.getCreaterName() + " 于 " + DateUtil.toString(bug.getCreateTime()) + " 创建");
			vo.setCreateRemark(bug.getCreateRemark());
			if(bug.getFinisherId() != 0){
				vo.setFinishInfo(bug.getFinisherName() + " 于 " + DateUtil.toString(bug.getFinishTime()) + " 完成");
			}else{
				vo.setFinishInfo("未完成");
			}
			vo.setFinishRemark(bug.getFinishRemark());
			vo.setTitle(bug.getTitle());
			vo.setId(bug.getId());
			responseSuccess(JSON.toJSON(vo));
		}
	}

}

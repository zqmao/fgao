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
			//0，全部；1，我创建的；2，我处理的；3，我完成的；4，我参与过的
			List<Bug> result = null;
			if(option == 0){
				result = BugDAO.getInstance().list();
			}else if(option == 1){
				result = BugDAO.getInstance().listUserCreate(selectUser);
			}else if(option == 2){
				result = BugDAO.getInstance().listUserHandle(selectUser);
			}else if(option == 3){
				result = BugDAO.getInstance().listUserFinish(selectUser);
			}else if(option == 4){
				result = BugDAO.getInstance().listUserPart(selectUser);
			}
			
			int startIndex = (page - 1) * rows;
			int endIndex = page * rows;
			int total = result.size();
			if(total < endIndex){
				endIndex = total;
			}
			if(startIndex > endIndex){
				startIndex = 0;
			}
			List<Bug> tempResult = result.subList(startIndex, endIndex);
			for(Bug bug : tempResult){
				List<BugOperation> bugOps = BugOperationDAO.getInstance().list(bug.getId());
				if(bugOps.size() > 0){
					BugOperation bugOp = bugOps.get(0);
					User user = UserDAO.getInstance().load(bugOp.getTargetId());
					bug.setCurrentName(user.getName());
				}else{
					bug.setCurrentName("未指派");
				}
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(tempResult));
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
			}
			responseSuccess("修改成功");
		} else if ("finish".equals(sign)) {// 完成
			String bugIds = (String) request.getParameter("bugIds");
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			for(String bugId : bugIds.split(",")){
				Bug bug = BugDAO.getInstance().load(Integer.parseInt(bugId));
				bug.setFinisherId(currentUser.getId());
				bug.setFinisherName(currentUser.getName());
				bug.setFinishTime(System.currentTimeMillis());
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
				responseSuccess(user.getName());
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
				vo.setTarget(target.getName());
				vo.setOperater(operater.getName());
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
			User create = UserDAO.getInstance().load(bug.getCreaterId());
			vo.setCreateInfo(create.getName() + " 于 " + DateUtil.toString(bug.getCreateTime()) + " 创建");
			vo.setCreateRemark(bug.getCreateRemark());
			if(bug.getFinisherId() != 0){
				User finish = UserDAO.getInstance().load(bug.getFinisherId());
				vo.setFinishInfo(finish.getName() + " 于 " + DateUtil.toString(bug.getFinishTime()) + " 完成");
			}else{
				vo.setFinishInfo("未完成");
			}
			vo.setTitle(bug.getTitle());
			vo.setId(bug.getId());
			responseSuccess(JSON.toJSON(vo));
		}
	}

}

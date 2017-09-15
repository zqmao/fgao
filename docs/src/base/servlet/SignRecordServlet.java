package base.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import base.api.SignRecord;
import base.api.vo.SignRecordVO;
import base.dao.SignRecordDAO;
import base.util.DateUtil;

public class SignRecordServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public SignRecordServlet() {
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
			String select = request.getParameter("selectUser");
			int selectUser = 0;
			if(select == null || select.length() == 0){
				selectUser = currentUser.getId();
			}else{
				selectUser = Integer.parseInt(select);
			}
			int total = DateUtil.getMonthDayCount();
			List<SignRecordVO> result = new ArrayList<SignRecordVO>();
			for(int i = 0; i < total; i++){
				Calendar c = Calendar.getInstance();
				c.set(Calendar.HOUR_OF_DAY, 0);
				c.set(Calendar.MINUTE, 0);
				c.set(Calendar.SECOND, 0);
				c.set(Calendar.MILLISECOND, 0);
				c.set(Calendar.DAY_OF_MONTH, i+1);
				String dayTime = DateUtil.toDayString(c.getTimeInMillis());
				SignRecord record = SignRecordDAO.getInstance().query(dayTime, selectUser);
				SignRecordVO vo = null;
				if(record == null){
					vo = new SignRecordVO();
					vo.setDayTime(dayTime);
					if(c.getTimeInMillis() < System.currentTimeMillis()){
						vo.setSignInTime("未签到");
						vo.setSignOutTime("未签退");
					}
				}else{
					vo = new SignRecordVO(record);
				}
				result.add(vo);
			}
			
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		} else if ("signIn".equals(sign)) {// 签到
			if(currentUser == null){
				responseError("需要登录");
				return;
			}
			SignRecord record = getTodayRecord();
			if(record != null && record.getSignInTime() != 0){
				responseError("已经签到");
				return;
			}
			if(record == null){
				record = new SignRecord();
			}
			record.setUserId(currentUser.getId());
			
			long currentTime = System.currentTimeMillis();
			//在00：00到06：00之间不可以签到
			long zeroTime = DateUtil.getTime(0);
			long sixTime = DateUtil.getTime(6);
			if(currentTime > zeroTime && currentTime < sixTime){
				responseError("当前时间段不可以签到");
				return;
			}
			
			record.setSignInTime(currentTime);
			record.setDayTime(DateUtil.toDayString(currentTime));
			SignRecordDAO.getInstance().saveOrUpdate(record);
			responseSuccess("签到成功");
		} else if ("signOut".equals(sign)) {// 签退
			SignRecord record = getTodayRecord();
			if(record == null || record.getSignInTime() == 0){
				responseError("今天还没有签到");
				return;
			}
			long currentTime = System.currentTimeMillis();
			record.setSignOutTime(currentTime);
			SignRecordDAO.getInstance().saveOrUpdate(record);
			responseSuccess("签退成功");
		} else if ("handle".equals(sign)) {// 管理员维护
			String signDays = (String) request.getParameter("signDays");
			for(String signDay : signDays.split(",")){
				//根据每天来维护
			}
			responseSuccess("维护成功");
		} else if ("query".equals(sign)) {// 查询是否签到或者签退
			//签  到+签  退 11
			//签  到+未签退 10
			//未签到+签  退 01
			//未签到+未签退 00
			SignRecord record = getTodayRecord();
			if(record == null){
				responseSuccess("00");
			}else{
				if(record.getSignInTime() == 0 && record.getSignOutTime() == 0){
					responseSuccess("00");
				}else if(record.getSignInTime() == 0 && record.getSignOutTime() != 0){
					responseSuccess("01");
				}else if(record.getSignInTime() != 0 && record.getSignOutTime() == 0){
					responseSuccess("10");
				}else if(record.getSignInTime() != 0 && record.getSignOutTime() != 0){
					responseSuccess("11");
				}
			}
		}
	}
	
	private SignRecord getTodayRecord(){
		if(currentUser == null){
			return null;
		}
		long currentTime = System.currentTimeMillis();
		String dayTime = DateUtil.toDayString(currentTime);
		return SignRecordDAO.getInstance().query(dayTime, currentUser.getId());
	}

}

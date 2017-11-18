package base.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.csvreader.CsvReader;

import base.api.PreSaleRecord;
import base.api.User;
import base.api.vo.PreSaleRecordVO;
import base.dao.PreSaleRecordDAO;
import base.dao.UserDAO;

public class PreSaleRecordServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	public PreSaleRecordServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doPost(request, response);
		if ("list".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			// 管理员可以查看所有人的数据，普通人员只能查看自己的数据
			int page = Integer.parseInt(request.getParameter("page"));
			int rows = Integer.parseInt(request.getParameter("rows"));
			String select = request.getParameter("selectUser");
			int selectUser = 0;
			if (select == null || select.length() == 0) {
				selectUser = currentUser.getId();
			} else {
				selectUser = Integer.parseInt(select);
			}
			int index = (page - 1) * rows;
			List<PreSaleRecordVO> result = new ArrayList<PreSaleRecordVO>();
			long total = PreSaleRecordDAO.getInstance().listCount(selectUser);
			List<PreSaleRecord> records = PreSaleRecordDAO.getInstance().list(selectUser, index, rows);
			for (PreSaleRecord record : records) {
				PreSaleRecordVO vo = new PreSaleRecordVO(record);
				result.add(vo);
			}
			JSONObject obj = new JSONObject();
			obj.put("total", total);
			obj.put("rows", JSON.toJSON(result));
			responseSuccess(JSON.toJSON(obj));
		} else if ("selfCheck".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			int id = Integer.parseInt(request.getParameter("id"));
			String couponQuota = request.getParameter("couponQuota");
			String returnMoney = request.getParameter("returnMoney");
			String specialExpress = request.getParameter("specialExpress");
			String specialGift = request.getParameter("specialGift");
			String selfCheckRemark = request.getParameter("selfCheckRemark");
			PreSaleRecord record = PreSaleRecordDAO.getInstance().load(id);
			if (record != null) {
				record.setCouponQuota(couponQuota);
				record.setReturnMoney(returnMoney);
				record.setSpecialExpress(specialExpress);
				record.setSpecialGift(specialGift);
				record.setSelfCheckRemark(selfCheckRemark);
				record.setSelfCheck(1);
			}
			PreSaleRecordDAO.getInstance().saveOrUpdate(record);
			responseSuccess("自审完成");
		} else if ("financeCheck".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			int id = Integer.parseInt(request.getParameter("id"));
			String financeCheckRemark = request.getParameter("financeCheckRemark");
			String financeCheck = request.getParameter("financeCheck");
			PreSaleRecord record = PreSaleRecordDAO.getInstance().load(id);
			if (record != null) {
				record.setFinanceCheckRemark(financeCheckRemark);
				record.setFinanceCheck(Integer.parseInt(financeCheck));
			}
			PreSaleRecordDAO.getInstance().saveOrUpdate(record);
			responseSuccess("自审完成");
		} else if ("uploadPreSaleRecord".equals(sign)) {
			if (currentUser == null) {
				responseError("需要登录");
				return;
			}
			String path = "";
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				ServletFileUpload upload = new ServletFileUpload(factory);
				List<FileItem> items = upload.parseRequest(request);
				for (FileItem item : items) {
					if (item.isFormField()) {
						String inputName = item.getFieldName();
						String inputValue = item.getString();
						System.out.println(inputName + "::" + inputValue);
					} else {
						path = request.getRealPath("/upload");
						String filename = item.getName();// 上传文件的文件名
						if (filename == null || filename.length() == 0) {
							responseError("请选择文件");
							return;
						}
						InputStream is = item.getInputStream();
						String localPath = path + "\\uploadPreSale_" + System.currentTimeMillis() + filename;
						File file = new File(localPath);
						File parent = file.getParentFile();
						if(!parent.exists()){
							parent.mkdirs();
						}
						System.out.println(localPath + "::" + "localPath");
						FileOutputStream fos = new FileOutputStream(localPath);

						byte[] buff = new byte[1024];
						while (is.available() >= 1024) {
							is.read(buff);
							fos.write(buff);
						}
						byte[] buff1 = new byte[is.available()];
						is.read(buff1);
						fos.write(buff1);
						fos.flush();
						System.out.println("文件生成成功");
						is.close();
						fos.close();
//						readExcel(localPath);
						readCsvAndInstallDB(localPath);
						responseSuccess("售前记录导入成功");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	private Map<String, String> readExcel(String localPath) {
		Map<String, String> map = new HashMap<String, String>();
		InputStream stream;
		try {
			stream = new FileInputStream(localPath);
			Workbook wb = null;
			if (localPath.endsWith("xls")) {
				wb = new HSSFWorkbook(stream);
			}
			if (localPath.endsWith("xlsx")) {
				wb = new XSSFWorkbook(stream);
			}
			Sheet sheet = wb.getSheetAt(0);
			System.out.println(sheet.getLastRowNum());
			for (int i = 1; i < sheet.getLastRowNum() + 1; i++) {
				if (i % 1000 == 0) {
					System.out.println("便利到索引：" + i);
				}
				Row data = sheet.getRow(i);
				if (data == null) {
					continue;
				}
				String orderNum = "";
				Cell orderNumCell = data.getCell(0);// 订单编码
				if (orderNumCell != null && orderNumCell.getCellTypeEnum() == CellType.STRING) {
					orderNum = orderNumCell.getStringCellValue();
				}
				if (orderNumCell != null && orderNumCell.getCellTypeEnum() == CellType.NUMERIC) {
					orderNum = new DecimalFormat("#").format(orderNumCell.getNumericCellValue());
				}
				String doneOrderUserName = "";
				Cell doneOrderUserNameCell = data.getCell(6);// 落实下单的人员
				if (doneOrderUserNameCell != null && doneOrderUserNameCell.getCellTypeEnum() == CellType.STRING) {
					doneOrderUserName = doneOrderUserNameCell.getStringCellValue();
				}
				String donePayUserName = "";
				Cell donePayUserNameCell = data.getCell(7);// 落实付款的人员
				if (donePayUserNameCell != null && donePayUserNameCell.getCellTypeEnum() == CellType.STRING) {
					donePayUserName = donePayUserNameCell.getStringCellValue();
				}
				if (null == donePayUserName || donePayUserName.length() == 0) {
					continue;
				}
				String remark = "";
				Cell remarkCell = data.getCell(10);// 备注
				if (remarkCell != null && remarkCell.getCellTypeEnum() == CellType.STRING) {
					remark = remarkCell.getStringCellValue();
				}

				// 判断该orderNum是否已经存在，已经存在就修改当前记录
				PreSaleRecord record = PreSaleRecordDAO.getInstance().queryForEq("orderNum", orderNum);
				if (record == null) {
					record = new PreSaleRecord();
					record.setImportUserId(currentUser.getId());
				}
				record.setOrderNum(orderNum);
				User doneOrderUser = UserDAO.getInstance().query(doneOrderUserName);
				if (doneOrderUserName != null && donePayUserName.equals(doneOrderUserName)) {
					if (null == doneOrderUser) {
						record.setDoneOrderUserId(-1);
						record.setDonePayUserId(-1);
					} else {
						record.setDoneOrderUserId(doneOrderUser.getId());
						record.setDonePayUserId(doneOrderUser.getId());
					}
				} else {
					if (null == doneOrderUser) {
						record.setDoneOrderUserId(-1);
					} else {
						record.setDoneOrderUserId(doneOrderUser.getId());
					}
					User donePayUser = UserDAO.getInstance().query(donePayUserName);
					if (null == donePayUser) {
						record.setDonePayUserId(-1);
					} else {
						record.setDonePayUserId(donePayUser.getId());
					}
				}
				record.setImportTime(System.currentTimeMillis());
				record.setRemark(remark);
				PreSaleRecordDAO.getInstance().saveOrUpdate(record);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}

	public void readCsvAndInstallDB(String localPath) throws Exception {
		CsvReader reader = new CsvReader(localPath, ',', Charset.forName("GBK"));
		System.out.println(localPath);
		try {
			//过滤掉第一行标题
			reader.readRecord();
			//读取数据
			int i = 0;
			while (reader.readRecord()) {
				if (i % 1000 == 0) {
					System.out.println("遍历到索引：" + i);
				}
				i++;
				String orderNum = reader.get(0);
				String doneOrderUserName = reader.get(6);
				String donePayUserName = reader.get(7);
				if (null == donePayUserName || donePayUserName.length() == 0) {
					continue;
				}
				String remark = reader.get(10);// 备注

				// 判断该orderNum是否已经存在，已经存在就修改当前记录
				PreSaleRecord record = PreSaleRecordDAO.getInstance().queryForEq("orderNum", orderNum);
				if (record == null) {
					record = new PreSaleRecord();
					record.setImportUserId(currentUser.getId());
				}
				record.setOrderNum(orderNum);
				User doneOrderUser = UserDAO.getInstance().query(doneOrderUserName);
				if (doneOrderUserName != null && donePayUserName.equals(doneOrderUserName)) {
					if (null == doneOrderUser) {
						record.setDoneOrderUserId(-1);
						record.setDonePayUserId(-1);
					} else {
						record.setDoneOrderUserId(doneOrderUser.getId());
						record.setDonePayUserId(doneOrderUser.getId());
					}
				} else {
					if (null == doneOrderUser) {
						record.setDoneOrderUserId(-1);
					} else {
						record.setDoneOrderUserId(doneOrderUser.getId());
					}
					User donePayUser = UserDAO.getInstance().query(donePayUserName);
					if (null == donePayUser) {
						record.setDonePayUserId(-1);
					} else {
						record.setDonePayUserId(donePayUser.getId());
					}
				}
				record.setImportTime(System.currentTimeMillis());
				record.setRemark(remark);
				PreSaleRecordDAO.getInstance().saveOrUpdate(record);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}

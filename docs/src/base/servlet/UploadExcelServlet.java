package base.servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import base.api.Arrange;
import base.api.User;
import base.dao.ArrangeDAO;
import base.dao.UserDAO;

public class UploadExcelServlet extends BaseServlet {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("deprecation")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		super.doPost(request, response);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 获取文件需要上传到的路径
		String path = request.getRealPath("/upload");
		factory.setRepository(new File(path));
		factory.setSizeThreshold(1024 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> list = (List<FileItem>) upload.parseRequest(request);
			for (FileItem item : list) {
				String name = item.getFieldName();
				if (item.isFormField()) {
					String value = item.getString();
					request.setAttribute(name, value);
				} else {
					// 获取路径名
					String filename = item.getName();
					if (!filename.endsWith("xlsx") && !filename.endsWith("xls")) {
						responseError("请上传Excel文件");
						return;
					}
					request.setAttribute(name, filename);
					String localPath = path + filename;
					OutputStream out = new FileOutputStream(new File(localPath));
					InputStream in = item.getInputStream();
					int length = 0;
					byte[] buf = new byte[1024];
					System.out.println("获取上传文件的总共的容量：" + item.getSize());
					while ((length = in.read(buf)) != -1) {
						out.write(buf, 0, length);
					}
					in.close();
					out.close();
					readExcel(localPath);
				}
			}
			responseSuccess("导入成功");
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void readExcel(String localPath) {
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
			Row day = sheet.getRow(0);
			short num = day.getLastCellNum();
			Map<Integer, Long> days = new HashMap<Integer, Long>();
			for(int i = 0; i < num; i++){
				Cell cell = day.getCell(i);
				if(cell != null && cell.getCellTypeEnum() == CellType.NUMERIC){
					if(HSSFDateUtil.isCellDateFormatted(cell)){
						days.put(i, HSSFDateUtil.getJavaDate(cell.getNumericCellValue()).getTime());
					}
				}
			}
			Set<Integer> indexs = days.keySet();
			for(int i = 1; i < sheet.getLastRowNum() + 1; i++){
				Row data = sheet.getRow(i);
				if(data == null){
					continue;
				}
				Cell nameCell = data.getCell(0);
				int userId = 0;
				if(nameCell != null && nameCell.getCellTypeEnum() == CellType.STRING){
					String name = nameCell.getStringCellValue();
					User user = UserDAO.getInstance().query(name);
					if(user == null){
						continue;
					}
					userId = user.getId();
				}
				for(Integer index : indexs){
					Cell dataCell = data.getCell(index);
					if(dataCell != null && dataCell.getCellTypeEnum() == CellType.STRING){
						String status = dataCell.getStringCellValue();
						if(!status.equals(Arrange.EARLY) && !status.equals(Arrange.NIGHT) && !status.equals(Arrange.NORMAL) && !status.equals(Arrange.REST)){
							continue;
						}
						Arrange arrange = ArrangeDAO.getInstance().query(userId, days.get(index));
						if(arrange == null){
							arrange = new Arrange();
						}
						arrange.setDay(days.get(index));
						arrange.setStatus(status);
						arrange.setUserId(userId);
						ArrangeDAO.getInstance().saveOrUpdate(arrange);
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}

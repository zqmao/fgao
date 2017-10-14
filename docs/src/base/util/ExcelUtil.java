package base.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import base.api.ExportOrderList;
import base.dao.ExportOrderListDAO;

public class ExcelUtil {
	
	public static String writeTxt(HttpServletRequest request, HttpServletResponse response, String path){
		String fileName = System.currentTimeMillis() + ".txt";
		String txtPath = "http://" + request.getLocalAddr() + ":"
				+ request.getLocalPort() + "/"
				+ request.getContextPath() + "/upload/analysis/" + fileName;
		String localPath = request.getRealPath("/upload") + "/analysis/" + fileName;
		Map<String, String> map = readExcel(path);
		//比对的时候，需要判断月份是否符合
		Set<String> keySet = map.keySet();
		int index = 0;
		for(String key : keySet){
			ExportOrderList result = ExportOrderListDAO.getInstance().query(key, map.get(key));
			if(result == null){
				//数据库中没有对应记录，把快递单号记录到txt文件中
				appendText(localPath, key + "\r\n");
			}
			if(index % 1000 == 0){
				System.out.println("处理了1000条了");
			}
			index++;
		}
		System.out.println("处理完了");
		return txtPath;
	}
	
	private static void appendText(String fileName, String content){
		File file = new File(fileName);
		File dir = file.getParentFile();
		if(!dir.exists()){
			dir.mkdirs();
		}
		FileWriter writer = null;  
        try {     
            // 打开一个写文件器，构造函数中的第二个参数true表示以追加形式写文件     
            writer = new FileWriter(fileName, true);     
            writer.write(content);       
        } catch (IOException e) {     
            e.printStackTrace();     
        } finally {     
            try {     
                if(writer != null){  
                    writer.close();     
                }  
            } catch (IOException e) {     
                e.printStackTrace();     
            }     
        }   
	}
	
	private static Map<String, String> readExcel(String localPath) {
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
			for(int i = 1; i < sheet.getLastRowNum() + 1; i++){
				Row data = sheet.getRow(i);
				if(data == null){
					continue;
				}
				Cell nameCell = data.getCell(0);
				if(nameCell != null && nameCell.getCellTypeEnum() == CellType.STRING){
					String name = nameCell.getStringCellValue();
					if(name == null || name.length() == 0){
						
					}else{
						Cell timeCell = data.getCell(1);
						if(timeCell != null)
						map.put(name, timeCell.getStringCellValue().substring(0, 7));
					}
				}
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return map;
	}

}

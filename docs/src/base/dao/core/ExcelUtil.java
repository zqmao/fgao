package base.dao.core;

import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileNotFoundException;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.text.SimpleDateFormat;  
import java.util.ArrayList;  
import java.util.Date;  
import java.util.Random;  
  
import org.apache.poi.ss.usermodel.PictureData;  
import org.apache.poi.ss.usermodel.Row;  
import org.apache.poi.ss.usermodel.Sheet;  
import org.apache.poi.ss.usermodel.Cell;  
import org.apache.poi.hssf.usermodel.HSSFWorkbook;  
import org.apache.poi.ss.usermodel.Workbook;  
import org.apache.poi.ss.util.NumberToTextConverter;  
import org.apache.poi.xssf.usermodel.XSSFWorkbook;  

public class ExcelUtil {
	private Workbook wb;  
    private Sheet sheet;  
    private int rowNum;  
    private int colNum;  
    private String dateFormat;//日期格式化参数  
    private static int EXCELL_2003 = 2003;  
    private static int EXCELL_2007 = 2007;  
    private ArrayList<PictureData> pictures;//所有图片  
    private String basePath;//图片保存路径            有图片必须设置该值  
    private String projectName;//项目工程名称  有图片必须设置该值  
    private SimpleDateFormat picBaseName = new SimpleDateFormat("yyyyMMddHHmmss");  
    /** 
     * 根据文件的路径进行初始化 
     * @param filePath 文件的路径 
     * @throws IOException 
     */  
    @SuppressWarnings("unchecked")
	public void initByPath(String filePath) throws IOException{  
         InputStream stream= new FileInputStream(new File(filePath));  
         if(getExcellVersion(filePath)==EXCELL_2003){  
             this.wb=new HSSFWorkbook(stream);  
         }else if (getExcellVersion(filePath)==EXCELL_2007) {  
             this.wb=new XSSFWorkbook(stream);  
         }  
       pictures=(ArrayList<PictureData>)this.wb.getAllPictures();  
       stream.close();    
       this.sheet = wb.getSheetAt(0);  
       this.rowNum = sheet.getLastRowNum();  
       this.colNum = sheet.getRow(0).getPhysicalNumberOfCells();  
    }  
      
    /** 
     * 根据输入流和文件的名称来初始化 
     * @param stream 
     * @param fileName 文件的名称  必须包含文件的后缀名称 
     * @throws IOException 
     */  
    public void initByStream(InputStream stream,String fileName) throws IOException{  
        //InputStream stream= new FileInputStream(new File(filePath));  
        if(getExcellVersion(fileName)==EXCELL_2003){  
            this.wb=new HSSFWorkbook(stream);  
        }else if (getExcellVersion(fileName)==EXCELL_2007) {  
         this.wb=new XSSFWorkbook(stream);  
        }  
      pictures=(ArrayList<PictureData>)this.wb.getAllPictures();  
      stream.close();     
      this.sheet = wb.getSheetAt(0);      
      this.rowNum = sheet.getLastRowNum();  
      this.colNum = sheet.getRow(0).getPhysicalNumberOfCells();  
   }  
      
     
    /** 
     * 读取表头数据 
     * @return 
     */  
    public String[] readExcelTitle() {  
        Row row = sheet.getRow(0);  
        // 标题总列数  
        int colNum = row.getPhysicalNumberOfCells();  
        System.out.println("colNum:" + colNum);  
        String[] title = new String[colNum];  
        for (int i = 0; i < colNum; i++) {  
            //title[i] = getStringCellValue(row.getCell((short) i));  
            title[i] = getCellFormatValue(row.getCell((short) i));  
        }  
        return title;  
    }  
      
  
    /** 
     * 读取某一行数据 
     * @param rowIndex 行数 
     * @return 
     */  
    public ArrayList<String> getRowDate(int rowIndex){  
        ArrayList<String> rowData=new ArrayList<String>();  
        try {  
            Row row=sheet.getRow(rowIndex);  
             int j = 0;  
             while (j < colNum) {             
                String value= getCellFormatValue(row.getCell((short) j)).trim();  
                if("".equals(value)){  
                    value=null;  
                }  
                rowData.add(value);  
                              
                j++;  
                   
             }  
               
             if(pictures!=null && pictures.size()>rowIndex-1){  
                 PictureData pictureData = pictures.get(rowIndex-1);  
                   
                 byte[] data = pictureData.getData();  
                 String ext = pictureData.suggestFileExtension();//获取扩展名  
                   
                 String newFileName = picBaseName.format(new Date()) + "_"  
                        + new Random().nextInt(1000000) + "." + ext;  
                   
                 FileOutputStream out = new FileOutputStream(this.basePath + newFileName);  
                   
                 out.write(data);  
                 out.close();  
                   
                 String url = this.basePath.substring(this.basePath.lastIndexOf(  
                         this.projectName.substring(1, this.projectName.length())),this.basePath.length());            
                 rowData.add(File.separator+url+newFileName);  
             }  
         } catch (IOException e) {  
           e.printStackTrace();  
         }  
           
        return rowData;       
    }  
  
    /** 
     * 获取单元格数据内容为字符串类型的数据 
     *  
     * @param cell Excel单元格 
     * @return String 单元格数据内容 
     */  
    private String getStringCellValue(Cell cell) {  
        String strCell = "";  
        if (cell == null) {  
            return "";  
        }  
        switch (cell.getCellType()) {  
        case Cell.CELL_TYPE_STRING:  
            strCell = cell.getStringCellValue();  
            break;  
        case Cell.CELL_TYPE_NUMERIC:  
            strCell = String.valueOf(cell.getNumericCellValue());  
            break;  
        case Cell.CELL_TYPE_BOOLEAN:  
            strCell = String.valueOf(cell.getBooleanCellValue());  
            break;  
        case Cell.CELL_TYPE_BLANK:  
            strCell = "";  
            break;  
        default:  
            strCell = "";  
            break;  
        }  
        if ("".equals(strCell) || strCell == null) {  
            return "";  
        }  
         
        return strCell;  
    }  
  
    /** 
     * 获取单元格数据内容为日期类型的数据 
     *  
     * @param cell 
     *            Excel单元格 
     * @return String 单元格数据内容 
     */  
    private String getDateCellValue(Cell cell) {  
        String result = "";  
        try {  
            int cellType = cell.getCellType();  
            if (cellType == Cell.CELL_TYPE_NUMERIC) {  
                Date date = cell.getDateCellValue();  
                result = (date.getYear() + 1900) + "-" + (date.getMonth() + 1)  
                        + "-" + date.getDate();  
            } else if (cellType == Cell.CELL_TYPE_STRING) {  
                String date = getStringCellValue(cell);  
                result = date.replaceAll("[年月]", "-").replace("日", "").trim();  
            } else if (cellType == Cell.CELL_TYPE_BLANK) {  
                result = "";  
            }  
        } catch (Exception e) {  
            System.out.println("日期格式不正确!");  
            e.printStackTrace();  
        }  
        return result;  
    }  
  
    /** 
     * 根据HSSFCell类型设置数据 
     * @param cell 
     * @return 
     */  
    private String getCellFormatValue(Cell cell) {  
        String cellvalue = "";  
        if (cell != null) {  
            // 判断当前Cell的Type  
            switch (cell.getCellType()) {  
            case Cell.CELL_TYPE_BLANK:  
                break;  
            case Cell.CELL_TYPE_BOOLEAN:  
                cellvalue=String.valueOf(cell.getBooleanCellValue());  
                break;  
            case Cell.CELL_TYPE_ERROR:  
                 break;  
            // 如果当前Cell的Type为NUMERIC  
            case Cell.CELL_TYPE_NUMERIC:  
            case Cell.CELL_TYPE_FORMULA: {  
                // 判断当前的cell是否为Date  
                if (org.apache.poi.ss.usermodel.DateUtil.isCellDateFormatted(cell)) {  
                    Date date = cell.getDateCellValue();  
                    SimpleDateFormat sdf=null;  
                    if(this.dateFormat!=null && !"".equals(this.dateFormat)){                         
                         sdf = new SimpleDateFormat(this.dateFormat);  
                          
                    }else{  
                         sdf = new SimpleDateFormat("yyyy-MM-dd");    
                    }  
                    cellvalue = sdf.format(date);  
                }else {  
                    // 如果是纯数字  
                    //cellvalue = String.valueOf(cell.getNumericCellValue());  
                    cellvalue=NumberToTextConverter.toText(cell.getNumericCellValue());  
                }  
                break;  
            }  
            // 如果当前Cell的Type为STRIN  
            case Cell.CELL_TYPE_STRING:  
                // 取得当前的Cell字符串  
                cellvalue = cell.getRichStringCellValue().getString();  
                break;  
            // 默认的Cell值  
            default:  
                cellvalue = "";  
            }  
        }  
        return cellvalue;  
  
    }  
      
    /** 
     * 功能：获取excell版本 
     */  
    public static int getExcellVersion(String fileName)  
    {  
        if(fileName.matches("^.+\\.(?i)(xlsx)$")){  
            return EXCELL_2007;  
        }  
        if (fileName.matches("^.+\\.(?i)(xls)$"))  
        {  
            return EXCELL_2003;  
        }  
        return 0;  
    }  
      
    public int getRowNum() {  
        return rowNum;  
    }  
    public void setRowNum(int rowNum) {  
        this.rowNum = rowNum;  
    }  
    public int getColNum() {  
        return colNum;  
    }  
    public void setColNum(int colNum) {  
        this.colNum = colNum;  
    }  
          
    public String getDateFormat() {  
        return dateFormat;  
    }  
    public void setDateFormat(String dateFormat) {  
        this.dateFormat = dateFormat;  
    }  
      
    public String getBasePath() {  
        return basePath;  
    }  
  
    public void setBasePath(String basePath) {  
        this.basePath = basePath;  
    }  
  
    public String getProjectName() {  
        return projectName;  
    }  
  
    public void setProjectName(String projectName) {  
        this.projectName = projectName;  
    }  
  
    public static void main(String[] args) {  
        try {  
            // 对读取Excel表格标题  
            ExcelUtil excelReader = new ExcelUtil();  
            excelReader.initByPath("D:\\拨打数据 11.4.xlsx");  
            String[] title = excelReader.readExcelTitle(); 
            System.out.println("获得Excel表格的标题:"); 
            int m = excelReader.searchTitle("收货地址",title);
           
            System.out.println("获得订单编号的列数:"+m); 
           
            int rowcount=excelReader.getRowNum();  
            int columncount = excelReader.getColNum();  
            System.out.println("行数："+rowcount);  
            System.out.println("列数："+columncount);  
            //循环读取数据  
           for(int i=1;i<=rowcount;i++){  
                ArrayList<String> datas=excelReader.getRowDate(i);  
                  
                String rowstring="";  
                 for(int j=0;j<datas.size();j++){  
                     System.out.println(datas.get(j));  
                     rowstring+=datas.get(j)+" ";  
                 }  
                 System.out.println(rowstring);  
            } 
               
        } catch (FileNotFoundException e) {  
            System.out.println("未找到指定路径的文件!");  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    } 
    public int searchTitle(String str,String[] title){
    	int num;
    	for(num=0;num<title.length;num++){
    		if(str.equals(title[num].trim())){
    			break;
    		}
    	}
    	return num;
    } 
}

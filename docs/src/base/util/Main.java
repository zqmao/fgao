package base.util;

import java.util.ArrayList;
import java.util.List;

public class Main {
	public static void main(String[] args) {
		List<Object> head = new ArrayList<Object>();
		head.add("a");
		head.add("b");
		head.add("c");
		head.add("d");
		head.add("a");
		List<List<Object>> dataList = new ArrayList<List<Object>>();
		dataList.add(head);
		dataList.add(head);
		dataList.add(head);
		CsvUtil.createCSVFile(head, dataList, "C:/", "ff");
	}
}

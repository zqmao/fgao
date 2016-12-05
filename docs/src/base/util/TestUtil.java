package base.util;

import java.util.ArrayList;
import java.util.List;

public class TestUtil {
	
	public static void main(String[] args) {
		List<String> rs = new ArrayList<String>();
		for(int i = 0; i < 20; i++){
			rs.add("--" + i);
		}
		for(int i = 0; i < rs.size(); i++){
			String r = rs.get(i);
			if(r.indexOf("2") != -1){
				rs.remove(r);
			}
		}
		for(int i = 0; i < rs.size(); i++){
			System.out.println(rs.get(i));
		}
		
	}

}

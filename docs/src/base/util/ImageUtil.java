package base.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class ImageUtil {

	// 图片转化成base64字符串
	public static String imageToBase64() {
		String imgFile = "d://test.jpg";
		InputStream in = null;
		byte[] data = null;
		// 读取图片字节数组
		try {
			in = new FileInputStream(imgFile);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);
	}

	public static boolean base64ToImage(String src, String target) {
		if (src == null) 
			return false;
		int index = src.indexOf(",");
		if(index != -1){
			src = src.substring(index + 1);
		}
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] b = decoder.decodeBuffer(src);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {
					b[i] += 256;
				}
			}
			OutputStream out = new FileOutputStream(target);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}

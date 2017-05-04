package base.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import base.util.FileUtil;

public class ZhuangBiListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		String path = sce.getServletContext().getRealPath("/fozu.txt");
		String fozu = FileUtil.read(path);
		System.out.println(fozu);
	}

}

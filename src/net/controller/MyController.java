package net.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectStreamException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class MyController extends HttpServlet {
	
	//��ɾ�� ��ɾ� ó�� Ŭ������ ������ ����
	private Map commandMap = new HashMap();  
	
	//��ɾ�� ó��Ŭ������ ���εǾ� �ִ� properties������ �о Map��ü�� commandMap�� ����
	//��ɾ�� ó��Ŭ������ ���εǾ� �ִ� properties ������ command.properties����
	@Override
	public void init(ServletConfig config) throws ServletException {
		//web.xml���� propertyConfig�� �ش��ϴ� init-param�� ���� �о��
		String props = config.getInitParameter("propertyConfig");

		//��ɾ�� ó��Ŭ������ ���������� ������ Properties��ü ����
		Properties pr = new Properties(); 
		FileInputStream f =null;
		try {
			f=new FileInputStream(props);  //command.properties���� ��������
			pr.load(f);  //command.properties������ Properties��ü�� �����ϱ�
		}catch(IOException e) {
			System.out.println(e);
		}finally {
			if(f!=null) {
				try {
					f.close();
				}catch(Exception ex){
					
				}
			}//if end
		}
		Iterator keyIter = pr.keySet().iterator(); //Iterator��ü�� Enumeration��ü�� Ȯ���Ų ������ ��ü
		while(keyIter.hasNext()) {     //��ü�� �ϳ��� ������ �� ��ü������ Properties��ü�� ����� ��ü�� ����
			String key = (String)keyIter.next();
			String value = pr.getProperty(key);
			//System.out.println("#"+key+"#");     //���� Ȯ�ο�
			//System.out.println("#"+value+"#");  //���� Ȯ�ο�
			try {
				Class commandClass = Class.forName(value); //�ش� ���ڿ��� Ŭ������ �����
				Object commandInstance = commandClass.newInstance(); //�ش� Ŭ������ ��ü�� ����
				commandMap.put(key, commandInstance); //Map��ü�� commandMap�� ��ü ����
			}catch(Exception e) {System.out.println(e);}
		}//while end
		
	}//init() end
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}//doGet() end
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}//doPost() end
	
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = null;
		CommandAction com =null;
		try {
			String command = req.getRequestURI();
			com = (CommandAction)commandMap.get(command);
			view = com.requestPro(req, resp);
		} catch (Throwable e) {
			throw new ServletException(e);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher(view);
		dispatcher.forward(req, resp);
	}//process() end

}//class end

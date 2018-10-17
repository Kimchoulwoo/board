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
	
	//명령어와 명령어 처리 클래스를 쌍으로 지정
	private Map commandMap = new HashMap();  
	
	//명령어와 처리클래스가 매핑되어 있는 properties파일을 읽어서 Map객체인 commandMap에 저장
	//명령어와 처리클래스가 매핑되어 있는 properties 파일은 command.properties파일
	@Override
	public void init(ServletConfig config) throws ServletException {
		//web.xml에서 propertyConfig에 해당하는 init-param의 값을 읽어옴
		String props = config.getInitParameter("propertyConfig");

		//명령어와 처리클래스의 매핑정보를 저장할 Properties객체 생성
		Properties pr = new Properties(); 
		FileInputStream f =null;
		try {
			f=new FileInputStream(props);  //command.properties파일 가져오기
			pr.load(f);  //command.properties파일을 Properties객체에 저장하기
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
		Iterator keyIter = pr.keySet().iterator(); //Iterator객체는 Enumeration객체를 확장시킨 개념의 객체
		while(keyIter.hasNext()) {     //객체를 하나씩 꺼내서 그 객체명으로 Properties객체에 저장된 객체에 접근
			String key = (String)keyIter.next();
			String value = pr.getProperty(key);
			//System.out.println("#"+key+"#");     //에러 확인용
			//System.out.println("#"+value+"#");  //에러 확인용
			try {
				Class commandClass = Class.forName(value); //해당 문자열을 클래스로 만든다
				Object commandInstance = commandClass.newInstance(); //해당 클래스의 객체를 생성
				commandMap.put(key, commandInstance); //Map객체인 commandMap에 객체 저장
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

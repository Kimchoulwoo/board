package net.utility;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class EncodeFilter implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		// request ���������� ��ó���� �ڵ尡 ������ ���⼭ ó��
		// ���� response ���� ��ó���� �ڵ尡 �ִٸ� ���⼭ ó��
		
		arg0.setCharacterEncoding("UTF-8");
		arg2.doFilter(arg0, arg1);
	}//doFilter() end
	
}//class end

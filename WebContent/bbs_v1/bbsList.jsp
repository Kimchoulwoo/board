<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 bbsList.jsp -->
* 게시판 목록 *
<p align="right"><a href="bbsForm.jsp">[글쓰기]</a></p>
<table id="table-1">
<tr>
	<th>글제목</th>
	<th>작성자</th>
	<th>글작성일</th>
	<th>조회수</th>
	<th>작성자 IP</th>
</tr>
<%
	//전체 목록
	ArrayList<BbsDTO> list=dao.list();
	if(list==null){
		out.println("<tr>");
		out.println("		<td colspan='5'><strong>관련자료 없음!!!!</strong></td>");
		out.println("</tr>");
	}else{
		//오늘 날짜를 "2017-12-08" 문자열 작성
		String today=Utility.getDate();
		
		for(int idx=0; idx<list.size(); idx++){
			dto = list.get(idx);
%>
			<tr>
				<td style="text-align: left">				
<%
				for(int a=0; a<dto.getIndent(); a++){
					out.print("<img src='../images/reply.gif'>");
				}
				%>
					<a href='bbsRead.jsp?bbsno=<%=dto.getBbsno() %>' ><%=dto.getSubject() %></a>
<%                //오늘 작성한 글 제목 뒤에 new 이미지 추가
					String regdt = dto.getRegdt().substring(0,10);
					if(regdt.equals(today)){
						out.print("<img src='../images/new.gif'>");
					}//if end
					
					//조회수 10 이상은 hot 이미지 추가
					if(dto.getReadcnt()>=10){
						out.print("<img src='../images/hot.gif'>");
					}
					
%>
				</td>
				<td><%=dto.getWname() %></td>
				<td><%=regdt %></td>
				<td><%=dto.getReadcnt() %></td>
				<td><%=dto.getIp() %></td>
			</tr>
<%
		}//for end
	}//if end
%>
</table>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>
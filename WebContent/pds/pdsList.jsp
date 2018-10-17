<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsList.jsp -->
* 포토갤러리 목록 *
<p align="right"><a href="pdsForm.jsp">[사진 올리기]</a></p>
<table id="table-1">
<tr>
	<th>글번호</th>
	<th>작성자</th>
	<th>제목</th>
	<th>파일명</th>
	<th>조회수</th>
	<th>등록일</th>
</tr>
<%
	int totalRecord = dao.count();
	int recordPerPage = 5;
	
	ArrayList<PdsDTO> list=dao.list(nowPage, recordPerPage);
	if(list==null){
		out.println("<tr>");
		out.println("		<td colspan='5'><strong>관련자료 없음!!!!</strong></td>");
		out.println("</tr>");
	}else{
		for(int idx=0; idx<list.size(); idx++){
			dto = list.get(idx);
			String today=Utility.getDate();
%>
			<tr>
				<td><%=dto.getPdsno() %></td>
				<td><%=dto.getWname() %></td>
				<td style="text-align: left">				
					<a href='pdsRead.jsp?pdsno=<%=dto.getPdsno() %>&nowPage=<%=nowPage%>' ><%=dto.getSubject() %></a>
					
<%                //오늘 작성한 글 제목 뒤에 new 이미지 추가
					String regdt = dto.getRegdate().substring(0,10);
					if(regdt.equals(today)){
						out.print("<img src='../images/new.gif'>");
					}//if end
					
					//조회수 10 이상은 hot 이미지 추가
					if(dto.getReadcnt()>=10){
						out.print("<img src='../images/hot.gif'>");
					}					
%>
				</td>
				<td><img src="../upload/<%=dto.getFilename() %>" width="50"></td>
				<td><%=dto.getReadcnt() %></td>
				<td><%=regdt %></td>
			</tr>
			
<%
		}//for end
%>
		<tr>
			<td colspan='6' style='text-align:right; font-size: 12px;'>글갯수 : <strong><%=list.size() %></strong>건</td>
		</tr>
		<tr>
			<td colspan='6' align="center">
			<!-- 페이지 리스트 -->
			<%
				String paging = new Paging().paging2(totalRecord, nowPage, recordPerPage, "pdsList.jsp");
				out.print(paging);
			%>
			</td>
		</tr>	
<%
	}//if end
%>
</table>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>
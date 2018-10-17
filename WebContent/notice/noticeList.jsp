<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>
<!-- 본문 시작 noticeList.jsp -->
* 공지사항 목록 *
<%if(s_mlevel.equals("A1")){%>
<p align="right"><a href="noticeForm.jsp">[글쓰기]</a></p>
<% } %>
<table id="table-1">
<tr>
	<th>글번호</th>
	<th>글제목</th>
	<th>내용</th>
	<th>글작성일</th>
</tr>
<%
	int totalRecord = dao.count(col, word);
	int recordPerPage = 5;
	
	//전체 목록
	ArrayList<NoticeDTO> list=dao.list(col, word, nowPage, recordPerPage);
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
				<td><%=dto.getNoticeno() %></td>
				<td>
					<a href='noticeRead.jsp?noticeno=<%=dto.getNoticeno() %>&col=<%=col %>&word=<%=word %>&nowPage=<%=nowPage%>'><%=dto.getSubject() %></a>
<%                //오늘 작성한 글 제목 뒤에 new 이미지 추가
					String regdt = dto.getRegdt().substring(0,10);
					if(regdt.equals(today)){
						out.print("<img src='../images/new.gif'>");
					}//if end
					String content = dto.getContent();
					if(content.length()>10){
						content = dto.getContent().substring(0,10);
					}					
%>
				</td>
				<td><%=content %>...</td>
				<td><%=regdt %></td>
			</tr>
<%
		}//for end
%>	
		<tr>
			<td colspan='5' align="center">
			<!-- 페이지 리스트 -->
			<%
				String paging = new Paging().paging2(totalRecord, nowPage, recordPerPage, col, word, "noticeList.jsp");
				out.print(paging);
			%>
			</td>
		</tr>	
		<tr>
			<td colspan='5' style='text-align: right; font-size: 12px'>
				글갯수 : <strong><%=totalRecord %></strong>건
			</td>
		</tr>
		<!-- 검색시작 -->
		<tr>
			<td colspan='5' align="right">
				<form method="post" action="noticeList.jsp" onsubmit="return search(this)">
					<select name="col">
						<option value="subject" selected>제목
						<option value="content">내용
						<option value="subject_content">제목+내용
					</select>
					<input type="test" size='10' name="word">
					<input type="submit" value="검색">
				</form>
			</td>
		</tr>
		<!-- 검색 끝 -->
<%	
	}//if end
%>
</table>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>
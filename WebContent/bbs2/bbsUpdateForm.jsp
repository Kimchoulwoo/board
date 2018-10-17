<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!-- 본문 시작 template.jsp -->
<c:if test="${article!=null }">
	<strong>* 글/쓰/기 *</strong>
	<br><br>
	<form method="post" name="writeform" action="./bbsupdateproc.do?pageNum=${pageNum }">
	<input type="hidden" name="num" value="${num }">
	<table id="table-2">
	<tr>
	  <td align="right" colspan=2 bgcolor="${value_c }">
	      <a href="/myweb/bbs2/bbslist.do">글목록</a></td>
	</tr>
	<tr>
	  <td bgcolor="${value_c }">이름</td>
	  <td><input type="text" name="writer" value="${article.writer }"></td>
	</tr>
	<tr>
	  <td bgcolor="${value_c }">제목</td>
	  <td><input type="text" name="subject" value="${article.subject }"></td>
	</tr>
	<tr>
	  <td bgcolor="${value_c }">이메일</td>
	  <td><input type="text" name="email" value="${article.email }"></td>
	</tr>
	<tr>
	  <td bgcolor="${value_c }">내용</td>
	  <td><textarea name="content" rows="5" cols="40">${article.content }</textarea></td>
	</tr>
	<tr>
	  <td bgcolor="${value_c }">비밀번호</td>
	  <td><input type="password" name="passwd" value="${article.passwd }"></td>
	</tr>
	<tr>
	  <td colspan=2 align="center">
	  <input type="submit" value="글쓰기">
	  <input type="reset"  value="취소">
	  <input type="button" value="목록보기" onClick="location.href='./bbslist.do'">
	  </td>
	</tr>
	</table>
	</form>
</c:if>

<c:if test="${article==null }">
	<p>비밀번호가 다릅니다.</p>
	<a href="javascript:history.go(-1)">[비밀번호 재입력]</a>
</c:if>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
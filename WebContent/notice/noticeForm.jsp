<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
* 공지사항 입력 *
<p align="right"><a href="noticeList.jsp">[공지사항 목록]</a></p>

<form name="noticefrm" 
		method="post" 
		action="noticeIns.jsp" 
		onsubmit="return noticeCheck(this)"
		class="noticefrm">
<table id="table-2">
<tr>
    <th>제목</th>
    <td><input type="text" name="subject" size="20"></td>
</tr> 
<tr>
    <th>내용</th>
    <td>
      <textarea rows="5" cols="30" name="content"></textarea>
    </td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="쓰기">
      <input type="reset"  value="취소">
    </td>
</tr> 
</table>
</form>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>
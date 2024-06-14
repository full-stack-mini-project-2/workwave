<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시물 작성</title>
  </head>
  <body>
    <h1>게시물 작성</h1>
    <form action="write" method="post">
      <table>
        <tr>
          <td>제목:</td>
          <td><input type="text" name="boardTitle" required /></td>
        </tr>
        <tr>
          <td>작성자:</td>
          <td><input type="text" name="userId" required /></td>
        </tr>
        <tr>
          <td>비밀번호:</td>
          <td><input type="password" name="boardPassword" required /></td>
        </tr>
        <tr>
          <td>내용:</td>
          <td>
            <textarea name="boardContent" rows="10" cols="30" required></textarea>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <input type="submit" value="저장" />
        </td>
        </tr>
      </table>
    </form>
    <a href="list">목록으로</a>
  </body>
</html>

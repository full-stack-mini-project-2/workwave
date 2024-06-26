<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시물 작성</title>

    <!-- ck editor -->
    <script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
  </head>
  <body>
    <h1>게시물 작성</h1>
    <form action="write" method="post" enctype="multipart/form-data">
      <table>
        <tr>
          <td>제목:</td>
          <td><input type="text" name="boardTitle" required /></td>
        </tr>
        <tr>
          <td>닉네임:</td>
          <td><input type="text" name="boardNickname" required /></td>
        </tr>
        <tr>
          <td>비밀번호:</td>
          <td><input type="password" name="boardPassword" required /></td>
        </tr>
        <tr>
          <td>내용:</td>
          <td>
            <textarea
              name="boardContent"
              rows="10"
              cols="30"
              required
            ></textarea>
            <script>
              CKEDITOR.replace("boardContent", {
                filebrowserUploadUrl: "upload",
                filebrowserUploadMethod: "form",
              });
            </script>
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

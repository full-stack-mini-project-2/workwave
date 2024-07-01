<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시물 작성</title>

    <!-- CKEditor 라이브러리 -->
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    <!-- Turndown 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/turndown/dist/turndown.min.js"></script>

    <%@ include file="../include/static-head.jsp" %>
  </head>
  <body>
    
    <%@ include file="../include/header.jsp" %>

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
              id="boardContent"
              rows="10"
              cols="30"
              required
            ></textarea>
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

    <script>
      CKEDITOR.replace("boardContent", {
        filebrowserUploadUrl: "/upload", // 업로드 URL 설정
        filebrowserUploadMethod: "form",
        extraPlugins: "uploadimage", // 이미지 업로드 플러그인 추가
        removeDialogTabs: "link:upload;image:Upload", // 불필요한 탭 제거
      });
    </script>
  </body>
</html>

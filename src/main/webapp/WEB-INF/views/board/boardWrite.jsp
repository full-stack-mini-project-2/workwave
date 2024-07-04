<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>게시물 작성</title>
    <%@ include file="../include/static-head.jsp" %>

    <link rel="stylesheet" href="/assets/css/boardWrite.css" />

    <!-- CKEditor 라이브러리 -->
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
    <!-- Turndown 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/turndown/dist/turndown.min.js"></script>

    
  </head>
  <body>
    
    <%@ include file="../include/header.jsp" %>
<div class="board-write-content">
    <h1>게시물 작성</h1>
    <form action="write" method="post" enctype="multipart/form-data">
      <table>
        <tr>
          <td><input type="text" name="boardTitle" placeholder="제목" required /></td>
        </tr>
        <tr>
          <td><input type="text" name="boardNickname" placeholder="닉네임" required /></td>
        </tr>
        <tr>
          <td><input type="password" name="boardPassword" placeholder="비밀번호" required /></td>
        </tr>
        <tr>
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
  </div>

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

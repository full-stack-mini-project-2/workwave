<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게시물 수정</title>
    <script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
    <link rel="stylesheet" href="/assets/css/main.css" />
    <link rel="icon" href="/assets/img/workwave_logo.png" />
    <link rel="stylesheet" href="/assets/css/boardUpdate.css" />

    <%@ include file="../include/static-head.jsp" %>
    
  </head>
  <body>

    <%@ include file="../include/header.jsp" %>

    <div class="container">
      <h1>게시물 수정</h1>
      <form
        action="update?bno=${board.boardId}"
        method="post"
        enctype="multipart/form-data"
      >
        <input type="hidden" name="boardId" value="${board.boardId}" />
        <label for="boardTitle">제목</label>
        <h1>${board.boardTitle}</h1>
        <label for="newContent">내용</label>
        <textarea
          id="newContent"
          name="newContent"
          rows="10"
          cols="30"
          required
        >
${board.boardContent}</textarea
        >
        <script>
          CKEDITOR.replace("newContent", {
            filebrowserUploadUrl: "upload",
            filebrowserUploadMethod: "form",
          });
        </script>
        <button type="submit">수정</button>
      </form>
    </div>
  </body>
</html>

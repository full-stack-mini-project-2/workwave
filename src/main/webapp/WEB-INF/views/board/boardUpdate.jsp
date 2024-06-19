<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>게시물 수정</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f4f4f4;
      }
      .container {
        max-width: 800px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }
      h1 {
        font-size: 24px;
        margin-bottom: 10px;
      }
      form {
        display: flex;
        flex-direction: column;
      }
      label {
        font-size: 14px;
        margin-bottom: 5px;
        color: #333;
      }
      input[type="text"],
      textarea {
        font-size: 16px;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 4px;
        width: 100%;
        box-sizing: border-box;
      }
      textarea {
        height: 200px;
        resize: vertical;
      }
      button {
        padding: 10px 20px;
        font-size: 16px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
      }
      button:hover {
        background-color: #0056b3;
      }
    </style>
    <script src="https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js"></script>
  </head>
  <body>
    <div class="container">
      <h1>게시물 수정</h1>
      <form action="update?bno=${board.boardId}" method="post" enctype="multipart/form-data">
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
              >${board.boardContent}</textarea>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>게시판</title>
</head>
<body>
<h1>게시물 목록</h1>
<table>

    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
    </tr>

    <c:forEach var="board" items="${boards}">
        <tr>
            <td>${board.boardId}</td>
            <td><a href="/board/detail">${board.boardTitle}</a></td>
            <td>${board.userId}</td>
            <td>${board.formattedBoardCreatedAt}</td>
        </tr>
    </c:forEach>

</table>
<a href="/board/write">새 글 쓰기</a>
</body>
</html>

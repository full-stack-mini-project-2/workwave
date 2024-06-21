<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lunch Mate Board</title>
</head>
<body>
<h1>Lunch Mate Board</h1>
<a href="/lunchMateBoard/new">새 글 작성</a>
<table border="1">
    <thead>
        <tr>
            <th>유저 아이디</th>
            <th>제목</th>
            <th>날짜</th>
            <th>위치</th>
            <th>메뉴</th>
            <th>참여 인원</th>
            <th>상태</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="board" items="${boards}">
            <tr>
                <td><a href="/lunchMateBoard/view?userId=${board.userId}">${board.userId}</a></td>
                <td>${board.lunchPostTitle}</td>
                <td>${board.lunchDate}</td>
                <td>${board.lunchLocation}</td>
                <td>${board.lunchMenuName}</td>
                <td>${board.lunchAttendees}</td>
                <td>${board.progressStatus}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</body>
</html>

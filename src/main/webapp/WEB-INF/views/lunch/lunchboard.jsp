<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>점심 메이트 게시판</title>
    <style>
        /* 스타일은 필요에 따라 조정하세요 */
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>점심 메이트 게시판</h1>
    <table>
        <thead>
            <tr>
                <th>작성자</th>
                <th>제목</th>
                <th>날짜</th>
                <th>식당</th>
                <th>메뉴</th>
                <th>인원</th>
                <th>상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${boards}">
                <tr>
                    <td>${board.userId}</td>
                    <td>${board.lunchPostTitle}</td>
                    <td>${board.lunchDate}</td>
                    <td>${board.lunchLocation}</td>
                    <td>${board.lunchMenuName}</td>
                    <td>${board.lunchAttendees}</td>
                    <td>${board.progressStatus}</td>
                </tr>
            </c:forEach

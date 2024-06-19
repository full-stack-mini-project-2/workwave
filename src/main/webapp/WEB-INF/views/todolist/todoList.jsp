<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>To-Do List Page</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f5f5f5;
        }

        .todo-list-container {
            width: 80%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .todo-item {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f0f0f0;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .todo-item.completed {
            text-decoration: line-through;
            background-color: #e0e0e0;
        }

        .todo-item:hover {
            background-color: #e0f7fa;
        }

        .add-todo {
            margin-top: 20px;
            text-align: center;
        }

        .add-todo input[type="text"] {
            width: 60%;
            padding: 8px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            outline: none;
        }

        .add-todo button {
            padding: 8px 16px;
            margin-left: 10px;
            font-size: 1rem;
            border: none;
            background-color: #4CAF50;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .add-todo button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="todo-list-container">
    <h1>To-Do List</h1>
    <c:forEach var="todo" items="${todoListData}">
        <div class="todo-item ${todo.completed ? 'completed' : ''}">${todo.task}</div>
    </c:forEach>

    <div class="add-todo">
        <input type="text" placeholder="Add new item...">
        <button>Add</button>
    </div>
</div>
</body>
</html>
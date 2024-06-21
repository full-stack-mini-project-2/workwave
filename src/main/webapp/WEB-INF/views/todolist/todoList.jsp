<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Todo List</title>
</head>
<body>
<h1>Todo List</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Content</th>
        <th>Event Date</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="todo" items="${todoLists}">
        <tr>
            <td>${todo.todo_id}</td>
            <td>${todo.todo_content}</td>
            <td>${todo.todo_event_date}</td>
            <td>${todo.todo_status}</td>
            <td>
                <a href="/todos/${todo.todo_id}">Edit</a>
                <form action="/todos/${todo.todo_id}" method="post" style="display:inline">
                    <input type="hidden" name="_method" value="delete">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/todos/new">Add New Todo</a>
</body>
</html>
</html>
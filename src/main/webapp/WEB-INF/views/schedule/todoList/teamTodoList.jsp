<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Team To-Do List</title>
    <style>
        .completed {
            color: gray;
            text-decoration: line-through;
        }
    </style>
</head>
<body>
<h1>Team To-Do List</h1>
<ul>
    <c:forEach var="todo" items="${teamTodos}">
        <li>
            <input type="checkbox" ${todo.teamTodoStatus == 'completed' ? 'checked' : ''} onclick="toggleTeamTodoStatus(${todo.teamTodoId})">
            <span class="${todo.teamTodoStatus == 'completed' ? 'completed' : ''}">${todo.teamTodoContent}</span>
            <button onclick="editTeamTodo(${todo.teamTodoId})">Edit</button>
            <button onclick="deleteTeamTodo(${todo.teamTodoId})">Delete</button>
        </li>
    </c:forEach>
</ul>
<button onclick="addTeamTodo()">Add New Team To-Do</button>

<script>
    function toggleTeamTodoStatus(teamTodoId) {
        fetch(`/api/todos/team/${teamTodoId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({teamTodoStatus: 'completed'})
        }).then(response => {
            if (response.ok) {
                location.reload();
            }
        });
    }

    function editTeamTodo(teamTodoId) {
        let newContent = prompt("Enter new team to-do content:");
        fetch(`/api/todos/team/${teamTodoId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({teamTodoContent: newContent})
        }).then(response => {
            if (response.ok) {
                location.reload();
            }
        });
    }

    function deleteTeamTodo(teamTodoId) {
        fetch(`/api/todos/team/${teamTodoId}`, {
            method: 'DELETE'
        }).then(response => {
            if (response.ok) {
                location.reload();
            }
        });
    }

    function addTeamTodo() {
        let content = prompt("Enter new team to-do content:");
        fetch('/api/todos/team', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({teamTodoContent: content, userId: 'current_user_id', departmentId: 'current_department_id'})
        }).then(response => {
            if (response.ok) {
                location.reload();
            }
        });
    }
</script>

</body>
</html>
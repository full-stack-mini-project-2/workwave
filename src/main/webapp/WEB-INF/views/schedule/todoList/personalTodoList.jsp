<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo App</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        .app-container {
            height: 100vh;
            width: 100%;
        }
        .complete {
            text-decoration: line-through;
        }
    </style>
</head>
<body ng-controller="myController" class="app-container d-flex align-items-center justify-content-center flex-column">

<h3 class="mb-4">Todo App</h3>

<div class="input-group mb-3">
    <input ng-model="yourTask" type="text" class="form-control" placeholder="Enter a task here">
    <div class="input-group-append">
        <button class="btn btn-primary" type="button" ng-click="saveTask()">Save</button>
    </div>
    <div class="input-group-append">
        <button class="btn btn-warning" type="button" ng-click="getTask()">Get Tasks</button>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-hover table-bordered">
        <thead class="thead-dark">
        <tr>
            <th scope="col">No.</th>
            <th scope="col">Todo item</th>
            <th scope="col">Status</th>
            <th scope="col">Actions</th>
        </tr>
        </thead>
        <tbody>
        <tr ng-repeat="task in tasks" ng-class="{'table-success': task.status, 'table-light': !task.status}">
            <td>{{$index + 1}}</td>
            <td ng-class="{'complete': task.status}">{{task.task_name}}</td>
            <td>{{task.status ? 'Completed' : 'In progress'}}</td>
            <td>
                <button class="btn btn-danger btn-sm" ng-click="delete($index)">Delete</button>
                <button class="btn btn-success btn-sm" ng-click="finished($index)">Finished</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    var app = angular.module("myApp", []);

    app.controller("myController", function($scope) {
        $scope.tasks = [
            {
                "todoId": 1,
                "todoContent": "Buy office supplies",
                "todoStatus": false,
                "todoCreateAt": "2024-06-24T15:23:49",
                "todoUpdateAt": "2024-06-24T15:23:49",
                "colorIndexId": 1,
                "userId": "user1"
            },
            {
                "todoId": 2,
                "todoContent": "Schedule meeting with team",
                "todoStatus": false,
                "todoCreateAt": "2024-06-24T15:23:49",
                "todoUpdateAt": "2024-06-24T15:23:49",
                "colorIndexId": 2,
                "userId": "user1"
            }
        ];

        $scope.saveTask = function() {
            $scope.tasks.push({
                todoContent: $scope.yourTask,
                todoStatus: false,
                todoCreateAt: new Date().toISOString(),
                todoUpdateAt: new Date().toISOString(),
                colorIndexId: 1,
                userId: 'current_user_id' // replace with actual userId
            });
            $scope.yourTask = ''; // Clear input field after adding task
        };

        $scope.getTask = function() {
            // Simulated get task functionality, could be used for refreshing tasks
            // Not implemented for the sake of simplicity in this example
        };

        $scope.delete = function(index) {
            $scope.tasks.splice(index, 1);
        };

        $scope.finished = function(index) {
            $scope.tasks[index].todoStatus = true;
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>

<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <title>Personal To-Do List</title>--%>
<%--    <style>--%>
<%--        .completed {--%>
<%--            color: gray;--%>
<%--            text-decoration: line-through;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>
<%--<script>--%>
<%--    // JavaScript function to toggle the status of a to-do item--%>
<%--    function toggleTodoStatus(todoId) {--%>
<%--        fetch(`/api/todos/personal/${todoId}`, {--%>
<%--            method: 'PUT',--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/json'--%>
<%--            },--%>
<%--            body: JSON.stringify({todoStatus: 'completed'})--%>
<%--        }).then(response => {--%>
<%--            if (response.ok) {--%>
<%--                location.reload();--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--    // JavaScript function to edit a to-do item--%>
<%--    function editTodo(todoId) {--%>
<%--        let newContent = prompt("Enter new to-do content:");--%>
<%--        fetch(`/api/todos/personal/${todoId}`, {--%>
<%--            method: 'PUT',--%>
<%--            headers: {--%>
<%--                'Content-Type': 'application/json'--%>
<%--            },--%>
<%--            body: JSON.stringify({todoContent: newContent})--%>
<%--        }).then(response => {--%>
<%--            if (response.ok) {--%>
<%--                location.reload();--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--    // JavaScript function to delete a to-do item--%>
<%--    function deleteTodo(todoId) {--%>
<%--        fetch(`/api/todos/personal/${todoId}`, {--%>
<%--            method: 'DELETE'--%>
<%--        }).then(response => {--%>
<%--            if (response.ok) {--%>
<%--                location.reload();--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--    // JavaScript function to add a new to-do item--%>
<%--    function addTodo() {--%>
<%--        let content = prompt("Enter new to-do content:");--%>
<%--        if (content) {--%>
<%--            fetch('/api/todos/personal', {--%>
<%--                method: 'POST',--%>
<%--                headers: {--%>
<%--                    'Content-Type': 'application/json'--%>
<%--                },--%>
<%--                body: JSON.stringify({--%>
<%--                    todoContent: content,--%>
<%--                    userId: 'current_user_id',  // replace 'current_user_id' with actual userId--%>
<%--                    todoStatus: 'inprogress',--%>
<%--                    colorIndexId: 1,--%>
<%--                    todoCreateAt: new Date().toISOString(),--%>
<%--                    todoUpdateAt: new Date().toISOString()--%>
<%--                })--%>
<%--            }).then(response => {--%>
<%--                if (response.ok) {--%>
<%--                    location.reload();--%>
<%--                } else {--%>
<%--                    response.json().then(data => {--%>
<%--                        alert('Error: ' + data.message);--%>
<%--                    });--%>
<%--                }--%>
<%--            }).catch(error => {--%>
<%--                console.error('Error:', error);--%>
<%--            });--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--<body>--%>
<%--<h1>Personal To-Do List</h1>--%>
<%--<button onclick="addTodo()">Add New To-Do</button>--%>
<%--<ul>--%>
<%--    <c:forEach items="${todos}" var="todo">--%>
<%--        <li>--%>
<%--            <form action="<c:url value='/api/todos/personal/${todo.todoId}' />" method="post">--%>
<%--                <input type="checkbox" onclick="this.form.submit()" ${todo.todoStatus == 'completed' ? 'checked' : ''} />--%>
<%--                <input type="hidden" name="_method" value="put" />--%>
<%--                <input type="hidden" name="userId" value="${userId}" />--%>
<%--                <input type="hidden" name="todoId" value="${todo.todoId}" />--%>
<%--                <input type="hidden" name="todoContent" value="${todo.todoContent}" />--%>
<%--                <input type="hidden" name="todoStatus" value="${todo.todoStatus == 'completed' ? 'pending' : 'completed'}" />--%>
<%--                <span style="text-decoration: ${todo.todoStatus == 'completed' ? 'line-through' : 'none'}">${todo.todoContent}</span>--%>
<%--                <a href="<c:url value='/api/todos/personal/${todo.todoId}?userId=${userId}' />" onclick="event.preventDefault(); if(confirm('Are you sure?')) { this.parentElement.submit(); }">Delete</a>--%>
<%--            </form>--%>
<%--        </li>--%>
<%--    </c:forEach>--%>
<%--</ul>--%>



<%--</body>--%>
<%--</html>--%>

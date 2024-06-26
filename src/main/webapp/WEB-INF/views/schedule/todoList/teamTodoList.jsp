<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" ng-app="myApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Team Todo List</title>
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

<h3 class="mb-4">Team Todo List</h3>

<div class="input-group mb-3">
    <input ng-model="yourTask" type="text" class="form-control" placeholder="Enter a task here">
    <div class="input-group-append">
        <button class="btn btn-primary" type="button" ng-click="saveTask()">Save</button>
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
        <c:forEach items="${teamTodos}" var="task">
            <tr>
                <td>${task.teamTodoId}</td>
                <td>${task.teamTodoContent}</td>
                <td>${task.teamTodoStatus ? 'Completed' : 'In progress'}</td>
                <td>
                    <button class="btn btn-danger btn-sm" ng-click="deleteTask(task.teamTodoId)">Delete</button>
                    <button class="btn btn-success btn-sm" ng-click="updateTask(task)">Update</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    var app = angular.module("myApp", []);

    app.controller("myController", function($scope, $http) {
        // 초기화: 팀 투두리스트 데이터 가져오기
        $http.get('/api/todos/team/${departmentId}')
            .then(function(response) {
                $scope.teamTodos = response.data;
            });

        $scope.saveTask = function() {
            var newTask = {
                teamTodoContent: $scope.yourTask,
                teamTodoStatus: false,
                // timestamp 등록은 서버에서 처리
            };

            // 서버에 새로운 팀 투두리스트 항목 추가
            $http.post('/api/todos/team', newTask)
                .then(function(response) {
                    // 추가된 데이터를 화면에 반영
                    $scope.teamTodos.push(response.data);
                });

            $scope.yourTask = ''; // 입력 필드 초기화
        };

        $scope.deleteTask = function(teamTodoId) {
            // 서버에서 팀 투두리스트 항목 삭제
            $http.delete('/api/todos/team/' + teamTodoId)
                .then(function() {
                    // 삭제 후 화면에서도 항목 제거
                    var index = $scope.teamTodos.findIndex(function(task) {
                        return task.teamTodoId === teamTodoId;
                    });
                    $scope.teamTodos.splice(index, 1);
                });
        };

        $scope.updateTask = function(task) {
            // 업데이트 로직 구현: 필요시 화면에 맞게 구현
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>

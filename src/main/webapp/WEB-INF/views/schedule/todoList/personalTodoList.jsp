<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" ng-app="myAppPersonal">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Todo List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <style>
        .app-container {
            height: 100vh;
            width: 100%;
        }
        .complete {
            text-decoration: line-through;
            color: gray;
        }
        .color-dot {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 5px;
        }
    </style>
</head>
<body ng-controller="myController" class="app-container d-flex align-items-center justify-content-center flex-column">

<h3 class="mb-4">Personal Todo List</h3>

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
        <tr ng-repeat="task in tasks" ng-class="{'table-success': task.todoStatus, 'table-light': !task.todoStatus}">
            <td>{{$index + 1}}</td>
            <td>
                <!-- 동그라미 표시 -->
<%--                <span ng-if="colorIndexMap[task.colorIndexId]" class="color-dot" ng-style="{'background-color': colorIndexMap[task.colorIndexId]}"></span>--%>
                <span ng-class="{'complete': task.todoStatus}">{{task.todoContent}}</span>
            </td>
            <td>
                <input type="checkbox" ng-model="task.todoStatus">
            </td>
            <td>
                <button ng-click="edit(task)">Edit</button>
                <button class="btn btn-danger btn-sm" ng-click="delete($index)">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    var app = angular.module("myAppPersonal", []);

    app.controller("myController", function($scope, $http) {
        // 초기화 함수: 서버에서 개인 투두리스트 가져오기
        function init() {
            var userId = '<%= request.getAttribute("userId") %>'; // userId 가져오기

            $http.get('/api/todos/personal/' + userId)
                .then(function(response) {
                    $scope.tasks = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching tasks:', error);
                });
        }

        // colorIndexMap 데이터를 JSP에서 전달받아 AngularJS에서 사용
        <%--$scope.colorIndexMap = <%= new org.json.JSONObject((Map)request.getAttribute("colorIndexMap")).toString() %>;--%>

        init(); // 페이지 로딩 시 초기화 함수 호출

        // 투두리스트 저장 함수
        $scope.saveTask = function() {
            var newTask = {
                todoContent: $scope.yourTask,
                todoStatus: false,
                userId: '<%= request.getAttribute("userId") %>'
            };

            $http.post('/api/todos/personal', newTask)
                .then(function(response) {
                    $scope.tasks.push(response.data); // 추가된 투두리스트를 배열에 추가
                    $scope.yourTask = ''; // 입력 필드 초기화
                })
                .catch(function(error) {
                    console.error('Error saving task:', error);
                });
        };

        // 투두리스트 삭제 함수
        $scope.delete = function(index) {
            var todoId = $scope.tasks[index].todoId;

            $http.delete('/api/todos/personal/' + todoId)
                .then(function(response) {
                    $scope.tasks.splice(index, 1); // 배열에서 삭제
                })
                .catch(function(error) {
                    console.error('Error deleting task:', error);
                });
        };

        // 수정 상태로 전환하는 함수
        $scope.edit = function(task) {
            task.editing = true;
            $scope.editingTask = angular.copy(task); // 복사본을 수정 폼에 표시
        };

        // 수정 취소 함수
        $scope.cancelEdit = function(task) {
            task.editing = false;
            $scope.editingTask = null; // 수정 상태 초기화
        };

        // 업데이트 함수
        $scope.update = function(task) {
            $http.put('/api/todos/personal/' + task.todoId, task)
                .then(function(response) {
                    var updatedTask = response.data;
                    // 클라이언트에서 tasks 배열을 업데이트
                    for (var i = 0; i < $scope.tasks.length; i++) {
                        if ($scope.tasks[i].todoId === updatedTask.todoId) {
                            $scope.tasks[i] = updatedTask;
                            break;
                        }
                    }
                    task.editing = false; // 수정 상태 초기화
                    $scope.editingTask = null;
                })
                .catch(function(error) {
                    console.error('Error updating task:', error);
                });
        };

        // Enter 키를 눌렀을 때 업데이트 수행
        $scope.handleKeyPress = function(event, task) {
            if (event.keyCode === 13) { // Enter 키 코드는 13입니다.
                $scope.update(task);
            }
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>


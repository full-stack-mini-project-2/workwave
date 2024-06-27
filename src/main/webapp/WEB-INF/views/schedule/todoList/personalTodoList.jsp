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
<body ng-controller="myPersonalController" class="app-container d-flex align-items-center justify-content-center flex-column">

<h3 class="mb-4">Personal Todo List</h3>

<div class="input-group mb-3">
    <input ng-model="yourPersonalTask" type="text" class="form-control" placeholder="Enter a task here">
    <div class="input-group-append">
        <button class="btn btn-primary" type="button" ng-click="savePersonalTask()">Save</button>
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
        <tr ng-repeat="personalTask in personalTasks" ng-class="{'table-success': personalTask.todoStatus, 'table-light': !personalTask.todoStatus}">
            <td>{{$index + 1}}</td>
            <td>
                <!-- 동그라미 표시 -->
                <span class="color-dot" ng-style="{'background-color': personalColorIndexMap[personalTask.colorIndexId]}"></span>
                <span ng-class="{'complete': personalTask.todoStatus}">{{personalTask.todoContent}}</span>
            </td>
            <td>
                <input type="checkbox" ng-model="personalTask.todoStatus">
            </td>
            <td>
                <button ng-click="editPersonalTask(personalTask)">Edit</button>
                <button class="btn btn-danger btn-sm" ng-click="deletePersonalTask($index)">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    var appPersonal = angular.module("myAppPersonal", []);

    appPersonal.controller("myPersonalController", function($scope, $http) {
        // 초기화 함수: 서버에서 개인 투두리스트 가져오기
        function initPersonal() {
            var userId = '<%= request.getAttribute("userId") %>'; // userId 가져오기

            $http.get('/api/todos/personal/' + userId)
                .then(function(response) {
                    $scope.personalTasks = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching personal tasks:', error);
                });
        }

        initPersonal(); // 페이지 로딩 시 초기화 함수 호출

        // 투두리스트 저장 함수
        $scope.savePersonalTask = function() {
            var newPersonalTask = {
                todoContent: $scope.yourPersonalTask,
                todoStatus: false,
                userId: '<%= request.getAttribute("userId") %>'
            };

            $http.post('/api/todos/personal', newPersonalTask)
                .then(function(response) {
                    $scope.personalTasks.push(response.data); // 추가된 투두리스트를 배열에 추가
                    $scope.yourPersonalTask = ''; // 입력 필드 초기화
                })
                .catch(function(error) {
                    console.error('Error saving personal task:', error);
                });
        };

        // 투두리스트 삭제 함수
        $scope.deletePersonalTask = function(index) {
            var personalTodoId = $scope.personalTasks[index].todoId;

            $http.delete('/api/todos/personal/' + personalTodoId)
                .then(function(response) {
                    $scope.personalTasks.splice(index, 1); // 배열에서 삭제
                })
                .catch(function(error) {
                    console.error('Error deleting personal task:', error);
                });
        };

        // 수정 상태로 전환하는 함수
        $scope.editPersonalTask = function(personalTask) {
            personalTask.editing = true;
            $scope.editingPersonalTask = angular.copy(personalTask); // 복사본을 수정 폼에 표시
        };

        // 수정 취소 함수
        $scope.cancelEditPersonalTask = function(personalTask) {
            personalTask.editing = false;
            $scope.editingPersonalTask = null; // 수정 상태 초기화
        };

        // 업데이트 함수
        $scope.updatePersonalTask = function(personalTask) {
            $http.put('/api/todos/personal/' + personalTask.todoId, personalTask)
                .then(function(response) {
                    var updatedPersonalTask = response.data;
                    // 클라이언트에서 personalTasks 배열을 업데이트
                    for (var i = 0; i < $scope.personalTasks.length; i++) {
                        if ($scope.personalTasks[i].todoId === updatedPersonalTask.todoId) {
                            $scope.personalTasks[i] = updatedPersonalTask;
                            break;
                        }
                    }
                    personalTask.editing = false; // 수정 상태 초기화
                    $scope.editingPersonalTask = null;
                })
                .catch(function(error) {
                    console.error('Error updating personal task:', error);
                });
        };

        // Enter 키를 눌렀을 때 업데이트 수행
        $scope.handleKeyPressPersonalTask = function(event, personalTask) {
            if (event.keyCode === 13) { // Enter 키 코드는 13입니다.
                $scope.updatePersonalTask(personalTask);
            }
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>

<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" ng-app="myAppTeam">
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
<body ng-controller="myTeamController" class="app-container d-flex align-items-center justify-content-center flex-column">

<h3 class="mb-4">Team Todo List</h3>

<div class="input-group mb-3">
    <input ng-model="yourTeamTask" type="text" class="form-control" placeholder="Enter a task here">
    <div class="input-group-append">
        <button class="btn btn-primary" type="button" ng-click="saveTeamTask()">Save</button>
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
        <tr ng-repeat="teamTask in teamTasks track by $index" ng-class="{'table-success': teamTask.teamTodoStatus, 'table-light': !teamTask.teamTodoStatus}">
            <td>{{$index + 1}}</td>
            <td>
                <!-- 동그라미 표시 -->
<%--                <span class="color-dot" ng-style="{'background-color': teamColorIndexMap[teamTask.colorIndexId]}"></span>--%>
                <span ng-class="{'complete': teamTask.teamTodoStatus}">{{teamTask.teamTodoContent}}</span>
            </td>
            <td>
                <input type="checkbox" ng-model="teamTask.teamTodoStatus">
            </td>
            <td>
                <button ng-click="editTeamTask(teamTask)">Edit</button>
                <button class="btn btn-danger btn-sm" ng-click="deleteTeamTask($index)">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    var appTeam = angular.module("myAppTeam", []);

    appTeam.controller("myTeamController", function($scope, $http) {
        // 초기화 함수: 서버에서 팀 투두리스트 가져오기
        function initTeam() {
            var departmentId = '<%= request.getAttribute("departmentId") %>'; // departmentId 가져오기

            $http.get('/api/todos/team/aTeamTodos/' + departmentId)
                .then(function(response) {
                    $scope.teamTasks = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching team tasks:', error);
                });
        }

        initTeam(); // 페이지 로딩 시 초기화 함수 호출

        // 투두리스트 저장 함수
        $scope.saveTeamTask = function() {
            var newTeamTask = {
                teamTodoContent: $scope.yourTeamTask,
                teamTodoStatus: false,
                departmentId: '<%= request.getAttribute("departmentId") %>'
            };

            $http.post('/api/todos/team', newTeamTask)
                .then(function(response) {
                    $scope.teamTasks.push(response.data); // 추가된 팀 투두리스트를 배열에 추가
                    $scope.yourTeamTask = ''; // 입력 필드 초기화
                })
                .catch(function(error) {
                    console.error('Error saving team task:', error);
                });
        };

        // 투두리스트 삭제 함수
        $scope.deleteTeamTask = function(index) {
            var teamTodoId = $scope.teamTasks[index].teamTodoId;

            $http.delete('/api/todos/team/' + teamTodoId)
                .then(function(response) {
                    $scope.teamTasks.splice(index, 1); // 배열에서 삭제
                })
                .catch(function(error) {
                    console.error('Error deleting team task:', error);
                });
        };

        // 수정 상태로 전환하는 함수
        $scope.editTeamTask = function(teamTask) {
            teamTask.editing = true;
            $scope.editingTeamTask = angular.copy(teamTask); // 복사본을 수정 폼에 표시
        };

        // 수정 취소 함수
        $scope.cancelEditTeamTask = function(teamTask) {
            teamTask.editing = false;
            $scope.editingTeamTask = null; // 수정 상태 초기화
        };

        // 업데이트 함수
        $scope.updateTeamTask = function(teamTask) {
            $http.put('/api/todos/team/' + teamTask.teamTodoId, teamTask)
                .then(function(response) {
                    var updatedTeamTask = response.data;
                    // 클라이언트에서 teamTasks 배열을 업데이트
                    for (var i = 0; i < $scope.teamTasks.length; i++) {
                        if ($scope.teamTasks[i].teamTodoId === updatedTeamTask.teamTodoId) {
                            $scope.teamTasks[i] = updatedTeamTask;
                            break;
                        }
                    }
                    teamTask.editing = false; // 수정 상태 초기화
                    $scope.editingTeamTask = null;
                })
                .catch(function(error) {
                    console.error('Error updating team task:', error);
                });
        };

        // Enter 키를 눌렀을 때 업데이트 수행
        $scope.handleKeyPressTeamTask = function(event, teamTask) {
            if (event.keyCode === 13) { // Enter 키 코드는 13입니다.
                $scope.updateTeamTask(teamTask);
            }
        };
    });
</script>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>

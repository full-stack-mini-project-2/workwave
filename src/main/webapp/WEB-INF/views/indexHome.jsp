<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" ng-app="myTodo">

<head>
    <title>Work-Wave</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/indexHome.css">

    <style>
        /* 추가적인 스타일이 필요하다면 여기에 추가하세요 */
        .calendar-container {
            position: relative;
            width: 100%;
            height: 16.6%;
            overflow: hidden;
        }
        .calendar {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: 1px solid #ccc;
            display: block; /* 초기에는 보이도록 설정 */
        }
        .calendar.minimized {
            display: none; /* 최소화 상태일 때는 숨김 */
        }
        .toggle-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            cursor: pointer;
        }
        .calendar-icon {
            position: fixed;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
            cursor: pointer;
            z-index: 1000; /* 다른 요소 위에 표시될 수 있도록 높은 z-index 설정 */
            display: none; /* 초기에는 숨김 */
        }
        /*투두리스트 스타일*/
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

    <link rel="icon" href="/assets/img/workwave_logo.png" />
</head>

<body ng-controller="myPersonalController" class="app-container d-flex align-items-center justify-content-center flex-column">

<div class="clock-container">
    <div class="clock" id="clock">00:00</div>
</div>

<div class="right-top">
    <a href="/myCalendar/viewTeamEvent" class="right-box">TEAM CALENDAR</a>
    <a href="/myCalendar/viewMyEvent" class="right-box">PERSONAL CALENDAR</a>
</div>

<div class="right-bottom">
    <a href="/viewTodo/personal" class="right-box">PERSONAL TODOLIST</a>
    <a href="/viewTodo/team" class="right-box">TEAM TODOLIST</a>
</div>

<div class="left-top">
    <a href="/traffic-map" class="right-box">TRAFFIC INFO</a>
</div>

<div class="left-bottom">
    <a href="/board/list" class="right-box">ANONYMOUS BOARD</a>
    <a href="/lunchMateBoard" class="right-box">LUNCH MENU</a>
</div>



<%--개인 투두리스트 --%>
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
        <tr ng-repeat="personalTask in personalTasks track by $index" ng-class="{'table-success': personalTask.todoStatus === 'true', 'table-light': personalTask.todoStatus === 'false'}">
            <td>{{$index + 1}}</td>
            <td ng-click="editPersonalTask(personalTask)">
                <!-- 동그라미 표시 -->
                <%--                <span class="color-dot" ng-style="{'background-color': personalColorIndexMap[personalTask.colorIndexId]}"></span>--%>
                <span ng-show="!personalTask.editing" ng-class="{'complete': personalTask.todoStatus === 'true'}">{{personalTask.todoContent}}</span>
                <input ng-show="personalTask.editing" type="text" ng-model="personalTask.todoContent" ng-blur="updatePersonalTask(personalTask)" ng-keypress="handleKeyPressPersonalTask($event, personalTask)">
            </td>
            <td>
                <input type="checkbox" ng-model="personalTask.todoStatus" ng-true-value="'true'" ng-false-value="'false'" ng-change="updatePersonalTask(personalTask)">
            </td>
            <td>
                <button class="btn btn-danger btn-sm" ng-click="deletePersonalTask($index)">Delete</button>
            </td>
        </tr>
        </tbody>
    </table>
</div>



<%--로그인 섹션 --%>
<div class="login">
    <c:choose>
<%--        부서이름 어떻게 갖고오지?--%>
        <c:when test="${not empty dlist.departmentName}">
            <div class="user-info">TEAM_${login.departmentName}</div>
        </c:when>
        <c:when test="${not empty login.nickName}">
            <div class="user-info">${login.nickName}님 환영해요!</div>
            <button onclick="location.href='/member/logout'">LOGOUT</button>
        </c:when>
        <c:otherwise>
            <div class="user-info">로그인이 필요한 서비스입니다.</div>
            <button onclick="location.href='/login'">Login</button>
        </c:otherwise>
    </c:choose>
</div>

<!-- 달력 컨테이너 -->
<div class="calendar-container">
    <div class="calendar" id="personalCalendar">
        <iframe src="/myCalendar/viewMyEvent" style="width:100%; height:100%; border:none;"></iframe>
        <i class="fas fa-window-minimize toggle-btn" onclick="toggleCalendar('personalCalendar')"></i>
    </div>
    <div class="calendar" id="teamCalendar">
        <iframe src="/myCalendar/viewTeamEvent" style="width:100%; height:100%; border:none;"></iframe>
        <i class="fas fa-window-minimize toggle-btn" onclick="minimizeCalendar('teamCalendar')"></i>
    </div>
</div>



<!-- 최소화된 상태에서 복구할 달력 아이콘 -->
<i class="fas fa-calendar calendar-icon" onclick="restoreMinimizedCalendars()"></i>

<script>
    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        document.getElementById('clock').textContent = `\${hours}:\${minutes}`;
    }

    function toggleCalendar(calendarId) {
        // 모든 달력을 보이지 않는 상태로 설정
        const calendars = document.querySelectorAll('.calendar');
        calendars.forEach(calendar => {
            calendar.style.display = 'none';
        });

        // 선택한 달력만 보이도록 설정
        const selectedCalendar = document.getElementById(calendarId);
        selectedCalendar.style.display = 'block';

        // 최소화된 상태의 달력 아이콘 보이기
        const calendarIcon = document.querySelector('.calendar-icon');
        calendarIcon.style.display = 'block';
    }

    function minimizeCalendar(calendarId) {
        const calendar = document.getElementById(calendarId);
        calendar.classList.add('minimized');
    }

    function restoreMinimizedCalendars() {
        // 모든 최소화된 달력을 복구
        const minimizedCalendars = document.querySelectorAll('.calendar.minimized');
        minimizedCalendars.forEach(calendar => {
            calendar.classList.remove('minimized');
        });

        // 최소화된 상태의 달력 아이콘 숨기기
        const calendarIcon = document.querySelector('.calendar-icon');
        calendarIcon.style.display = 'none';
    }

    // 페이지 로드 후 실행되는 함수
    window.onload = function() {
        // 초기에 개인 캘린더를 보이도록 설정
        toggleCalendar('personalCalendar');

        // 시계 업데이트 함수를 1초마다 실행하여 시간을 표시
        setInterval(updateClock, 1000);
        updateClock(); // 페이지 로드 후 최초 시간 업데이트를 위해 호출
    };
</script>

<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>
<script>
    //개인 투두리스트 스크립트

    var appPersonal = angular.module("myTodo", []);

    appPersonal.controller("myPersonalController", function($scope, $http) {
        // 초기화 함수
        function initPersonal() {
            $http.get('/api/todos/user/info')
                .then(function(response) {
                    var userInfo = response.data;
                    $scope.userId = userInfo.userId;
                    fetchPersonalTasks();
                })
                .catch(function(error) {
                    console.error('Error fetching user info:', error);
                });
        }

        // 개인 투두리스트 가져오기
        function fetchPersonalTasks() {
            $http.get('/api/todos/personal')
                .then(function(response) {
                    $scope.personalTasks = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching personal tasks:', error);
                });
        }

        // 초기화 함수 호출
        initPersonal();



        // 투두리스트 저장 함수
        $scope.savePersonalTask = function() {
            var newPersonalTask = {
                todoContent: $scope.yourPersonalTask,
                todoStatus: 'false', // 문자열로 받아야 함
                userId: $scope.userId
            };

            $http.post('/api/todos/personal', newPersonalTask)
                .then(function(response) {
                    var savedMyTask = response.data;
                    if (savedMyTask && savedMyTask.todoId) {
                        $scope.personalTasks.push(savedMyTask);
                    } else {
                        newPersonalTask.todoId = 'temporary_' + (new Date()).getTime();
                        $scope.personalTasks.push(newPersonalTask);
                    }
                    $scope.yourPersonalTask = ''; // 입력 필드 초기화
                })
                .catch(function(error) {
                    console.error('Error saving personal task:', error);
                });
            initPersonal();
        };

        //투두리스트 삭제
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
        };

        // 업데이트 함수
        $scope.updatePersonalTask = function(personalTask) {
            if (!personalTask.todoId) return; // 아이디 없을 때 업데이트 방지

            var updatedMyTask = angular.copy(personalTask);
            updatedMyTask.todoStatus = personalTask.todoStatus.toString();

            $http.put('/api/todos/personal/' + personalTask.todoId, updatedMyTask)
                .then(function(response) {
                    personalTask.editing = false; // 수정 상태 초기화
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


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en" ng-app="myTodo">

<head>
    <title>Work-Wave</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/indexHome.css">
    <link rel="icon" href="/assets/img/workwave_logo.png" />
    <style>
        .calendar-container {
            position: relative;
            width: 100%;
            height: 16.6%;
            overflow: hidden;
            top: 30px;
            align-content: center;
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
            top: 350px;
            left: 98%;
            transform: translateX(-50%);
            cursor: pointer;
            z-index: 1000; /* 다른 요소 위에 표시될 수 있도록 높은 z-index 설정 */
            display: none; /* 초기에는 숨김 */
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
        .personal-todolist-Box {
            width: 150px;
            max-height: 300px;
            border-radius: 10px;
            border: black;
            bottom: 5%;
            left: 75%;
            position: absolute;
        }

        .team-todolist-Box {
            width: 150px;
            max-height: 300px;
            border-radius: 10px;
            border: black;
            bottom: 5%;
            left: 50%;
            position: absolute;

        }
    </style>
</head>

<body>

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

<%-- 개인 투두리스트 --%>
<div ng-controller="myPersonalController" class="personal-todolist-Box app-container d-flex align-items-center justify-content-center flex-column">
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
</div>

<%-- 팀 투두리스트 --%>
<div ng-controller="myTeamController" class="team-todolist-Box app-container d-flex align-items-center justify-content-center flex-column">
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
            <tr ng-repeat="teamTask in teamTasks track by $index" ng-class="{'table-success': teamTask.teamTodoStatus === 'true', 'table-light': teamTask.teamTodoStatus === 'false'}">
                <td>{{$index + 1}}</td>
                <td ng-click="editTeamTask(teamTask)">
                    <span ng-show="!teamTask.editing" ng-class="{'complete': teamTask.teamTodoStatus === 'true'}">{{teamTask.teamTodoContent}}</span>
                    <input ng-show="teamTask.editing" type="text" ng-model="teamTask.teamTodoContent" ng-blur="updateTeamTask(teamTask)" ng-keypress="handleKeyPressTeamTask($event, teamTask)">
                </td>
                <td>
                    <input type="checkbox" ng-model="teamTask.teamTodoStatus" ng-true-value="'true'" ng-false-value="'false'" ng-change="updateTeamTask(teamTask)">
                </td>
                <td>
                    <button class="btn btn-danger btn-sm" ng-click="deleteTeamTask($index)">Delete</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<%-- 로그인 섹션 --%>
<div class="login">
    <c:choose>
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

<%-- 달력 컨테이너 --%>
<div class="calendar-container">
    <div class="calendar" id="personalCalendar">
        <iframe src="/myCalendar/viewMyEvent" style="width: 100%; height: 100%; border: none;"></iframe>
        <button class="toggle-btn" id="toggleBtn"><i class="fas fa-chevron-up"></i></button>
    </div>
    <div class="calendar-icon" id="calendarIcon">
        <i class="fas fa-calendar-alt"></i>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.8.2/angular.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    var app = angular.module('myTodo', []);

    app.controller('myPersonalController', ['$scope', '$http', function($scope, $http) {
        $scope.personalTasks = [];
        $scope.yourPersonalTask = '';

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

        $scope.savePersonalTask = function() {
            if ($scope.yourPersonalTask.trim() !== '') {
                var newPersonalTask = {
                    todoContent: $scope.yourPersonalTask,
                    todoStatus: 'false', // 문자열로 받아야 함
                    userId: $scope.userId
                };

                $http.post('/api/todos/personal', newPersonalTask)
                    .then(function (response) {
                        var savedMyTask = response.data;
                        if (savedMyTask && savedMyTask.todoId) {
                            $scope.personalTasks.push(savedMyTask);
                        } else {
                            newPersonalTask.todoId = 'temporary_' + (new Date()).getTime();
                            $scope.personalTasks.push(newPersonalTask);
                        }
                        $scope.yourPersonalTask = ''; // 입력 필드 초기화
                    })
                    .catch(function (error) {
                        console.error('Error saving personal task:', error);
                    });
                initPersonal();
            };
        };
            //수정 상태로 전환하는 함수
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

        // enter 키를 누르면 업데이트 수행
        $scope.handleKeyPressPersonalTask = function(event, personalTask) {
            if (event.keyCode === 13) { // Enter 키 코드는 13입니다.
                $scope.updatePersonalTask(personalTask);
            }
        };

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
    }]);

    app.controller('myTeamController', ['$scope', '$http', function($scope, $http) {
        $scope.teamTasks = [];
        $scope.yourTeamTask = '';

        // 초기화 함수: 서버에서 팀 정보 및 투두리스트 가져오기
        function initTeam() {
            $http.get('/api/todos/user/info')
                .then(function(response) {
                    var userInfo = response.data;
                    $scope.userId = userInfo.userId;
                    $scope.departmentId = userInfo.departmentId;
                    fetchTeamTasks(); // 투두리스트 가져오기 호출
                })
                .catch(function(error) {
                    console.error('Error fetching team info:', error);
                });
        }

        // 팀 투두리스트 가져오기
        function fetchTeamTasks() {
            $http.get('/api/todos/team/aTeamTodos')
                .then(function(response) {
                    $scope.teamTasks = response.data;
                })
                .catch(function(error) {
                    console.error('Error fetching team tasks:', error);
                });
        }
        // 페이지 로딩 시 초기화 함수 호출
        initTeam();
        $scope.saveTeamTask = function() {
            if ($scope.yourTeamTask.trim() !== '') {
                var newTeamTask = {
                    teamTodoContent: $scope.yourTeamTask,
                    teamTodoStatus: 'false', // 기본값을 문자열 'false'로 설정
                    departmentId: $scope.departmentId,
                    userId: $scope.userId
                };
            }
            $http.post('/api/todos/team/aTeamTodos', newTeamTask)
                .then(function(response) {
                    var savedTask = response.data;
                    if (savedTask && savedTask.teamTodoId) {
                        $scope.teamTasks.push(savedTask); // 서버에서 반환된 데이터를 배열에 추가
                    } else {
                        newTeamTask.teamTodoId = 'temporary_' + (new Date()).getTime();
                        $scope.teamTasks.push(newTeamTask); // 임시로 추가
                    }
                    $scope.yourTeamTask = ''; // 입력 필드 초기화
                })
                .catch(function(error) {
                    console.error('팀 투두를 저장하는 중 오류 발생:', error);
                });
            fetchTeamTasks();
            initTeam();
        };

        //팀 테스크 수정 상태로 전환하는 함수
        $scope.editTeamTask = function(teamTask) {
            teamTask.editing = true;
        };

        // 팀 테스크 수정사항 업데이트 함수
        $scope.updateTeamTask = function(teamTask) {
            if (!teamTask.teamTodoId) return; // teamTodoId가 없으면 업데이트하지 않음

            var updatedTask = angular.copy(teamTask);
            updatedTask.teamTodoStatus = teamTask.teamTodoStatus.toString(); // 상태를 문자열로 변환

            $http.put('/api/todos/team/' + teamTask.teamTodoId, updatedTask)
                .then(function(response) {
                    teamTask.editing = false; // 수정 상태 초기화
                })
                .catch(function(error) {
                    console.error('Error updating team task:', error);
                });
        };

        // Enter 키를 눌렀을 때 업데이트 수행
        $scope.handleKeyPressTeamTask = function(event, teamTask) {

            if (event.keyCode === 13) { // Enter 키 코드는 13
                $scope.updateTeamTask(teamTask);
            }
        };

        // 팀 투두리스트 삭제 함수
        $scope.deleteTeamTask = function(index) {
            var teamTodoId = $scope.teamTasks[index].teamTodoId;

            $http.delete('/api/todos/team/' + teamTodoId)
                .then(function(response) {
                    $scope.teamTasks.splice(index, 1); // 배열에서 삭제
                })
                .catch(function(error) {
                    console.error('Error deleting team task:', error);
                });
            fetchTeamTasks();
            initTeam();
        };
    }]);
    // 팀 투두리스트 함수 끝
    $(document).ready(function() {
        $('#toggleBtn').click(function() {
            $('#personalCalendar').toggleClass('minimized');
            $('#calendarIcon').toggle();
        });

        $('#calendarIcon').click(function() {
            $('#personalCalendar').toggleClass('minimized');
            $('#calendarIcon').toggle();
        });
    });

    function updateClock() {
        var now = new Date();
        var hours = String(now.getHours()).padStart(2, '0');
        var minutes = String(now.getMinutes()).padStart(2, '0');
        var timeString = hours + ':' + minutes;
        document.getElementById('clock').textContent = timeString;
    }


    setInterval(updateClock, 1000);
    updateClock();
</script>
</body>
</html>





<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--<!DOCTYPE html>--%>
<%--<html lang="en" ng-app="myTodo">--%>

<%--<head>--%>
<%--    <title>Work-Wave</title>--%>
<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />--%>
<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">--%>
<%--    <link rel="stylesheet" href="/assets/css/indexHome.css">--%>
<%--    <link rel="icon" href="/assets/img/workwave_logo.png" />--%>
<%--    <style>--%>
<%--        .calendar-container {--%>
<%--            position: relative;--%>
<%--            width: 100%;--%>
<%--            height: 16.6%;--%>
<%--            overflow: hidden;--%>
<%--        }--%>
<%--        .calendar {--%>
<%--            position: absolute;--%>
<%--            top: 0;--%>
<%--            left: 0;--%>
<%--            width: 100%;--%>
<%--            height: 100%;--%>
<%--            border: 1px solid #ccc;--%>
<%--            display: block; /* 초기에는 보이도록 설정 */--%>
<%--        }--%>
<%--        .calendar.minimized {--%>
<%--            display: none; /* 최소화 상태일 때는 숨김 */--%>
<%--        }--%>
<%--        .toggle-btn {--%>
<%--            position: absolute;--%>
<%--            top: 5px;--%>
<%--            right: 5px;--%>
<%--            cursor: pointer;--%>
<%--        }--%>
<%--        .calendar-icon {--%>
<%--            position: fixed;--%>
<%--            top: 50px;--%>
<%--            left: 50%;--%>
<%--            transform: translateX(-50%);--%>
<%--            cursor: pointer;--%>
<%--            z-index: 1000; /* 다른 요소 위에 표시될 수 있도록 높은 z-index 설정 */--%>
<%--            display: none; /* 초기에는 숨김 */--%>
<%--        }--%>

<%--        /*투두리스트 스타일*/--%>
<%--        .app-container {--%>
<%--            height: 100vh;--%>
<%--            width: 100%;--%>
<%--        }--%>
<%--        .complete {--%>
<%--            text-decoration: line-through;--%>
<%--            color: gray;--%>
<%--        }--%>
<%--        .color-dot {--%>
<%--            display: inline-block;--%>
<%--            width: 10px;--%>
<%--            height: 10px;--%>
<%--            border-radius: 50%;--%>
<%--            margin-right: 5px;--%>
<%--        }--%>
<%--    </style>--%>
<%--</head>--%>

<%--<body>--%>

<%--<div class="clock-container">--%>
<%--    <div class="clock" id="clock">00:00</div>--%>
<%--</div>--%>

<%--<div class="right-top">--%>
<%--    <a href="/myCalendar/viewTeamEvent" class="right-box">TEAM CALENDAR</a>--%>
<%--    <a href="/myCalendar/viewMyEvent" class="right-box">PERSONAL CALENDAR</a>--%>
<%--</div>--%>

<%--<div class="right-bottom">--%>
<%--    <a href="/viewTodo/personal" class="right-box">PERSONAL TODOLIST</a>--%>
<%--    <a href="/viewTodo/team" class="right-box">TEAM TODOLIST</a>--%>
<%--</div>--%>

<%--<div class="left-top">--%>
<%--    <a href="/traffic-map" class="right-box">TRAFFIC INFO</a>--%>
<%--</div>--%>

<%--<div class="left-bottom">--%>
<%--    <a href="/board/list" class="right-box">ANONYMOUS BOARD</a>--%>
<%--    <a href="/lunchMateBoard" class="right-box">LUNCH MENU</a>--%>
<%--</div>--%>

<%--&lt;%&ndash;개인 투두리스트 &ndash;%&gt;--%>
<%--<div ng-controller="myPersonalController" class="app-container d-flex align-items-center justify-content-center flex-column">--%>
<%--<h3 class="mb-4">Personal Todo List</h3>--%>

<%--<div class="input-group mb-3">--%>
<%--    <input ng-model="yourPersonalTask" type="text" class="form-control" placeholder="Enter a task here">--%>
<%--    <div class="input-group-append">--%>
<%--        <button class="btn btn-primary" type="button" ng-click="savePersonalTask()">Save</button>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<div class="table-responsive">--%>
<%--    <table class="table table-hover table-bordered">--%>
<%--        <thead class="thead-dark">--%>
<%--        <tr>--%>
<%--            <th scope="col">No.</th>--%>
<%--            <th scope="col">Todo item</th>--%>
<%--            <th scope="col">Status</th>--%>
<%--            <th scope="col">Actions</th>--%>
<%--        </tr>--%>
<%--        </thead>--%>
<%--        <tbody>--%>
<%--        <tr ng-repeat="personalTask in personalTasks track by $index" ng-class="{'table-success': personalTask.todoStatus === 'true', 'table-light': personalTask.todoStatus === 'false'}">--%>
<%--            <td>{{$index + 1}}</td>--%>
<%--            <td ng-click="editPersonalTask(personalTask)">--%>
<%--                <span ng-show="!personalTask.editing" ng-class="{'complete': personalTask.todoStatus === 'true'}">{{personalTask.todoContent}}</span>--%>
<%--                <input ng-show="personalTask.editing" type="text" ng-model="personalTask.todoContent" ng-blur="updatePersonalTask(personalTask)" ng-keypress="handleKeyPressPersonalTask($event, personalTask)">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <input type="checkbox" ng-model="personalTask.todoStatus" ng-true-value="'true'" ng-false-value="'false'" ng-change="updatePersonalTask(personalTask)">--%>
<%--            </td>--%>
<%--            <td>--%>
<%--                <button class="btn btn-danger btn-sm" ng-click="deletePersonalTask($index)">Delete</button>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--        </tbody>--%>
<%--    </table>--%>
<%--</div>--%>
<%--</div>--%>

<%--&lt;%&ndash;팀 투두리스트 &ndash;%&gt;--%>
<%--<div ng-controller="myTeamController" class="app-container d-flex align-items-center justify-content-center flex-column">--%>
<%--    <h3 class="mb-4">Team Todo List</h3>--%>

<%--    <div class="input-group mb-3">--%>
<%--        <input ng-model="yourTeamTask" type="text" class="form-control" placeholder="Enter a task here">--%>
<%--        <div class="input-group-append">--%>
<%--            <button class="btn btn-primary" type="button" ng-click="saveTeamTask()">Save</button>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="table-responsive">--%>
<%--        <table class="table table-hover table-bordered">--%>
<%--            <thead class="thead-dark">--%>
<%--            <tr>--%>
<%--                <th scope="col">No.</th>--%>
<%--                <th scope="col">Todo item</th>--%>
<%--                <th scope="col">Status</th>--%>
<%--                <th scope="col">Actions</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody>--%>
<%--            <tr ng-repeat="teamTask in teamTasks track by $index" ng-class="{'table-success': teamTask.teamTodoStatus === 'true', 'table-light': teamTask.teamTodoStatus === 'false'}">--%>
<%--                <td>{{$index + 1}}</td>--%>
<%--                <td ng-click="editTeamTask(teamTask)">--%>
<%--                    <span ng-show="!teamTask.editing" ng-class="{'complete': teamTask.teamTodoStatus === 'true'}">{{teamTask.teamTodoContent}}</span>--%>
<%--                    <input ng-show="teamTask.editing" type="text" ng-model="teamTask.teamTodoContent" ng-blur="updateTeamTask(teamTask)" ng-keypress="handleKeyPressTeamTask($event, teamTask)">--%>
<%--                </td>--%>
<%--                <td>--%>
<%--                    <input type="checkbox" ng-model="teamTask.teamTodoStatus" ng-true-value="'true'" ng-false-value="'false'" ng-change="updateTeamTask(teamTask)">--%>
<%--                </td>--%>
<%--                <td>--%>
<%--                    <button class="btn btn-danger btn-sm" ng-click="deleteTeamTask($index)">Delete</button>--%>
<%--                </td>--%>
<%--            </tr>--%>
<%--            </tbody>--%>
<%--        </table>--%>
<%--    </div>--%>
<%--</div>--%>


<%--&lt;%&ndash;로그인 섹션 &ndash;%&gt;--%>
<%--<div class="login">--%>
<%--    <c:choose>--%>
<%--        <c:when test="${not empty dlist.departmentName}">--%>
<%--            <div class="user-info">TEAM_${login.departmentName}</div>--%>
<%--        </c:when>--%>
<%--        <c:when test="${not empty login.nickName}">--%>
<%--            <div class="user-info">${login.nickName}님 환영해요!</div>--%>
<%--            <button onclick="location.href='/member/logout'">LOGOUT</button>--%>
<%--        </c:when>--%>
<%--        <c:otherwise>--%>
<%--            <div class="user-info">로그인이 필요한 서비스입니다.</div>--%>
<%--            <button onclick="location.href='/login'">Login</button>--%>
<%--        </c:otherwise>--%>
<%--    </c:choose>--%>
<%--</div>--%>

<%--<!-- 달력 컨테이너 -->--%>
<%--<div class="calendar-container">--%>
<%--    <div class="calendar" id="personalCalendar">--%>
<%--        <iframe src="/myCalendar/viewMyEvent" style="width:100%; height:100%; border:none;"></iframe>--%>
<%--        <i class="fas fa-window-minimize toggle-btn" onclick="toggleCalendar('personalCalendar')"></i>--%>
<%--    </div>--%>
<%--    <div class="calendar" id="teamCalendar">--%>
<%--        <iframe src="/myCalendar/viewTeamEvent" style="width:100%; height:100%; border:none;"></iframe>--%>
<%--        <i class="fas fa-window-minimize toggle-btn" onclick="minimizeCalendar('teamCalendar')"></i>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<!-- 최소화된 상태에서 복구할 달력 아이콘 -->--%>
<%--<i class="fas fa-calendar calendar-icon" onclick="restoreMinimizedCalendars()"></i>--%>

<%--<script>--%>
<%--    function updateClock() {--%>
<%--    const now = new Date();--%>
<%--    const hours = String(now.getHours()).padStart(2, '0');--%>
<%--    const minutes = String(now.getMinutes()).padStart(2, '0');--%>
<%--    document.getElementById('clock').textContent = `\${hours}:\${minutes}`;--%>
<%--    }--%>

<%--    function toggleCalendar(calendarId) {--%>
<%--        const calendars = document.querySelectorAll('.calendar');--%>
<%--        calendars.forEach(calendar => {--%>
<%--            calendar.style.display = 'none';--%>
<%--        });--%>
<%--        const selectedCalendar = document.getElementById(calendarId);--%>
<%--        selectedCalendar.style.display = 'block';--%>
<%--        const calendarIcon = document.querySelector('.calendar-icon');--%>
<%--        calendarIcon.style.display = 'block';--%>
<%--    }--%>

<%--    function minimizeCalendar(calendarId) {--%>
<%--        const calendar = document.getElementById(calendarId);--%>
<%--        calendar.classList.add('minimized');--%>
<%--    }--%>

<%--    function restoreMinimizedCalendars() {--%>
<%--        const minimizedCalendars = document.querySelectorAll('.calendar.minimized');--%>
<%--        minimizedCalendars.forEach(calendar => {--%>
<%--            calendar.classList.remove('minimized');--%>
<%--        });--%>
<%--        const calendarIcon = document.querySelector('.calendar-icon');--%>
<%--        calendarIcon.style.display = 'none';--%>
<%--    }--%>

<%--    window.onload = function() {--%>
<%--        toggleCalendar('personalCalendar');--%>
<%--        setInterval(updateClock, 1000);--%>
<%--        updateClock();--%>
<%--    };--%>
<%--</script>--%>

<%--&lt;%&ndash;개인투두리스트 앵귤러 자바 스크립트 &ndash;%&gt;--%>
<%--<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.9/angular.min.js"></script>--%>
<%--<script>--%>
<%--    var appPersonal = angular.module("myTodo", []);--%>

<%--    appPersonal.controller("myPersonalController", function($scope, $http) {--%>
<%--        function initPersonal() {--%>
<%--            $http.get('/api/todos/user/info')--%>
<%--                .then(function(response) {--%>
<%--                    var userInfo = response.data;--%>
<%--                    $scope.userId = userInfo.userId;--%>
<%--                    fetchPersonalTasks();--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error fetching user info:', error);--%>
<%--                });--%>
<%--        }--%>

<%--        function fetchPersonalTasks() {--%>
<%--            $http.get('/api/todos/personal')--%>
<%--                .then(function(response) {--%>
<%--                    $scope.personalTasks = response.data;--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error fetching personal tasks:', error);--%>
<%--                });--%>
<%--        }--%>

<%--        initPersonal();--%>

<%--        $scope.savePersonalTask = function() {--%>
<%--            var newPersonalTask = {--%>
<%--                todoContent: $scope.yourPersonalTask,--%>
<%--                todoStatus: 'false',--%>
<%--                userId: $scope.userId--%>
<%--            };--%>

<%--            $http.post('/api/todos/personal', newPersonalTask)--%>
<%--                .then(function(response) {--%>
<%--                    var savedMyTask = response.data;--%>
<%--                    if (savedMyTask && savedMyTask.todoId) {--%>
<%--                        $scope.personalTasks.push(savedMyTask);--%>
<%--                    } else {--%>
<%--                        newPersonalTask.todoId = 'temporary_' + (new Date()).getTime();--%>
<%--                        $scope.personalTasks.push(newPersonalTask);--%>
<%--                    }--%>
<%--                    $scope.yourPersonalTask = '';--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error saving personal task:', error);--%>
<%--                });--%>
<%--            initPersonal();--%>
<%--        };--%>

<%--        $scope.deletePersonalTask = function(index) {--%>
<%--            var personalTodoId = $scope.personalTasks[index].todoId;--%>

<%--            $http.delete('/api/todos/personal/' + personalTodoId)--%>
<%--                .then(function(response) {--%>
<%--                    $scope.personalTasks.splice(index, 1);--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error deleting personal task:', error);--%>
<%--                });--%>
<%--        };--%>

<%--        $scope.editPersonalTask = function(personalTask) {--%>
<%--            personalTask.editing = true;--%>
<%--        };--%>

<%--        $scope.updatePersonalTask = function(personalTask) {--%>
<%--            if (!personalTask.todoId) return;--%>

<%--            var updatedMyTask = angular.copy(personalTask);--%>
<%--            updatedMyTask.todoStatus = personalTask.todoStatus.toString();--%>

<%--            $http.put('/api/todos/personal/' + personalTask.todoId, updatedMyTask)--%>
<%--                .then(function(response) {--%>
<%--                    personalTask.editing = false;--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error updating personal task:', error);--%>
<%--                });--%>
<%--        };--%>

<%--        $scope.handleKeyPressPersonalTask = function(event, personalTask) {--%>
<%--            if (event.keyCode === 13) {--%>
<%--                $scope.updatePersonalTask(personalTask);--%>
<%--            }--%>
<%--        };--%>
<%--    });--%>
<%--</script>--%>

<%--&lt;%&ndash;팀 투두리스트 자바 스크립트 &ndash;%&gt;--%>
<%--<script>--%>
<%--    var appTeam = angular.module("myAppTeam", []);--%>

<%--    appTeam.controller("myTeamController", function($scope, $http) {--%>

<%--        // 초기화 함수: 서버에서 팀 정보 및 투두리스트 가져오기--%>
<%--        function initTeam() {--%>
<%--            $http.get('/api/todos/user/info')--%>
<%--                .then(function(response) {--%>
<%--                    var userInfo = response.data;--%>
<%--                    $scope.userId = userInfo.userId;--%>
<%--                    $scope.departmentId = userInfo.departmentId;--%>
<%--                    fetchTeamTasks(); // 투두리스트 가져오기 호출--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error fetching team info:', error);--%>
<%--                });--%>
<%--        }--%>

<%--        // 팀 투두리스트 가져오기--%>
<%--        function fetchTeamTasks() {--%>
<%--            $http.get('/api/todos/team/aTeamTodos')--%>
<%--                .then(function(response) {--%>
<%--                    $scope.teamTasks = response.data;--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error fetching team tasks:', error);--%>
<%--                });--%>
<%--        }--%>

<%--        // 페이지 로딩 시 초기화 함수 호출--%>
<%--        initTeam();--%>

<%--        // 투두리스트 저장 함수--%>
<%--        $scope.saveTeamTask = function() {--%>
<%--            var newTeamTask = {--%>
<%--                teamTodoContent: $scope.yourTeamTask,--%>
<%--                teamTodoStatus: 'false', // 기본값을 문자열 'false'로 설정--%>
<%--                departmentId: $scope.departmentId,--%>
<%--                userId: $scope.userId--%>
<%--            };--%>

<%--            console.log('Saving Team Task:', newTeamTask); // 로그 추가--%>

<%--            $http.post('/api/todos/team/aTeamTodos', newTeamTask)--%>
<%--                .then(function(response) {--%>
<%--                    var savedTask = response.data;--%>
<%--                    if (savedTask && savedTask.teamTodoId) {--%>
<%--                        $scope.teamTasks.push(savedTask); // 서버에서 반환된 데이터를 배열에 추가--%>
<%--                    } else {--%>
<%--                        newTeamTask.teamTodoId = 'temporary_' + (new Date()).getTime();--%>
<%--                        $scope.teamTasks.push(newTeamTask); // 임시로 추가--%>
<%--                    }--%>
<%--                    $scope.yourTeamTask = ''; // 입력 필드 초기화--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('팀 투두를 저장하는 중 오류 발생:', error);--%>
<%--                });--%>
<%--            fetchTeamTasks();--%>
<%--            initTeam();--%>
<%--        };--%>

<%--        // 투두리스트 삭제 함수--%>
<%--        $scope.deleteTeamTask = function(index) {--%>
<%--            var teamTodoId = $scope.teamTasks[index].teamTodoId;--%>

<%--            $http.delete('/api/todos/team/' + teamTodoId)--%>
<%--                .then(function(response) {--%>
<%--                    $scope.teamTasks.splice(index, 1); // 배열에서 삭제--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error deleting team task:', error);--%>
<%--                });--%>
<%--            fetchTeamTasks();--%>
<%--            initTeam();--%>
<%--        };--%>

<%--        // 수정 상태로 전환하는 함수--%>
<%--        $scope.editTeamTask = function(teamTask) {--%>
<%--            teamTask.editing = true;--%>
<%--        };--%>

<%--        // 업데이트 함수--%>
<%--        $scope.updateTeamTask = function(teamTask) {--%>
<%--            if (!teamTask.teamTodoId) return; // teamTodoId가 없으면 업데이트하지 않음--%>

<%--            var updatedTask = angular.copy(teamTask);--%>
<%--            updatedTask.teamTodoStatus = teamTask.teamTodoStatus.toString(); // 상태를 문자열로 변환--%>

<%--            $http.put('/api/todos/team/' + teamTask.teamTodoId, updatedTask)--%>
<%--                .then(function(response) {--%>
<%--                    teamTask.editing = false; // 수정 상태 초기화--%>
<%--                })--%>
<%--                .catch(function(error) {--%>
<%--                    console.error('Error updating team task:', error);--%>
<%--                });--%>
<%--        };--%>

<%--        // Enter 키를 눌렀을 때 업데이트 수행--%>
<%--        $scope.handleKeyPressTeamTask = function(event, teamTask) {--%>

<%--            if (event.keyCode === 13) { // Enter 키 코드는 13--%>
<%--                $scope.updateTeamTask(teamTask);--%>
<%--            }--%>
<%--        };--%>
<%--    });--%>
<%--</script>--%>



<%--<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>--%>
<%--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>--%>
<%--</body>--%>
<%--</html>--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>점심 메이트 게시판</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px; /* 기존 테이블과 모달 사이 여백 */
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }

        .button-container {
            text-align: center; /* 버튼 가운데 정렬 */
            margin-bottom: 20px; /* 새 글쓰기 버튼 아래 여백 */
        }

        .button {
            display: inline-block;
            background-color: #008CBA;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        .table-container {
            display: inline-block;
            width: 65%; /* 테이블의 너비 조정 */
            vertical-align: top; /* 왼쪽 정렬 및 위 정렬 */
        }

        .form-container {
            display: inline-block;
            width: 30%; /* 입력 폼의 너비 조정 */
            margin-left: 20px; /* 왼쪽 여백 추가 */
            vertical-align: top; /* 오른쪽 정렬 및 위 정렬 */
        }

        .modal {
            display: none; /* 초기에는 숨김 */
            position: fixed; /* 고정 위치 */
            z-index: 1; /* 다른 요소 위에 표시 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto; /* 스크롤 가능 */
            background-color: rgba(0,0,0,0.4); /* 반투명 배경 */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 중앙에 위치, 상단 여백 조정 */
            padding: 20px;
            border: 1px solid #888;
            width: 70%; /* 모달 너비 조정 */
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>LUNCH MATE BOARD</h1>

    <div class="table-container">
        <table>
            <c:forEach var="board" items="${boards}" varStatus="loop">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>제목</th>
                        <th>작성일자</th>
                        <th>식사일정</th>
                        <th>식당</th>
                        <th>메뉴</th>
                        <th>인원</th>
                        <th>상태</th>
                        <th>참가하기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${board.userId}</td>
                        <td>${board.lunchPostTitle}</td>
                        <td>${board.lunchDate}</td>
                        <td>${board.eatTime}</td>
                        <td>${board.lunchLocation}</td>
                        <td>${board.lunchMenuName}</td>
                        <td>${board.lunchAttendees}</td>
                        <td>${board.progressStatus}</td>
                        <td class="join-button">
 <a href="#" class="join-link" data-lunch-post-number="${board.lunchPostNumber}">참가하기</a>
                        </td>
                    </tr>
                </tbody>
            </c:forEach>
        </table>
    </div>

    <div class="form-container">
        <!-- 모달 -->
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal();">&times;</span>
                <h1>새 글 쓰기</h1>
                <form action="/lunchMateBoard/new" method="post">
                    <!-- 작성자 정보는 자동으로 설정되도록 변경 -->
                    <label for="userId">작성자:</label>
                    <span id="userId">${loggedInUser.userId}</span><br>

                    <label for="lunchPostTitle">제목:</label>
                    <input type="text" id="lunchPostTitle" name="lunchPostTitle" required><br>

                    <label for="eatTime">식사 일정:</label>
                    <input type="text" id="eatTime" name="eatTime"><br>

                    <label for="lunchLocation">식당 위치:</label>
                    <input type="text" id="lunchLocation" name="lunchLocation" required><br>

                    <label for="lunchMenuName">메뉴 이름:</label>
                    <input type="text" id="lunchMenuName" name="lunchMenuName" required><br>

                    <label for="lunchAttendees">인원:</label>
                    <input type="number" id="lunchAttendees" name="lunchAttendees" required><br>

                    <button type="submit">등록</button>
                </form>
            </div>
        </div>

        <!-- 새 글쓰기 버튼에 모달 띄우기 -->
        <div class="button-container">
            <a href="#" onclick="openModal();" class="button">새 글쓰기</a>
        </div>

        <!-- 홈으로 돌아가는 버튼 -->
        <div style="text-align: center; margin-top: 20px;">
            <a href="http://localhost:8383/" style="background-color: pink; border-radius: 4px; padding: 10px; text-decoration: none; color: white;">home</a>
        </div>
    </div>

    <!-- JavaScript 코드 -->
    <script>
        // 모달 띄우기 함수
        function openModal() {
            var modal = document.getElementById('myModal');
            modal.style.display = 'block';
        }

        // 모달 닫기 함수
        function closeModal() {
            var modal = document.getElementById('myModal');
            modal.style.display = 'none';
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            var modal = document.getElementById('myModal');
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }

    </script>
</body>
</html>

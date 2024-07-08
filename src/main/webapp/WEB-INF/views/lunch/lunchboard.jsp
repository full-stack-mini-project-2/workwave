<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../include/static-head.jsp" %>
    <%@ include file="../include/header.jsp" %>



    <meta charset="UTF-8">
    <title>점심 메이트 게시판</title>
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap');
        body {
            margin-top: 60px; /* include된 내용 높이에 맞게 조정 */
            font-family: 'Noto Sans KR', sans-serif;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
            padding-left: 60px; /* 왼쪽 여백 추가 */
            padding-right: 60px; /* 오른쪽 여백 추가 */

        }

        h1.board-title {
            display: inline-block;
            margin: 0;
            font-weight: bold;
            font-size: 40px; /* 제목 폰트 크기 조정 */
        }

        .button-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            text-align: center;
        }

        .button {
            background-color: #32489f;
            border: none;
            color: white;
            padding: 12px 20px; /* 높이 조정 */
            text-align: center;
              font-weight: bold;
            text-decoration: none;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
        }

        .home-button {
            background-color: #5c317d;
            border-radius: 4px;
              font-weight: bold;
            padding: 12px 20px; /* 높이 조정 */
            text-decoration: none;
            color: white;
            margin-left: 10px; /* 원하는 만큼 왼쪽 여백 추가 */
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            /* 기존 테이블과 모달 사이 여백 */
        }

        th,
        td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #5973dd;
            font-size: 15px;
            color: rgb(255, 255, 255);


        }
        .join-cell {
            padding: 0; /* 내부 패딩을 제거하여 버튼이 전체 셀을 차지하도록 설정합니다. */
        }

        .join-cell button {
            width: 100%;
            height: 100%;
            background-color: #32489f;
            border: none;
            color: white;
            padding: 12px 20px;
            font-weight: bold;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
        }

        .table-container {
            width: 65%;
            margin: 0 auto; /* 가운데 정렬을 위해 좌우 마진을 자동으로 설정 */
            text-align: center; /* 테이블 내의 콘텐츠를 가운데 정렬 */
            vertical-align: top; /* 위 정렬 유지 */
        }

        .form-container {
            width: 30%;
            /* 입력 폼의 너비 조정 */
            margin-left: 20px;
            /* 왼쪽 여백 추가 */
            vertical-align: top;
            /* 오른쪽 정렬 및 위 정렬 */
            display: inline-block;
        }

        .modal {
            display: none;
            /* 초기에는 숨김 */
            position: fixed;
            /* 고정 위치 */
            z-index: 1;
            /* 다른 요소 위에 표시 */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            /* 스크롤 가능 */
            background-color: rgba(0, 0, 0, 0.4);
            /* 반투명 배경 */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            /* 중앙에 위치, 상단 여백 조정 */
            padding: 20px;
            border: 1px solid #888;
            width: 70%;
            /* 모달 너비 조정 */
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
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

    <div class="header-container">
        <h1 class="board-title">LUNCH MATE BOARD</h1>

         <div class="button-container">
                <!-- 새 글쓰기 버튼에 모달 띄우기 -->
                <a href="#" onclick="openModal();" class="button">새 글쓰기</a>

                <!-- 홈으로 돌아가는 버튼 -->
                <a href="http://localhost:8383/" class="home-button">home</a>
            </div>

    </div>



    <div class="table-container">
        <table>
            <c:forEach var="board" items="${boards}" varStatus="loop">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>제목</th>
                        <th>식사일정</th>
                        <th>식당</th>
                        <th>메뉴</th>
                        <th>인원</th>
                        <th>상태</th>
                        <th>참가하기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr data-post-id="${board.lunchPostNumber}">
                        <td>${board.userId}</td>
                        <td>${board.lunchPostTitle}</td>
                        <td>${board.eatTime}</td>
                        <td>${board.lunchLocation}</td>
                        <td>${board.lunchMenuName}</td>
                        <td>${board.lunchAttendees}명</td>
                        <td>${board.progressStatus}명</td>
                         <td class="join-cell">
                                <!-- 전체 셀을 버튼으로 만듭니다. -->
                                <button data-id="${board.lunchPostNumber}" class="btnJoin" type="button">Join!</button>
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
                    <!-- <label for="userId">작성자:</label> -->
                    <!-- <span id="userId">${loggedInUser.userId}</span><br> -->

                    <label for="lunchPostTitle">제목:</label>
                    <input type="text" id="lunchPostTitle" name="lunchPostTitle" required><br>

                    <label for="eatTime">식사 일정:</label>
                    <input type="date" id="eatTime" name="eatTime" required><br>

                    <label for="lunchLocation">식당 위치:</label>
                    <input type="text" id="lunchLocation" name="lunchLocation" required><br>

                    <label for="lunchMenuName">메뉴 이름:</label>
                    <input type="text" id="lunchMenuName" name="lunchMenuName" required><br>

                    <label for="lunchAttendees">인원:</label>
                    <input type="number" id="lunchAttendees" name="lunchAttendees" required><br>

                    <input type="hidden" id="progressStatus" name="progressStatus" value="1">

                    <button type="submit">등록</button>
                </form>
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
            window.onclick = function (event) {
                var modal = document.getElementById('myModal');
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            }

            // 클릭 이벤트 리스너 등록
            document.querySelectorAll('.btnJoin').forEach(button => {
                button.addEventListener('click', async (e) => {
                    e.preventDefault();

                    const boardId = button.getAttribute('data-id');

                       // 버튼 클릭 시, 해당 행의 인원과 상태 값을 확인하여 조건 검사
                                const boardElement = button.closest('tr');
                                const attendeesCell = boardElement.querySelector('td:nth-child(6)');
                                const statusCell = boardElement.querySelector('td:nth-child(7)');
                                const currentAttendees = parseInt(attendeesCell.textContent);
                                const progressStatus = parseInt(statusCell.textContent);

                                // 인원과 상태 값이 같을 경우 버튼을 비활성화
                                if (currentAttendees === progressStatus) {
                                    button.disabled = true;
                                    alert('이미 참가할 수 없는 상태입니다.');
                                    return;
                                }

                    // POST 요청 보내기
                    fetch(`${pageContext.request.contextPath}/lunchMateBoard/joinLunch`, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ lunchPostNumber: boardId })
                    })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json(); // JSON으로 파싱
                        })
                        .then(data => {
                            console.log('Response:', data);
                            if (data.status === 'success') {
                                const updatedBoard = data.board;
                                // 예시: 업데이트된 데이터를 활용하여 웹 페이지에 렌더링
                                  statusCell.textContent = updatedBoard.progressStatus;

                                // const boardElement = document.querySelector(`tr[data-post-id="${updatedBoard.lunchPostNumber}"]`);
                                // if (boardElement) {
                                //     boardElement.querySelector('td:nth-child(7)').textContent = updatedBoard.progressStatus;
                                // }

                                    // 인원과 상태 값이 같을 경우 버튼을 비활성화
                        if (updatedBoard.lunchAttendees === updatedBoard.progressStatus) {
                            button.disabled = true;
                        }

                                alert('Successfully joined lunch!');
                                location.reload(); // 페이지 새로고침
                            } else {
                                alert('Failed to join lunch: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while joining lunch. Please try again.');
                        });
                });
            });
        </script>
    </div>

</body>

</html>

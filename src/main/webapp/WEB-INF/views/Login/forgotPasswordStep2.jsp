<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>WORKWAVE:비밀번호찾기-2</title>
        <link href="/assets/css/forgotPasswordStep2.css" rel="stylesheet" />
        <link rel="icon" href="/assets/img/workwave_logo.png" />
    </head>

    <body>
        <div class="container">
            <h2></h2>
            <form id="myForm" onsubmit="return validateForm()">
                <div class="password-change-title">비밀번호 찾기</div><br />
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" id="userName" name="userName" placeholder="이름" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-user"></i>
                    <input type="text" id="employeeId" name="employeeId" placeholder="사번" required>
                </div>
                <div class="input-group">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="userEmail" name="userEmail" placeholder="이메일" required>
                </div>
                <input type="button" value="확인" onclick="validateForm()">
            </form>
            <div class="back-link">
                <a href="/login">로그인으로 돌아가기</a>
            </div>

            <!-- The Modal -->
            <div id="myModal" class="modal">
                <!-- Modal content -->
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <p id="modal-message"></p>
                    <form id="passwordForm" action="changePassword" method="post">
                        <div class="password-change-title">비밀번호 찾기</div><br />
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="newPassword" name="newPassword" placeholder="새 비밀번호" required>
                        </div>
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호 확인"
                                required>
                        </div>
                        <input type="submit" value="비밀번호 변경" onclick="return checkPassword()">
                    </form>
                </div>
                <!-- 비밀번호 불일치 모달 -->
                <div id="passwordMismatchModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <p>새 비밀번호와 비밀번호 확인이<br /> 일치하지 않습니다.<br />다시 확인해주세요.</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- <script type="module" src="/assets/js/forgotPasswordStep2.js"></script> -->
    </body>
    <script>
        // Get the modal
        var modal = document.getElementById('myModal');

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks the button, open the modal
        document.getElementById('myForm').addEventListener('submit', function (e) {
            e.preventDefault(); // Prevent the form from submitting
            modal.style.display = "block";
        });

        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            modal.style.display = "none";
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }

        function validateForm() {
            // input data
            var userName = document.getElementById('userName').value;
            var employeeId = document.getElementById('employeeId').value;
            var userEmail = document.getElementById('userEmail').value;
            console.log('🙏[입력내용] userName:' + userName + ' employeeId:' + employeeId + ' userEmail: ' + userEmail);
            console.log('✌🏻result= ' + '${resultUser}');
            modal.style.display = "block";

            // 문자열 분해 [db data]
            const db_uid = `${resultUserId}`;
            const db_eid = `${resultEmpId}`;
            const db_uEmail = `${resultEmail}`;
            const db_uName = `${resultName}`;

            console.log("☂️찐 =  " + db_uid + " " + db_eid + " " + db_uEmail + " " + db_uName);

            if (userName === db_uName && employeeId === db_eid && userEmail === db_uEmail) {
                document.getElementById('passwordForm').style.display = "block";
                document.getElementById('modal-message').innerText = '';
                $modalBox = document.querySelector('.modal-content');
                $modalBox.style.backgroundColor = "#3E48A1";
            }
            else {
                document.getElementById('passwordForm').style.display = "none";
                document.getElementById('modal-message').innerText = '정보 불일치!\n다시 확인해주세요.';
                $modalBox = document.querySelector('.modal-content');
                $modalBox.style.backgroundColor = "#973554";
            }
            return true; // For demonstration purposes, always returns true
        }

        function checkPassword() {
            var newPassword = document.getElementById('newPassword').value;
            var confirmPassword = document.getElementById('confirmPassword').value;

            if (newPassword === confirmPassword) {
                return true;
            } else {
                // alert 대신 모달을 표시합니다.
                var mismatchModal = document.getElementById('passwordMismatchModal');
                mismatchModal.style.display = "block";

                // 모달 닫기 버튼 이벤트 리스너
                var closeBtn = mismatchModal.getElementsByClassName("close")[0];
                closeBtn.onclick = function () {
                    mismatchModal.style.display = "none";
                }

                // 모달 외부 클릭 시 닫기
                window.onclick = function (event) {
                    if (event.target == mismatchModal) {
                        mismatchModal.style.display = "none";
                    }
                }

                return false;
            }
        }
    </script>

    </html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>workwave:회원가입</title>
      <!-- reset -->
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@4.0.1/reset.min.css" />
      <link href="https://fonts.google.com/specimen/Roboto" rel="stylesheet" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
        integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

      <link href="/assets/css/UserRegister.css" rel="stylesheet" />
      <link rel="icon" href="/assets/img/workwave_logo.png" />
    </head>

    <body>
      <!--  -->
      <div class="container wrap">
        <div class="row">
          <div>
            <div class="card">
              <div class="card-body">
                <form action="/join" name="join" id="joinForm" method="post" enctype="multipart/form-data">
                  <div class="profile">
                    <div class="thumbnail-box">
                      <img src="/assets/img/image-add.png" alt="프로필 썸네일" />
                    </div>

                    <label>프로필 이미지 추가</label>

                    <input type="file" id="profile-img" accept="image/*" style="display: none" name="profileImg" />
                  </div>
                  <table>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>아이디를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;
                          <span id="idChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-user-tie"></i>
                        <input type="text" name="userId" id="userId" class="signUpInputStyle" maxlength="14"
                          required="required" aria-required="true" placeholder="숫자와 영어로 4-14자" />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>비밀번호를 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-lock"></i>
                        <input type="password" size="17" maxlength="20" id="password" name="password"
                          class="signUpInputStyle" maxlength="20" required="required" aria-required="true"
                          placeholder="영문과 특수문자를 포함한 최소 8자" />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>비밀번호를 재확인해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="pwChk2"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-lock"></i>
                        <input type="password" size="17" maxlength="20" id="password_check" name="pw_check"
                          class="signUpInputStyle" maxlength="20" required="required" aria-required="true"
                          placeholder="비밀번호가 일치해야합니다." />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>이름을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="nameChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-user-tie"></i>
                        <input type="text" name="userName" id="userName" class="signUpInputStyle" maxlength="6"
                          required="required" aria-required="true" placeholder="한글로 최대 6자" />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>이메일을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="emailChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-envelope"></i>
                        <input type="email" name="userEmail" id="userEmail" class="signUpInputStyle" required="required"
                          aria-required="true" placeholder="ex) abc@mvc.com" />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>부서를 선택해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="departmentChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-building"></i>
                        <select class="signUpInputStyle2" id="departmentId" name="departmentId" required>
                          <option value=""></option>
                          <c:forEach items="${dList}" var="department">
                            <option value="${department.departmentId}">
                              ${department.departmentName}
                            </option>
                          </c:forEach>
                        </select><br />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>사원 ID를 작성해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="employeeIdChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-id-card-alt"></i>
                        <input type="text" class="signUpInputStyle" id="employeeId" name="employeeId" placeholder="P000"
                          required /><br />
                      </td>
                    </tr>
                    <tr>
                      <td style="text-align: left">
                        <p>
                          <strong>직책을 입력해주세요.</strong>&nbsp;&nbsp;&nbsp;<span id="userPositionChk"></span>
                        </p>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <i class="fas fa-user-tie"></i>
                        <input type="text" class="signUpInputStyle" id="userPosition" name="userPosition"
                          placeholder="사원,대리,과장,차장..." required /><br />
                      </td>
                    </tr>
                    <!--  -->
                    <tr>
                      <td>
                        <input type="button" value="회원가입" class="btn-join" id="signup-btn" />
                      </td>
                    </tr>
                    <br />
                  </table>
                </form>
              </div>
              <!--card body end-->
            </div>
            <!--card end-->
          </div>
          <!--offset-md-2 end-->
        </div>
        <!-- row end -->
      </div>
      <!-- container wrap end-->
      <!--  -->
      <script type="module" src="/assets/js/UserRegister.js"></script>

      <!-- 프로필 사진 관련 스크립트 -->
      <script>
        // 프로필 사진 동그라미 썸네일 부분
        const $profile = document.querySelector(".profile");
        // 실제 프로필사진이 첨부될 input
        const $fileInput = document.getElementById("profile-img");

        //프로필 영역 클릭 시 input 태그 클릭 되도록 함
        $profile.addEventListener("click", (e) => {
          $fileInput.click();
        });

        // 프로필 사진 선택시 썸네일 보여주기
        $fileInput.addEventListener("change", (e) => {
          console.log("file changed!");
          // 사용자가 첨부한 파일 데이터 읽기
          const fileData = $fileInput.files[0];
          // console.log(fileData);

          // 첨부파일 이미지의 로우데이터(바이트)를 읽는 객체 생성
          const reader = new FileReader();

          // 파일의 데이터를 읽어서 img태그에 src속성에 넣기 위해
          // 파일을 URL형태로 변경
          reader.readAsDataURL(fileData);

          // 첨부파일이 등록되는 순간 img태그에 이미지를 세팅
          reader.onloadend = (e) => {
            const $img = document.querySelector(".thumbnail-box img");
            $img.src = reader.result;
          };
        });
      </script>
    </body>

    </html>
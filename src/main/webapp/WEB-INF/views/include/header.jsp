<!-- header -->
<header>
    
    <div class="inner-header">
        <a href="#" class="menu-open">
            <span class="menu-txt"></span>
            <span class="lnr lnr-menu"></span>
        </a>
        <h1 class="logo">
            <a class="logo-img" href="/">
                <img src="/assets/img/workwave_logo.png" alt="로고이미지" class="logo">
            </a>
        </h1>
        <div class="profile-box">
            <c:choose>
                <c:when test="${login != null && login.profile != null}">
                    <img src="${login.profile}" alt="profile image">
                </c:when>
                <c:otherwise>
                    <img src="/assets/img/anonymous2.png" alt="profile image">
                </c:otherwise>
            </c:choose>
        </div>
        <!-- <h2 class="intro-text">Welcome ${login.nickName}</h2> -->
    </div>

    <nav class="gnb">
        <a href="#" class="close">
        </a>
        <ul class="nav-content">
            <li>
                <!-- <i class="fas fa-home"></i> -->
                <a href="/">
                    <i class="fas fa-poo"></i>
                    Home
                </a>
            </li>
            <li>
                <a href="/myCalendar/viewMyEvent">
                    <i class="fas fa-clipboard-check"></i>
                    My Calendar
                </a>
            </li>
            <li>
                <a href="/">
                    <i class="fas fa-chalkboard-teacher"></i>
                    Team Calendar
                </a>
            </li>
            <li>
                <a href="/">
                    <i class="fas fa-calendar-check"></i>
                    todoList
                </a>
            </li>
            <li>
                <a href="/board/list">
                    <i class="fas fa-comment-alt"></i>
                    Board
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-bus-alt"></i>
                    Traffic
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-utensils"></i>
                    Contact
                </a>
            </li>
            <c:if test="${login == null}">
            <div class="login-section">   
                <li class="sign-up">
                    <a href="/members/sign-up">
                        <i class="fas fa-user-plus"></i>
                        Sign Up
                    </a>
                </li>
                <li class="sign-in">   
                    <a href="/members/sign-in">
                        <i class="fas fa-sign-in-alt"></i>
                        Sign In
                    </a>
                </li>
            </div> 
            </c:if>
            <c:if test="${login != null}">
                <div class="login-section">   
                <li class="my-page">

                    <a href="#">
                        <i class="fas fa-user"></i>
                        My Page
                    </a>
                </li>
                <li class="sign-out">
                    <a href="/members/sign-out">
                        <i class="fas fa-sign-out-alt"></i>
                        Sign Out
                    </a>
                </li>
                </div>
            </c:if>
        </ul>
    </nav>
</header>
<!--//header-->

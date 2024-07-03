package com.workwave.interceptor;

import com.workwave.dto.user.LoginUserInfoDto;
import com.workwave.entity.schedule.CalendarEvent;
import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.mapper.scheduleMapper.CalendarMapper;
import com.workwave.mapper.scheduleMapper.TodoListMapper;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static com.workwave.util.LoginUtil.*;

//삭제 본인만 할 수 있도록 컨피그 진행
@Configuration   //스프링이 주입할 수 있도록 (=Component)
@Slf4j
@RequiredArgsConstructor
public class ScheduleInterceptor implements HandlerInterceptor {

    private final TodoListMapper todoListMapper;
    private final CalendarMapper calendarMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        log.debug("You are trying to access someone else's schedule!!");
        if(!LoginUtil.isLoggedIn(request.getSession())) {        //로그인이 되어있으면 못들어가게
            log.info("로그인이 필요합니다.:{}",request.getRequestURI());
            response.sendRedirect("/login");  //리다이렉트로 로그인으로 보냄
            return false;   //true일 경우, 컨트롤러 진입 허용 / false는 진입 차단
        }
        return true;
    }

    /*
        // 수정과 삭제 권한 config
        //현재 세션이 있는지 조회
        HttpSession session = request.getSession();

        //유저 아이디 조회
        String loggedInUserAccount = getLoggedInUserAccount(session);
        //로그인 한 유저 조회
        String loggedInUserDeptId = getLoggedInDepartmentId(session);

        //세션과 각 매퍼에서 주입하려 할 때 세션이 없으면 로그인 창 리다이렉션
        int calEventId = Integer.parseInt(request.getParameter("calEventId"));
        int todoId
        //세션과 각 매퍼에서 사용자가 같지 않으면 access-denyed 진행
        CalendarEvent calendarEvent = calendarMapper.findOneMyCalEvent(calEventId);
        TeamTodoList teamTodoList = todoListMapper.findByTodoId("todoId");



        int bno = Integer.parseInt(request.getParameter("bno"));
        //접근당하는 보드의 넘버
        Board board = boardMapper.findOne(bno);
        //접근당하는 보드의 어카운트
        String boardAccount = board.getAccount();
        //접근당하는 보드 어카운트 = 현재 세션 로그인
        if((loggedInUserAccount.equals(boardAccount)) && (LoginUtil.isLoggedIn(session)) ) {
            //보드 글번호 조회해서 새로운 쿠키 넣기

            return true; //회원이고 남이 쓴 글일때 한시간에 1회씩 조회수 올린다.
        }
        return false;//비회원이거나 자기가 쓴 글일 때 카운트를 하지 않는다.
    }

     */


}

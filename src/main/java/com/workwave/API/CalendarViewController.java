package com.workwave.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.dto.schedule_dto.request.AllMyTeamCalendarEventDto;
import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.service.UserService;
import com.workwave.service.schedule.CalendarService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * 주 기능 : 세션에 저장된 정보를 JSP에 전달
 *
 */
@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/myCalendar")
public class CalendarViewController {

    private final CalendarService calendarService;
    private final ObjectMapper objectMapper;

    //======================= 개인 메서드 ==========================

    //개인 일정 달별로 조회하기
    @GetMapping("/viewMyEvent")
    public String viewCalendar(Model model, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            log.info("userId 가 없습니다. {}", session.getAttribute("userId"));
            throw new RuntimeException("User is not logged in");
        }
        try {
            List<AllMyCalendarEventDto> myCalendarEvents = calendarService.getMyAllEvents(userId);

            String mycalEventsJson = objectMapper.writeValueAsString(myCalendarEvents);
            model.addAttribute("mycalEvents", mycalEventsJson.replace("'", "\\'"));
            // formattedDate 설정
            String formattedDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("formattedDate", formattedDate);
            // 유저 이름 설정
            String userName = myCalendarEvents.isEmpty() ? "Unknown User" : myCalendarEvents.get(0).getUserName();
            model.addAttribute("userName", userName);

        } catch (Exception e) {
            log.error("Error converting events to JSON", e);
        }
        return "schedule/calendar/myCalendar";
    }

    //개인 일정 추가 화면처리
    @PostMapping("/addMyEvent")
    public String addMyEvent(@ModelAttribute AllMyCalendarEventDto myCalendarEventDto, HttpSession session) {
        // 세션에서 userId userName 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        String userName = LoginUtil.getLoggedInUser(session).getNickName();
        if (userId == null || userName == null) {
            throw new RuntimeException("User is not logged in");
        }
        calendarService.addEvent(myCalendarEventDto, userId, userName);
        return "redirect:/calendar/viewMyEvent/" + userId;
    }

    //개인 일정 수정 화면처리
    @PostMapping("/updateMyEvent")
    public String editMyEvent(@ModelAttribute AllMyCalendarEventDto myCalendarEventDto, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        // 이벤트 수정 호출
        boolean success = calendarService.updateCalEvent(myCalendarEventDto);
        if (!success) {
            throw new RuntimeException("Failed to update event");
        }
        return "redirect:/calendar/viewMyEvent/" + userId;
    }

    //일정 삭제 화면처리
    @GetMapping("/deleteMyEvent/{calEventId}")
    public String deleteCalEvent(@PathVariable int calEventId, HttpSession session) {
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        boolean success = calendarService.deleteCalEvent(calEventId);
        if(!success) {
            throw new RuntimeException("failed to delete event");
        }
        return "redirect:/calendar/viewMyEvent/" + userId;
    }

    //======================= 팀 메서드 ==========================

    //팀 일정 달별로 조회하기
    @GetMapping("/viewTeamEvent")
    public String viewTeamCalendar(Model model, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
//            log.info("userId 가 없습니다. {}", session.getAttribute("userId"));
//            throw new RuntimeException("User is not logged in");
        }
        try {
            String departmentId = LoginUtil.getLoggedInDepartmentId(session);
            List<AllMyTeamCalendarEventDto> teamCalEvents = calendarService.getAllTeamEvents(departmentId);

            // model에 필요한 데이터 추가
            model.addAttribute("departmentId", departmentId);

//            // teamCalEvents를 JSON 문자열로 변환하여 model에 추가
//            String teamCalEventsForMonthJson = objectMapper.writeValueAsString(teamCalEvents);
//            log.info("teamCalEvents JSON 제대로 나오니 >>>?????? {}",teamCalEventsForMonthJson);

//            model.addAttribute("teamCalEvents", teamCalEventsForMonthJson);

            // formattedDate 설정
            String formattedDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("formattedDate", formattedDate);

            //현재 유저 이름 설정 : 수정을 위한 세션값
            String userName = LoginUtil.getLoggedInUser(session).getNickName();
            model.addAttribute("userName", userName);


        } catch (Exception e) {
            log.error("Error converting events to JSON", e);
        }
        return "schedule/calendar/teamCalendar";
    }

    //일정 추가 화면처리
    @PostMapping("/addTeamEvent")
    public String addTeamEvent(@ModelAttribute AllMyTeamCalendarEventDto teamCalendarEventDto, HttpSession session) {
        // 세션에서 userId userName 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        String departmentId = LoginUtil.getLoggedInDepartmentId(session);
        String userName = LoginUtil.getLoggedInUser(session).getNickName();
        if (userId == null || userName == null) {
            throw new RuntimeException("User is not logged in");
        }
        calendarService.addTeamEvent(teamCalendarEventDto, userId, userName, departmentId);
        return "redirect:/calendar/viewTeamEvent/" + departmentId;
    }

    // 일정 수정 화면처리
    @PostMapping("/updateTeamEvent")
    public String editTeamEvent(@ModelAttribute AllMyTeamCalendarEventDto teamCalendarEventDto, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        String departmentId = LoginUtil.getLoggedInDepartmentId(session);
        String userName = LoginUtil.getLoggedInUser(session).getNickName();
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        // 이벤트 수정 호출
        boolean success = calendarService.updateTeamCalEvent(teamCalendarEventDto);
        if (!success) {
            throw new RuntimeException("Failed to update event");
        }
        return "redirect:/calendar/viewTeamEvent/" + departmentId;
    }

    //일정 삭제 화면처리
    @GetMapping("/deleteTeamEvent/{calEventId}")
    public String deleteTeamCalEvent(@PathVariable int calEventId, HttpSession session) {
        String userId = LoginUtil.getLoggedInUserAccount(session);
        String departmentId = LoginUtil.getLoggedInDepartmentId(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        boolean success = calendarService.deleteCalEvent(calEventId);
        if(!success) {
            throw new RuntimeException("failed to delete event");
        }
        return "redirect:/calendar/viewTeamEvent/" + departmentId;
    }


}


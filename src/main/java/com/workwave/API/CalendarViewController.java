package com.workwave.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
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

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/calendar")
public class CalendarViewController {

    private final CalendarService calendarService;
    private final ObjectMapper objectMapper;

    @GetMapping("/view")
    public String viewCalendar(Model model, HttpSession session) {
        // 세션에서 userId 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            log.info("userId 가 없습니다. {}", session.getAttribute("userId"));
            throw new RuntimeException("User is not logged in");
        }

        List<AllMyCalendarEventDto> myCalendarEvents = calendarService.getMyAllEvents(userId);
        try {
            System.out.println("isLoggedIn: " + LoginUtil.isLoggedIn(session));
            System.out.println("getLoggedIN: " + LoginUtil.getLoggedInUser(session));

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


    @PostMapping("/add")
    public String addMyEvent(@ModelAttribute AllMyCalendarEventDto myCalendarEventDto, HttpSession session) {
        // 세션에서 userId userName 가져오기
        String userId = LoginUtil.getLoggedInUserAccount(session);
        String userName = (String) session.getAttribute("userName");
        if (userId == null || userName == null) {
            throw new RuntimeException("User is not logged in");
        }
        calendarService.addEvent(myCalendarEventDto, userId, userName);
        return "redirect:/calendar/view/" + userId;
    }


}
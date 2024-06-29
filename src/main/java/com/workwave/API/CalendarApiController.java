package com.workwave.API;

import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.CalendarService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/calendar")
public class CalendarApiController {

    private final CalendarService calendarService;

    // 개인의 캘린더 목록 전체 조회하기 (세션 사용)
    @GetMapping("/myEvents/All")
    public List<AllMyCalendarEventDto> getMyAllEvents(HttpSession session) {
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        return calendarService.getMyAllEvents(userId);
    }


    // 개인의 캘린더 목록 달에 따라서 조회하기 (세션 사용)
    @GetMapping("/myEvents")
    public List<AllMyCalendarEventDto> getMyEvents(
            @RequestParam("year") int year,
            @RequestParam("month") int month,
            HttpSession session) {

        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        try {
            return calendarService.getMyEventsForMonth(userId, year, month);
        } catch (Exception e) {
            log.error("Error fetching events for user: " + userId, e);
            throw new RuntimeException("Error fetching events");
        }
    }

    //개인 캘린더 일정 추가
    @PostMapping("/addEvent")
    public ResponseEntity<AllMyCalendarEventDto> createCalEvent(
            @RequestBody AllMyCalendarEventDto addEventDto,
            HttpSession session
    ) {
        String userName = LoginUtil.getLoggedInUserInfoList(session).get(0).getNickName();
        String userId = LoginUtil.getLoggedInUserAccount(session);
        // 비 로그인자 방지
        if(userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        AllMyCalendarEventDto newEvent = calendarService.addEvent(addEventDto, userId, userName);
        return ResponseEntity.ok(newEvent);
    }

    //개인 캘린더 일정 수정

    //개인 캘린더 일정 삭제

    //개인 캘린더 색상으로 검색

    //개인 캘린더 제목으로 검색





}


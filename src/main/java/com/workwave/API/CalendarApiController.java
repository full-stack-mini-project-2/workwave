package com.workwave.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.CalendarService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public ResponseEntity<Map<String, Object>> createCalEvent(
            @RequestBody AllMyCalendarEventDto addEventDto,
            HttpSession session
    ) {
        String userName = LoginUtil.getLoggedInUserInfoList(session).get(0).getNickName();
        String userId = LoginUtil.getLoggedInUserAccount(session);

        // 비 로그인자 방지
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }

        boolean isSuccess = false;
        String message = "Failed to create event";

        try {
            // 클라이언트에서 전송된 날짜 데이터를 UTC로 변환하여 처리
            LocalDate eventDate = LocalDate.parse(addEventDto.getCalEventDate()); // ISO 8601 포맷의 문자열을 LocalDate로 변환
            Instant calEventInstant = eventDate.atStartOfDay(ZoneOffset.UTC).toInstant();

            // UTC 시간으로 변환된 일정 데이터 생성
            AllMyCalendarEventDto newEvent = AllMyCalendarEventDto.builder()
                    .calEventDate(eventDate.toString()) // LocalDate를 문자열로 다시 저장
                    .calEventTitle(addEventDto.getCalEventTitle())
                    .calEventDescription(addEventDto.getCalEventDescription())
                    .calEventCreateAt(LocalDateTime.now())
                    .calEventUpdateAt(LocalDateTime.now())
                    .colorIndexId(addEventDto.getColorIndexId())
                    .userId(userId)
                    .userName(userName)
                    .build();

            // 서비스를 통해 일정 저장
            newEvent = calendarService.addEvent(newEvent, userId, userName);
            isSuccess = newEvent != null;
            message = isSuccess ? "Event created successfully" : message;
        } catch (Exception e) {
            message = e.getMessage();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", isSuccess);
        response.put("message", message);

        return ResponseEntity.ok(response);
    }

    //개인 캘린더 수정
    @PostMapping("/updateEvent")
    public String updateCalEvent(HttpSession session) {
    return null;
    }

    //개인 캘린더 삭제
    @GetMapping("deleteEvent")
    public String deleteCalEvent(int calEventId, HttpSession session) {
        return null;
    }


}





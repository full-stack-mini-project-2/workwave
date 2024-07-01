package com.workwave.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.CalendarService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.*;
import java.time.format.DateTimeFormatter;
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
        String userName = LoginUtil.getLoggedInUser(session).getNickName();
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
//            Instant calEventInstant = eventDate.atStartOfDay(ZoneOffset.UTC).toInstant();

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

    // Update an existing event
    @PostMapping("/updateEvent")
    public ResponseEntity<Map<String, Object>> editMyEvent(@RequestBody AllMyCalendarEventDto myCalendarEventDto, HttpSession session) {
        // Get userId from session
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            return ResponseEntity.status(401).body(Map.of("message", "User is not logged in"));
        }
        try {
            // Ensure calEventUpdateAt is not null before parsing
            if (myCalendarEventDto.getCalEventUpdateAt() == null) {
                // Handle the case where calEventUpdateAt is not provided by client
                // For example, you may choose to use the current time as updatedAt
                LocalDateTime updatedAt = LocalDateTime.now(); // Or any default value you prefer
                myCalendarEventDto.setCalEventUpdateAt(updatedAt);
            } else {
                // ISO-8601 형식으로 전송된 updateAt 문자열을 파싱
                LocalDateTime updatedAt = LocalDateTime.parse(myCalendarEventDto.getCalEventUpdateAt().toString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                myCalendarEventDto.setCalEventUpdateAt(updatedAt);
            }
            // Update the event with additional fields
            myCalendarEventDto.setUserId(userId);
//        try {
//             ISO-8601 형식으로 전송된 updateAt 문자열을 파싱하여 LocalDateTime 객체로 변환
//            LocalDateTime updatedAt = LocalDateTime.parse(myCalendarEventDto.getCalEventUpdateAt().toString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);

            // Update the event DTO with additional fields
//            myCalendarEventDto.setUserId(userId);
//            myCalendarEventDto.setCalEventUpdateAt(updatedAt); // 이 부분에서 LocalDateTime 값을 DTO에 설정해줍니다.

            // 캘린더 서비스를 통해 이벤트 업데이트를 시도
            boolean success = calendarService.updateCalEvent(myCalendarEventDto);
            if (success) {
                return ResponseEntity.ok(Map.of("success", true, "message", "Event updated successfully"));
            } else {
                return ResponseEntity.status(400).body(Map.of("success", false, "message", "Failed to update event"));
            }
        } catch (Exception e) {
            log.error("Error updating event", e);
            return ResponseEntity.status(500).body(Map.of("message", "Error updating event"));
        }
    }


    //개인 캘린더 삭제
    @DeleteMapping("/deleteEvent/{calEventId}")
    public ResponseEntity<Map<String, Object>> deleteCalEvent(@PathVariable int calEventId, HttpSession session) {
        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        try {
            boolean success = calendarService.deleteCalEvent(calEventId);
            if (success) {
                return ResponseEntity.ok(Map.of("success", true, "message", "Event deleted successfully"));
            } else {
                return ResponseEntity.status(400).body(Map.of("success", false, "message", "Failed to delete event"));
            }
        } catch (Exception e) {
            log.error("Error deleting event", e);
            return ResponseEntity.status(500).body(Map.of("message", "Error deleting event"));
        }
    }
}





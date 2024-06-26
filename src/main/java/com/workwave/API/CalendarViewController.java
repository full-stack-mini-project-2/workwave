package com.workwave.API;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.workwave.dto.schedule_dto.request.AllMyCalendarEventDto;
import com.workwave.service.schedule.CalendarService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @GetMapping("/view/{userId}")
    public String viewCalendar(@PathVariable("userId") String userId, Model model) {
        List<AllMyCalendarEventDto> myCalendarEvents = calendarService.getMyEvents(userId);
        try {
            String mycalEventsJson = objectMapper.writeValueAsString(myCalendarEvents);

            model.addAttribute("userId", userId);
            model.addAttribute("mycalEvents", mycalEventsJson.replace("'", "\\'"));
            // formattedDate 설정
            String formattedDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            model.addAttribute("formattedDate", formattedDate);

    } catch (Exception e) {
            log.error("Error converting events to JSON", e);
        }
        return "schedule/calendar/calendar";
    }
}
//                    .replaceAll("\"", "\\\\\""); // 이스케이프 처리 Json
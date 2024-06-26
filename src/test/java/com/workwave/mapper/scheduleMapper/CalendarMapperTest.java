//package com.workwave.mapper.scheduleMapper;
//
//import com.workwave.dto.schedule_dto.request.CalendarsDto;
//import org.junit.jupiter.api.DisplayName;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//
//import java.util.List;
//import static org.junit.jupiter.api.Assertions.*;
//
//@SpringBootTest
//class CalendarMapperTest {
//    @Autowired
//    CalendarMapper calendarMapper;
//
//    @Test
//    @DisplayName("search all team calendar id")
//    void getCalendar() {
//        //given
//        String userId = "user1";
//        //when
//       List<CalendarsDto> calendars = calendarMapper.getCalendars(userId);
//        //then
//        assertNotNull(calendars); // calendars 리스트가 null이 아닌지 확인
//
//        // 예상되는 캘린더 개수를 확인
//        int expectedSize = 1; // 예상되는 캘린더 개수
//        assertEquals(expectedSize, calendars.size(), "캘린더 개수가 예상과 일치하지 않습니다.");
//
//        // 개별 캘린더 DTO 요소 검증
//        CalendarsDto firstCalendar = calendars.get(0);
//        assertEquals(1, firstCalendar.getTCalendarId(), "첫 번째 캘린더의 ID가 예상과 일치하지 않습니다.");
//        assertEquals("Sales Calendar", firstCalendar.getTCalendarName(), "첫 번째 캘린더의 이름이 예상과 일치하지 않습니다.");
//        assertEquals("user1", firstCalendar.getUserId(), "첫 번째 캘린더의 사용자 ID가 예상과 일치하지 않습니다.");
//
//        // 다른 캘린더도 동일한 방식으로 검증
////        CalendarDto secondCalendar = calendars.get(1);
////        assertEquals(2, secondCalendar.getTCalendarId(), "두 번째 캘린더의 ID가 예상과 일치하지 않습니다.");
////        assertEquals("Team Calendar 2", secondCalendar.getTCalendarName(), "두 번째 캘린더의 이름이 예상과 일치하지 않습니다.");
////        assertEquals("user1", secondCalendar.getUserId(), "두 번째 캘린더의 사용자 ID가 예상과 일치하지 않습니다.");
//    }
//
//}

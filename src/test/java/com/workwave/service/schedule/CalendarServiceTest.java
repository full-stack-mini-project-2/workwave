//package com.workwave.service.schedule;
//
//import com.workwave.dto.schedule_dto.request.CalendarsDto;
//import com.workwave.mapper.scheduleMapper.CalendarMapper;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.junit.jupiter.MockitoExtension;
//import org.springframework.boot.test.context.SpringBootTest;
//
//import java.util.Collections;
//import java.util.List;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.Mockito.when;
//
//
//@SpringBootTest
//@ExtendWith(MockitoExtension.class)
//class CalendarServiceTest {
//
//    @Mock
//    private CalendarMapper calendarMapper;
//
//    @InjectMocks
//    private CalendarService calendarService;
//
//    @Test
//    public void testGetMyCalendars() {
//        // given
//        String userId = "testUserId";
//        CalendarsDto calendarsDto = new CalendarsDto(1, "Test Calendar", userId);
//        List<CalendarsDto> expectedCalendars = Collections.singletonList(calendarsDto);
//
//        // when
//        when(calendarMapper.getCalendars(userId)).thenReturn(expectedCalendars);
//
//        // then
//        List<CalendarsDto> actualCalendars = calendarService.getMyCalendars(userId);
//        assertEquals(expectedCalendars, actualCalendars);
//        assertEquals(1, actualCalendars.get(0).getTCalendarId());
//    }
//
//
//}
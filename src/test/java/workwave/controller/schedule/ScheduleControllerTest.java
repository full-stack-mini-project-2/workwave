package workwave.controller.schedule;

import com.workwave.entity.*;
import com.workwave.mapper.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class ScheduleControllerTest {

        @Autowired
        NoticeMapper noticeMapper;
        @Autowired
        TodoListMapper todoListMapper;
        @Autowired
        TeamTodoListMapper teamTodoListMapper;
        @Autowired
        CalendarMapper calendarMapper;
        @Autowired
        TeamCalendarMapper teamCalendarMapper;

        @Test
        @DisplayName("Insert test data for notice, todolist, teamtodolist, calendar, and teamcalendar")
        void bulkInsert() {
            // Notice 데이터 추가
            for (int i = 1; i <= 10; i++) {
                Notice notice = Notice.builder()
                        .userId("user" + i)
                        .noticeTitle("Notice Title " + i)
                        .noticeContent("Notice Content " + i)
                        .attachment("attachment" + i + ".jpg")
                        .noticeColorIndexId((int) (Math.random() * 10 + 1))
                        .teamEventDate(2023-12-01)
                        .departmentId("dept" + i)
                        .build();

                noticeMapper.save(notice);
            }

            // TodoList 데이터 추가
            for (int i = 1; i <= 10; i++) {
                TodoList todoList = TodoList.builder()
                        .todoContent("Todo Content " + i)
                        .todoEventDate("2023-12-01")
                        .todoStatus("Pending")
                        .colorIndexId((int) (Math.random() * 10 + 1))
                        .departmentId("dept" + i)
                        .userId("user" + i)
                        .build();

                todoListMapper.save(todoList);
            }

            // TeamTodoList 데이터 추가
            for (int i = 1; i <= 10; i++) {
                TeamTodoList teamTodoList = TeamTodoList.builder()
                        .teamTodoContent("Team Todo Content " + i)
                        .teamEventDate("2023-12-01")
                        .teamTodoStatus("Pending")
                        .colorIndexId((int) (Math.random() * 10 + 1))
                        .departmentId("dept" + i)
                        .userId("user" + i)
                        .build();

                teamTodoListMapper.save(teamTodoList);
            }

            // Calendar 데이터 추가
            for (int i = 1; i <= 10; i++) {
                Calendar calendar = Calendar.builder()
                        .eventTitle("Event Title " + i)
                        .eventDescription("Event Description " + i)
                        .eventDate("2023-12-01")
                        .colorIndexId((int) (Math.random() * 10 + 1))
                        .teamTodoId((int) (Math.random() * 10 + 1))
                        .noticeId((int) (Math.random() * 10 + 1))
                        .departmentId("dept" + i)
                        .userId("user" + i)
                        .todoId((int) (Math.random() * 10 + 1))
                        .build();

                calendarMapper.save(calendar);
            }

            // TeamCalendar 데이터 추가
            for (int i = 1; i <= 10; i++) {
                TeamCalendar teamCalendar = TeamCalendar.builder()
                        .teamEventTitle("Team Event Title " + i)
                        .teamEventDescription("Team Event Description " + i)
                        .teamEventDate("2023-12-01")
                        .colorIndexId((int) (Math.random() * 10 + 1))
                        .teamTodoId((int) (Math.random() * 10 + 1))
                        .noticeId((int) (Math.random() * 10 + 1))
                        .departmentId("dept" + i)
                        .userId("user" + i)
                        .build();

                teamCalendarMapper.save(teamCalendar);
            }
        }
    }

}
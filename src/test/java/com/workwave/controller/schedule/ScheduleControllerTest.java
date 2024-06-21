package com.workwave.controller.schedule;

import com.workwave.entity.schedule.*;
import com.workwave.mapper.boardMapper.NoticeMapper;
import com.workwave.mapper.scheduleMapper.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

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
        @Autowired
        ColorIndexMapper colorIndexMapper;

    @Test
    @DisplayName("컬러 인덱스 더미 데이터 삽입")
    void insertColorDummyData() {
        List<ColorIndex> colors = Arrays.asList(
                new ColorIndex(1, "Pastel Pink", "#FFB3BA"),
                new ColorIndex(2, "Pastel Orange", "#FFDFBA"),
                new ColorIndex(3, "Pastel Yellow", "#FFFFBA"),
                new ColorIndex(4, "Pastel Green", "#BAFFC9"),
                new ColorIndex(5, "Pastel Blue", "#BAE1FF"),
                new ColorIndex(6, "Pastel Purple", "#DABFFF"),
                new ColorIndex(7, "Pastel Peach", "#FFD1BA"),
                new ColorIndex(8, "Pastel Mint", "#BAFFDA"),
                new ColorIndex(9, "Pastel Lavender", "#E3BAFF"),
                new ColorIndex(10, "Pastel Sky", "#BAE7FF")
        );

        for (ColorIndex color : colors) {
            colorIndexMapper.saveColorIndex(color);
        }
    }
    @Test
    @DisplayName("TodoList 테이블에 테스트 데이터 추가")
    void insertTodoListTestData() {
        List<ColorIndex> colorIndexes = Arrays.asList(
                new ColorIndex(11, "Pastel Pink", "#FFB3BA"),
                new ColorIndex(12, "Pastel Orange", "#FFDFBA"),
                new ColorIndex(13, "Pastel Yellow", "#FFFFBA"),
                new ColorIndex(14, "Pastel Green", "#BAFFC9"),
                new ColorIndex(15, "Pastel Blue", "#BAE1FF")
                // Add more pastel colors as needed
        );

        List<TodoList> todoLists = new ArrayList<>();
        Random random = new Random();

        // Assume department and user data already exists in the database
        for (int i = 0; i < 20; i++) {
            ColorIndex colorIndex = colorIndexes.get(random.nextInt(colorIndexes.size()));
            TodoList todoList = new TodoList();
            todoList.setTodoContent("Todo Content " + i);
            todoList.setTodoDate(LocalDate.now().plusDays(i));
            todoList.setColorIndexId(colorIndex.getColorIndexId());
            todoList.setUserId("user1"); // 예제에서 user1 사용자 ID로 설정

            todoLists.add(todoList);
        }

        todoLists.forEach(todoListMapper::saveTodoList); // TodoListMapper에서 saveTodoList 메서드가 TodoList를 저장하는 메서드라고 가정
    }

    @Test
    @DisplayName("TeamTodoList 테이블에 테스트 데이터 추가")
    void insertTeamTodoListTestData() {
        List<ColorIndex> colorIndexes = Arrays.asList(
                new ColorIndex(16, "Pastel Purple", "#DABFFF"),
                new ColorIndex(17, "Pastel Peach", "#FFD1BA"),
                new ColorIndex(18, "Pastel Mint", "#BAFFDA"),
                new ColorIndex(19, "Pastel Lavender", "#E3BAFF"),
                new ColorIndex(20, "Pastel Sky", "#BAE7FF")
                // Add more pastel colors as needed
        );

        List<TeamTodoList> teamTodoLists = new ArrayList<>();
        Random random = new Random();

        // Assume department and user data already exists in the database
        for (int i = 0; i < 20; i++) {
            ColorIndex colorIndex = colorIndexes.get(random.nextInt(colorIndexes.size()));
            TeamTodoList teamTodoList = new TeamTodoList();
            teamTodoList.setTeamTodoContent("Team Todo Content " + i);
            teamTodoList.setTeamTodoDate(LocalDate.now().plusDays(i));
            teamTodoList.setColorIndexId(colorIndex.getColorIndexId());
            teamTodoList.setUserId("user1"); // 예제에서 user1 사용자 ID로 설정

            teamTodoLists.add(teamTodoList);
        }

        teamTodoLists.forEach(teamTodoListMapper::saveTeamTodoList); // TeamTodoListMapper에서 saveTeamTodoList 메서드가 TeamTodoList를 저장하는 메서드라고 가정
    }

    @Test
    @DisplayName("Calendar 테이블에 테스트 데이터 추가")
    void insertCalendarTestData() {
        List<ColorIndex> colorIndexes = Arrays.asList(
                new ColorIndex(11, "Pastel Pink", "#FFB3BA"),
                new ColorIndex(12, "Pastel Orange", "#FFDFBA"),
                new ColorIndex(13, "Pastel Yellow", "#FFFFBA"),
                new ColorIndex(14, "Pastel Green", "#BAFFC9"),
                new ColorIndex(15, "Pastel Blue", "#BAE1FF")
                // Add more pastel colors as needed
        );

        List<Calendar> calendars = new ArrayList<>();
        Random random = new Random();

        // Assume department and user data already exists in the database
        for (int i = 0; i < 20; i++) {
            ColorIndex colorIndex = colorIndexes.get(random.nextInt(colorIndexes.size()));
            Calendar calendar = new Calendar();
            calendar.setTeamDate(LocalDate.now().plusDays(i));
            calendar.setEventType("Meeting");
            calendar.setEventId(i + 1);
            calendar.setTodoDate(LocalDate.now().plusDays(i));
            calendar.setEventDate(LocalDate.now().plusDays(i));
            calendar.setColorIndexId(colorIndex.getColorIndexId());
            calendar.setUserId("user1"); // 예제에서 user1 사용자 ID로 설정

            calendars.add(calendar);
        }

        calendars.forEach(calendarMapper::saveCalendar); // CalendarMapper에서 saveCalendar 메서드가 Calendar를 저장하는 메서드라고 가정
    }






}

package com.workwave.controller.schedule;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/")
public class ScheduleController {

    @GetMapping("/calendar")
    public String calendar(Model model) {

        log.info("TRY to access calendar");
        return "schedule/calendar/calendar"; // 이 부분이 실제 JSP 파일의 경로를 나타냅니다.
    }
    @GetMapping("/todoList")
    public String todolist(Model model) {

        log.info("TRY to access todoList");
        return "schedule/todolist/todoList";
    }
}

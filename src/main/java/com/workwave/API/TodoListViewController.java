package com.workwave.API;

import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.TodoListService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/viewTodo")
public class TodoListViewController {

        private final TodoListService todoListService;

        // 개인 투두리스트 페이지
        @GetMapping("/personal/{userId}")
        public String getPersonalTodos(@PathVariable String userId, Model model) {
            List<TodoList> todos = todoListService.findByUserId(userId);
            model.addAttribute("todos", todos);
            model.addAttribute("userId", userId);
            return "schedule/todoList/personalTodoList";
        }

        // 팀 투두리스트 페이지
        @GetMapping("/team/{departmentId}")
        public String getTeamTodos(@PathVariable String departmentId, Model model) {
            List<TeamTodoList> teamTodos = todoListService.findTeamTodosByDepartmentId(departmentId);
            model.addAttribute("teamTodos", teamTodos);
            model.addAttribute("departmentId", departmentId);
            return "schedule/todoList/teamTodoList";
        }
    }

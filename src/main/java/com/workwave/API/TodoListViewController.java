package com.workwave.API;

import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.TodoListService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/viewTodo")
public class TodoListViewController {

    private final TodoListService todoListService;

    // 개인의 투두리스트 조회 페이지
    @GetMapping("/personal/{userId}")
    public String getMyPersonalTodos(@PathVariable String userId, Model model) {
        List<TodoList> personalTodos = todoListService.findPersonalTodosByUserId(userId);
        model.addAttribute("personalTodos", personalTodos);
        return "schedule/todoList/personalTodoList"; // personal-todos.html로 매핑
    }

    // 개인 투두리스트 추가 페이지
    @GetMapping("/personal/add")
    public String showAddPersonalTodoForm(Model model) {
        model.addAttribute("todoList", new TodoList());
        return "add-personal-todo"; // add-personal-todo.html로 매핑
    }

    // 개인 투두리스트 추가 처리
    @PostMapping("/personal/add")
    public String addPersonalTodo(@ModelAttribute TodoList todoList) {
        todoListService.insertPersonalTodo(todoList);
        return "redirect:/todos/personal?userId=" + todoList.getUserId();
    }

    // 개인 투두리스트 수정 페이지
    @GetMapping("/personal/edit/{todoId}")
    public String showEditPersonalTodoForm(@PathVariable int todoId, Model model) {
        TodoList todoList = todoListService.findPersonalTodoById(todoId);
        model.addAttribute("todoList", todoList);
        return "edit-personal-todo"; // edit-personal-todo.html로 매핑
    }

    // 개인 투두리스트 수정 처리
    @PostMapping("/personal/edit/{todoId}")
    public String editPersonalTodo(@PathVariable int todoId, @ModelAttribute TodoList todoList) {
        todoList.setTodoId(todoId);
        todoListService.updatePersonalTodo(todoList);
        return "redirect:/todos/personal?userId=" + todoList.getUserId();
    }

    // 개인 투두리스트 삭제 처리
    @GetMapping("/personal/delete/{todoId}")
    public String deletePersonalTodo(@PathVariable int todoId, @RequestParam String userId) {
        todoListService.deletePersonalTodo(todoId);
        return "redirect:/todos/personal?userId=" + userId;
    }

    // 팀 투두리스트 조회 페이지
    @GetMapping("/team")
    public String getTeamTodos(@RequestParam String departmentId, Model model) {
        List<TeamTodoList> teamTodos = todoListService.findTeamTodosByDepartmentId(departmentId);
        model.addAttribute("teamTodos", teamTodos);
        return "team-todos"; // team-todos.html로 매핑
    }

    // 팀 투두리스트 추가 페이지
    @GetMapping("/team/add")
    public String showAddTeamTodoForm(Model model) {
        model.addAttribute("teamTodoList", new TeamTodoList());
        return "add-team-todo"; // add-team-todo.html로 매핑
    }

    // 팀 투두리스트 추가 처리
    @PostMapping("/team/add")
    public String addTeamTodo(@ModelAttribute TeamTodoList teamTodoList) {
        todoListService.insertTeamTodo(teamTodoList);
        return "redirect:/todos/team?departmentId=" + teamTodoList.getDepartmentId();
    }

    // 팀 투두리스트 수정 페이지
    @GetMapping("/team/edit/{teamTodoId}")
    public String showEditTeamTodoForm(@PathVariable int teamTodoId, Model model) {
        TeamTodoList teamTodoList = todoListService.findTeamTodoById(teamTodoId);
        model.addAttribute("teamTodoList", teamTodoList);
        return "edit-team-todo"; // edit-team-todo.html로 매핑
    }

    // 팀 투두리스트 수정 처리
    @PostMapping("/team/edit/{teamTodoId}")
    public String editTeamTodo(@PathVariable int teamTodoId, @ModelAttribute TeamTodoList teamTodoList) {
        teamTodoList.setTeamTodoId(teamTodoId);
        todoListService.updateTeamTodo(teamTodoList);
        return "redirect:/todos/team?departmentId=" + teamTodoList.getDepartmentId();
    }

    // 팀 투두리스트 삭제 처리
    @GetMapping("/team/delete/{teamTodoId}")
    public String deleteTeamTodo(@PathVariable int teamTodoId, @RequestParam String departmentId) {
        todoListService.deleteTeamTodo(teamTodoId);
        return "redirect:/todos/team?departmentId=" + departmentId;
    }
}

package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDto.request.TodoListDTO;
import com.workwave.service.schedule.TodoListService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/todos")
public class TodoListController {
    @Autowired
    private TodoListService todoListService;

    // todolist 에 새로운 값 추가하기
    @GetMapping
    public String getAllTodoLists(Model model) {
        List<TodoListDTO> todoLists = todoListService.getAllTodoLists();
        model.addAttribute("todoLists", todoLists);
        return "schedule/todoList/todoList";
    }

    @GetMapping("/{id}") //pathvariable 뜻이 뭐지??
    public String getTodoListById(@PathVariable int id, Model model) {
        TodoListDTO todoList = todoListService.getTodoListById(id);
        model.addAttribute("todoList", todoList);
        return "todoList/todoDetail";
    }

    @PostMapping
    public String insertTodoList(TodoListDTO todoList) {
        todoListService.insertTodoList(todoList);
        return "redirect:/todos";
    }

    @PutMapping("/{id}")
    public String updateTodoList(@PathVariable int id, TodoListDTO todoList) {
        todoList.setTodo_id(id);
        todoListService.updateTodoList(todoList);
        return "redirect:/todos";
    }

    @DeleteMapping("/{id}")
    public String deleteTodoList(@PathVariable int id) {
        todoListService.deleteTodoList(id);
        return "redirect:/todos";
    }

}

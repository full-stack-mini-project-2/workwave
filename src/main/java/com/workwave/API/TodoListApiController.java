package com.workwave.API;

import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.TodoListService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.List;


@Slf4j
@RestController
@RequestMapping("api/todos")
public class TodoListApiController {

        private final TodoListService todoListService;

        public TodoListApiController(TodoListService todoListService) {
            this.todoListService = todoListService;
        }

        @GetMapping("/personal/{userId}")
        public List<TodoList> getPersonalTodos(@PathVariable String userId) {
            return todoListService.findByUserId(userId);
        }

        @GetMapping("/team/{departmentId}")
        public List<TeamTodoList> getTeamTodos(@PathVariable String departmentId) {
            return todoListService.findTeamTodosByDepartmentId(departmentId);
        }

    @PostMapping("/personal")
    public void createPersonalTodo(@RequestBody TodoList todoList) {
        todoList.setTodoStatus("inprogress");
        todoList.setTodoCreateAt(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        todoList.setTodoUpdateAt(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        todoList.setColorIndexId(1);
        todoListService.insert(todoList);
    }
        @PutMapping("/personal/{id}")
        public void updatePersonalTodo(@PathVariable int id, @RequestBody TodoList todoList) {
            todoList.setTodoId(id);
            todoListService.update(todoList);
        }

        @DeleteMapping("/personal/{id}")
        public void deletePersonalTodo(@PathVariable int id) {
            todoListService.delete(id);
        }

    @PostMapping("/team")
    public void createTeamTodo(@RequestBody TeamTodoList teamTodoList) {
        teamTodoList.setTeamTodoStatus("inprogress");
        teamTodoList.setTeamTodoCreateAt(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        teamTodoList.setTeamTodoUpdateAt(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        teamTodoList.setColorIndexId(1);
        todoListService.insertTeamTodo(teamTodoList);
    }

        @PutMapping("/team/{id}")
        public void updateTeamTodo(@PathVariable int id, @RequestBody TeamTodoList teamTodoList) {
            teamTodoList.setTeamTodoId(id);
            todoListService.updateTeamTodo(teamTodoList);
        }

        @DeleteMapping("/team/{id}")
        public void deleteTeamTodo(@PathVariable int id) {
            todoListService.deleteTeamTodo(id);
        }
    }



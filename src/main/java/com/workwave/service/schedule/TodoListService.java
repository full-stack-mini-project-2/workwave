package com.workwave.service.schedule;

import com.workwave.dto.scheduleDTO.request.TodoListDto;
import com.workwave.mapper.scheduleMapper.TodoListMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoListService {
    private final TodoListMapper todoListMapper;

    public TodoListService(TodoListMapper todoListMapper) {
        this.todoListMapper = todoListMapper;
    }

    public List<TodoListDto> getAllTodoLists() {
        return todoListMapper.getAllTodoLists();
    }

    public TodoListDto getTodoListById(int todo_id) {
        return todoListMapper.getTodoListById(todo_id);
    }

    public void insertTodoList(TodoListDto todoList) {
        todoListMapper.insertTodoList(todoList);
    }

    public void updateTodoList(TodoListDto todoList) {
        todoListMapper.updateTodoList(todoList);
    }

    public void deleteTodoList(int todo_id) {
        todoListMapper.deleteTodoList(todo_id);
    }

}

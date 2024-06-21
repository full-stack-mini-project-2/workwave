package com.workwave.service.schedule;

import com.workwave.dto.scheduleDto.request.TodoListDTO;
import com.workwave.mapper.scheduleMapper.TodoListMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoListService {
    private final TodoListMapper todoListMapper;

    public TodoListService(TodoListMapper todoListMapper) {
        this.todoListMapper = todoListMapper;
    }

    public List<TodoListDTO> getAllTodoLists() {
        return todoListMapper.getAllTodoLists();
    }

    public TodoListDTO getTodoListById(int todo_id) {
        return todoListMapper.getTodoListById(todo_id);
    }

    public void insertTodoList(TodoListDTO todoList) {
        todoListMapper.insertTodoList(todoList);
    }

    public void updateTodoList(TodoListDTO todoList) {
        todoListMapper.updateTodoList(todoList);
    }

    public void deleteTodoList(int todo_id) {
        todoListMapper.deleteTodoList(todo_id);
    }

}

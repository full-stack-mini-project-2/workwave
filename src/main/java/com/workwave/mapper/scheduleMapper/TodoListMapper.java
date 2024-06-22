package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.TodoListDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TodoListMapper {
    List<TodoListDTO> getAllTodoLists();
    TodoListDTO getTodoListById(int todo_id);
    void insertTodoList(TodoListDTO todoList);
    void updateTodoList(TodoListDTO todoList);
    void deleteTodoList(int todo_id);
}

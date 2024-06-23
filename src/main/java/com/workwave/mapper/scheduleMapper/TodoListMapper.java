package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.TodoListDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TodoListMapper {
    List<TodoListDto> getAllTodoLists();
    TodoListDto getTodoListById(int todo_id);
    void insertTodoList(TodoListDto todoList);
    void updateTodoList(TodoListDto todoList);
    void deleteTodoList(int todo_id);
}

package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.AllMyTodoListDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TodoListMapper {
    List<AllMyTodoListDto> getAllTodoLists();
    AllMyTodoListDto getTodoListById(int todo_id);
    void insertTodoList(AllMyTodoListDto todoList);
    void updateTodoList(AllMyTodoListDto todoList);
    void deleteTodoList(int todo_id);
}

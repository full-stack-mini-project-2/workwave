package com.workwave.mapper;

import com.workwave.entity.TodoList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TodoListMapper {
    boolean save(TodoList todoList);
}

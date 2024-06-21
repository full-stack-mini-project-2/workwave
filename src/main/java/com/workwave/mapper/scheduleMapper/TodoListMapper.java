package com.workwave.mapper.scheduleMapper;

import com.workwave.entity.schedule.TodoList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TodoListMapper {
    boolean save(TodoList todoList);
}

package com.workwave.mapper;

import com.workwave.entity.TeamTodoList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TeamTodoListMapper {
    boolean save(TeamTodoList teamTodoList);
}

package com.workwave.mapper.scheduleMapper;

import com.workwave.entity.schedule.TeamTodoList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TeamTodoListMapper {
    boolean save(TeamTodoList teamTodoList);
}

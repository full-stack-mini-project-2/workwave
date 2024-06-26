package com.workwave.service.schedule;

import com.workwave.dto.schedule_dto.request.AllMyTodoListDto;
import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.entity.schedule.TodoList;
import com.workwave.mapper.scheduleMapper.TodoListMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class TodoListService {
    private final TodoListMapper todoListMapper;


    //개인 투두리스트 모든 유저 모든 목록 전체 조회
    public List<TodoList> findAll() {
        return todoListMapper.findAll();
    }

    // 특정 개인의 투두리스트 목록 하나 조회
    public TodoList findById(int todoId) {
        return todoListMapper.findById(todoId);
    }

    // 개인 투두리스트 추가
    public void insert(TodoList todoList) {
        todoListMapper.insert(todoList);
    }

    //개인 투두리스트 수정
    public void update(TodoList todoList) {
        todoListMapper.update(todoList);
    }

    // 개인 투두리스트 목록 하나 삭제
    public void delete(int todoId) {
        todoListMapper.delete(todoId);
    }

    //개인별 투두리스트 목록 전체 조회
    public List<TodoList> findByUserId(String userId) {
        return todoListMapper.findByUserId(userId);
    }

    //모든 팀 모든 투두리스트 목록 조회
    public List<TeamTodoList> findAllTeamTodos() {
        return todoListMapper.findAllTeamTodos();
    }

    //특정 팀의 모든 투두리스트 목록 조회
    public TeamTodoList findTeamTodoById(int teamTodoId) {
        return todoListMapper.findTeamTodoById(teamTodoId);
    }

    // 팀 투두리스트 추가
    public void insertTeamTodo(TeamTodoList teamTodoList) {
        todoListMapper.insertTeamTodo(teamTodoList);
    }

    // 팀 투두리스트 수정
    public void updateTeamTodo(TeamTodoList teamTodoList) {
        todoListMapper.updateTeamTodo(teamTodoList);
    }

    //팀 투두리스트 삭제
    public void deleteTeamTodo(int teamTodoId) {
        todoListMapper.deleteTeamTodo(teamTodoId);
    }

    //부서아이디로 팀 투두리스트 목록 조회
    public List<TeamTodoList> findTeamTodosByDepartmentId(String departmentId) {
        return todoListMapper.findTeamTodosByDepartmentId(departmentId);
    }

}

package com.workwave.API;

import com.workwave.dto.user.LoginUserInfoListDto;
import com.workwave.entity.schedule.TeamTodoList;
import com.workwave.entity.schedule.TodoList;
import com.workwave.service.schedule.TodoListService;
import com.workwave.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("api/todos")
public class TodoListApiController {

    private final TodoListService todoListService;

    // 개인의 투두리스트 목록 조회
    @GetMapping("/personal")
    public ResponseEntity<List<TodoList>> getPersonalTodos(HttpSession session) {

        String userId = LoginUtil.getLoggedInUserAccount(session);
        if (userId == null) {
            throw new RuntimeException("User is not logged in");
        }
        try {
            List<TodoList> personalTodos = todoListService.findPersonalTodosByUserId(userId);
            return (ResponseEntity<List<TodoList>>) personalTodos;
        } catch (Exception e) {
            log.error("Error fetching events for user: " + userId, e);
            throw new RuntimeException("Error fetching events");
        }
    }


    //개인의 특정 투두리스트 조회
    @GetMapping("/personal/aTodo/{todoId}")
    public ResponseEntity<TodoList> getPersonalOneTodos(@PathVariable int todoId) {
        TodoList myOneTodo = todoListService.findMyTodoById(todoId);
        return ResponseEntity.ok(myOneTodo);
    }




    // 개인 투두리스트 추가
    @PostMapping("/personal")
    public ResponseEntity<TodoList> createPersonalTodo(@RequestBody TodoList todoList) {
        todoListService.insertPersonalTodo(todoList);
        return ResponseEntity.ok(todoList); // 또는 생성된 TodoList 객체를 반환할 수 있습니다.
    }


    // 개인 투두리스트 수정
    @PutMapping("/personal/{todoId}")
    public ResponseEntity<TodoList> updatePersonalTodo(
            @PathVariable int todoId,
            @RequestBody TodoList updatedTodoList) {
        TodoList existingTodoList = todoListService.findMyTodoById(todoId);

        if (existingTodoList == null) {
            return ResponseEntity.notFound().build();
        }

        // Update fields based on updatedTodoList
        existingTodoList.setTodoContent(updatedTodoList.getTodoContent());
        existingTodoList.setTodoStatus(updatedTodoList.getTodoStatus());
        existingTodoList.setTodoUpdateAt(new Timestamp(System.currentTimeMillis()).toLocalDateTime());
        // Add more fields as needed

        todoListService.updatePersonalTodo(existingTodoList);

        return ResponseEntity.ok(existingTodoList);
    }
//    @PutMapping("/personal/{todoId}")
//    public ResponseEntity<TodoList> updatePersonalTodo(
//            @PathVariable int todoId,
//            @RequestBody TodoList todoList) {
//        todoListService.updatePersonalTodo(todoList);
//        return ResponseEntity.ok(todoList);
//    }

    // 개인 투두리스트 삭제
    @DeleteMapping("/personal/{todoId}")
    public ResponseEntity<Void> deletePersonalTodo(@PathVariable int todoId) {
        todoListService.deletePersonalTodo(todoId);
        return ResponseEntity.noContent().build();
    }

    // 팀 투두리스트 조회
    @GetMapping("/team/aTeamTodos")
    public ResponseEntity<List<TeamTodoList>> findTeamTodosByDepartmentId( HttpSession session) {

        //세션으로 팀 아이디 조회
        List<LoginUserInfoListDto> loggedInUserInfoList = LoginUtil.getLoggedInUserInfoList(session);

        if (loggedInUserInfoList == null || loggedInUserInfoList.isEmpty()) {
            throw new RuntimeException("User is not logged in"); // 로그인 안된 경우 예외 처리
        }
        try {
            // 예시로 첫 번째 사용자의 departmentId 가져오기
            String departmentId = loggedInUserInfoList.get(0).getDepartmentId();
            //팀 아이디로 투두리스트 조회
            List<TeamTodoList> teamTodos = todoListService.findTeamTodosByDepartmentId(departmentId);
            return ResponseEntity.ok(teamTodos);
        } catch (Exception e) {

            // 제대로 서버 전달이 안되었을 경우 에러 메시지
            log.error("Error fetching events for user: " + loggedInUserInfoList, e);
            throw new RuntimeException("Error fetching events");
        }
    }

    // 팀 투두리스트 추가
    @PostMapping("/team")
    public ResponseEntity<Void> insertTeamTodo(@RequestBody TeamTodoList teamTodoList) {
        todoListService.insertTeamTodo(teamTodoList);
        return ResponseEntity.noContent().build();
    }

    // 팀 투두리스트 수정
    @PutMapping("/team/{teamTodoId}")
    public ResponseEntity<Void> updateTeamTodo(
            @PathVariable int teamTodoId,
            @RequestBody TeamTodoList teamTodoList) {
        teamTodoList.setTeamTodoId(teamTodoId);
        todoListService.updateTeamTodo(teamTodoList);
        return ResponseEntity.noContent().build();
    }

    // 팀 투두리스트 삭제
    @DeleteMapping("/team/{teamTodoId}")
    public ResponseEntity<Void> deleteTeamTodo(@PathVariable int teamTodoId) {
        todoListService.deleteTeamTodo(teamTodoId);
        return ResponseEntity.noContent().build();
    }

}




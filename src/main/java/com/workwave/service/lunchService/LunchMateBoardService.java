package com.workwave.service.lunchService;

import com.workwave.common.boardpage.Search;
import com.workwave.common.lunchpage.LunchPage;
import com.workwave.entity.LunchMateBoard;
import com.workwave.entity.User;
import com.workwave.mapper.LunchMateBoardMapper;
import com.workwave.mapper.scheduleMapper.TodoListMapper;
import com.workwave.repository.LunchMateBoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class LunchMateBoardService {

    private final LunchMateBoardMapper lunchMateBoardMapper;
    private LunchMateBoardRepository lunchMateBoardRepository;

    @Autowired
    public LunchMateBoardService(LunchMateBoardMapper lunchMateBoardMapper) {
        this.lunchMateBoardMapper = lunchMateBoardMapper;
    }

    // 게시물 목록 조회
    public List<LunchMateBoard> findAll() {
        return lunchMateBoardMapper.findAll();
    }


    // 게시물 등록
    public boolean save(LunchMateBoard lunchMateBoard, User currentUser) {
        lunchMateBoard.setUserId(currentUser.getUserId());  // 작성자를 현재 로그인한 사용자의 userId로 설정
        return lunchMateBoardMapper.save(lunchMateBoard);
    }

//    // 게시물 상세 조회
//    public LunchMateBoard findOne(int lunchPostNumber) {
//        return lunchMateBoardMapper.findOne(lunchPostNumber);
//    }

//    // 게시물 등록
//    public boolean save(LunchMateBoard lunchMateBoard) {
//        return lunchMateBoardMapper.save(lunchMateBoard);
//    } 20240629 수정

    // 게시물 삭제
    public boolean delete(int lunchPostNumber) {
        return lunchMateBoardMapper.delete(lunchPostNumber);
    }

}

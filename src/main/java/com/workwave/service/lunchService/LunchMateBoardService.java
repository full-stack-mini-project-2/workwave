package com.workwave.service.lunchService;

import com.workwave.entity.LunchMateBoard;
import com.workwave.mapper.LunchMateBoardMapper;
import com.workwave.repository.LunchMateBoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@RequiredArgsConstructor
public class LunchMateBoardService {

    private  LunchMateBoardMapper lunchMateBoardMapper;
//    private LunchMateBoardRepository lunchMateBoardRepository;

    @Autowired
    public LunchMateBoardService(LunchMateBoardMapper lunchMateBoardMapper) {
        this.lunchMateBoardMapper = lunchMateBoardMapper;
    }

    // 게시물 목록 조회
    public List<LunchMateBoard> findAll() {
        return lunchMateBoardMapper.findAll();
    }


    // 게시물 등록
    public boolean save(LunchMateBoard lunchMateBoard, String userId) {
        lunchMateBoard.setUserId(userId);  // 작성자를 현재 로그인한 사용자의 userId로 설정
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


    @Transactional
    public void incrementProgressStatus(int lunchPostNumber) {
        System.out.println("🍕🍕🍕🍕🍕🍕🍕");
        System.out.println("🍔lunchPostNumber = " + lunchPostNumber);
        LunchMateBoard board = lunchMateBoardMapper.findOne(lunchPostNumber);
        System.out.println("🍕board = " + board);

        if (board != null) {
            int num = board.getProgressStatus();
            num += 1;

            System.out.println("num = " + num);
            board.setProgressStatus(num);
            System.out.println("board = " + board);

            lunchMateBoardMapper.incrementProgressStatus(String.valueOf(lunchPostNumber));
        } else {
            throw new IllegalArgumentException("Invalid board Id:" + lunchPostNumber);
        }
    }
}

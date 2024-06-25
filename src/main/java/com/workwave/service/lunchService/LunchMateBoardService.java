package com.workwave.service.lunchService;

import com.workwave.entity.LunchMateBoard;
import com.workwave.mapper.LunchMateBoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LunchMateBoardService {

    private final LunchMateBoardMapper lunchMateBoardMapper;

    @Autowired
    public LunchMateBoardService(LunchMateBoardMapper lunchMateBoardMapper) {
        this.lunchMateBoardMapper = lunchMateBoardMapper;
    }

    // 게시물 목록 조회
    public List<LunchMateBoard> findAll() {
        return lunchMateBoardMapper.findAll();
    }

//    // 게시물 상세 조회
//    public LunchMateBoard findOne(int lunchPostNumber) {
//        return lunchMateBoardMapper.findOne(lunchPostNumber);
//    }

    // 게시물 등록
    public boolean save(LunchMateBoard lunchMateBoard) {
        return lunchMateBoardMapper.save(lunchMateBoard);
    }

    // 게시물 삭제
    public boolean delete(int lunchPostNumber) {
        return lunchMateBoardMapper.delete(lunchPostNumber);
    }
}

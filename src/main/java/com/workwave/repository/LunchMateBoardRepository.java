package com.workwave.repository;

import com.workwave.entity.LunchMateBoard;

import java.util.List;
import java.util.Optional;

public interface LunchMateBoardRepository {

    // 게시물 목록 조회
    List<LunchMateBoard> findAll();

    // 게시물 상세 조회
    // LunchMateBoard findOne(int lunchPostNumber);

    // 게시물 등록
    boolean save(LunchMateBoard lunchMateBoard);

    // 게시물 삭제
    boolean delete(int lunchPostNumber);


}

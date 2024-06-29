package com.workwave.mapper;

import com.workwave.common.boardpage.Search;
import com.workwave.entity.LunchMateBoard;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LunchMateBoardMapper {

    // 게시물 목록 조회
    List<LunchMateBoard> findAll();
//
//    // 게시물 상세 조회
//    LunchMateBoard findOne(int lunchPostNumber);

    // 게시물 등록
    boolean save(LunchMateBoard lunchMateBoard);

    // 게시물 삭제
    boolean delete(int lunchPostNumber);

    // 조회수 상승 (예제에서는 사용되지 않지만 필요 시 추가)
    // void upViewCount(int lunchPostNumber);
}

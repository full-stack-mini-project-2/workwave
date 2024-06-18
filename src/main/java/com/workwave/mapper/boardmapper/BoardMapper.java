package com.workwave.mapper.boardmapper;

import com.workwave.common.boardpage.Search;
import com.workwave.entity.board.Board;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    // 게시물 목록 조회
    List<Board> findAll(Search page);

    // 게시물 상세 조회
    Board findOne(long boardId);

    // 게시물 등록
    boolean save(Board board);
    
    // 게시물 삭제
    boolean delete(int boardId);

    // 조회수 상승
//    void upViewCount(int boardId);

    // 총 게시물 수 조회
    int count(Search page);

}

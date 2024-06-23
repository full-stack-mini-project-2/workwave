package com.workwave.mapper.boardmapper;

import com.workwave.entity.board.Reply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {

    // 댓글 목록 조회
    List<Reply> replies(int boardId);

    // 게시물 상세 조회
    Reply findOne(int replyId);

    // 댓글 등록
    boolean save(Reply reply);
//
//    // 게시물 삭제
//    boolean delete(int boardId);
//
//    // 조회수 상승
////    void upViewCount(int boardId);
//
    // 게시물 수정
    boolean update(Reply reply);
//
//    // 총 게시물 수 조회
//    int count(Search page);

}

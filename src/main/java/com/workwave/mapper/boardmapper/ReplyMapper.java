package com.workwave.mapper.boardmapper;

import com.workwave.entity.board.Reply;
import com.workwave.entity.board.SubReply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReplyMapper {

    // 댓글 목록 조회
    List<Reply> replies(int boardId);

    // 댓글 상세 조회
    Reply findOne(int replyId);

    // 댓글 등록
    boolean save(Reply reply);

    // 댓글 수정
    boolean update(Reply reply);

    // 댓글 삭제
    boolean delete(int replyId);

    // 대댓글 목록 조회
    List<SubReply> subReplies(int replyId);

    // 대댓글 등록
    boolean saveSubReply(SubReply subReply);

    // 대댓글 상세 조회
    SubReply findOneSubReply(int subReplyId);

    // 대댓글 수정
    boolean updateSubReply(SubReply subReply);
}

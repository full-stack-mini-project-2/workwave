package com.workwave.service.boardservice;

import com.workwave.common.boardpage.Page;
import com.workwave.common.boardpage.Search;
import com.workwave.dto.boarddto.BoardDetailDto;
import com.workwave.dto.boarddto.BoardListDto;
import com.workwave.dto.boarddto.BoardUpdateDto;
import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.mapper.boardmapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {

    @Autowired
    private final BoardMapper boardMapper;

    public boolean save(BoardWriteDto dto) {

        Board b = dto.toEntity();

        log.info("Saving Board Entity: {}", b);

        return boardMapper.save(b);
    }

    public List<BoardListDto> findAll(Search page) {
        // boardMapper.findAll()이 List<Board>를 반환한다고 가정
        List<Board> boards = boardMapper.findAll(page);

        // Board 객체를 BoardListDto 객체로 변환
        return boards.stream()
                .map(board -> BoardListDto.builder()
                        .boardId(board.getBoardId())
                        .boardTitle(board.getBoardTitle())
                        .userId(board.getUserId())
                        .boardCreatedAt(board.getBoardCreatedAt())
                        .replyCount(board.getReplyCount())
                        .viewCount(board.getViewCount())
                        .likes(board.getLikes())
                        .dislikes(board.getDislikes())
                        .build())
                .collect(Collectors.toList());
    }

    public BoardDetailDto findOne(int boardId) {

        Board b = boardMapper.findOne(boardId);// Board 객체를 가져옴

        log.info(String.valueOf(b));

        if (b != null) {

            return BoardDetailDto.builder()
                    .boardId(b.getBoardId())
                    .userId(b.getUserId())
                    .boardContent(b.getBoardContent())
                    .boardTitle(b.getBoardTitle())
                    .viewCount(b.getViewCount())
                    .likes(b.getLikes())
                    .dislikes(b.getDislikes())
                    .boardCreatedAt(b.getBoardCreatedAt())
                    .boardUpdatedAt(b.getBoardUpdatedAt())
                    .build();

        }

        return null; // 조회된 데이터가 없으면 null 반환
    }

    // 게시물의 갯수를 확인
    public int boardListCount(Search page) {

        return boardMapper.count(page);
    }

    // 게시물 삭제
    public boolean delete(int boardId) {

        return boardMapper.delete(boardId);
    }

    // 게시물 수정
    public Boolean update(BoardUpdateDto dto) {

        Board one = boardMapper.findOne(dto.getBoardId());

        one.setBoardContent(dto.getNewContent());
        one.setBoardUpdatedAt(dto.getBoardUpdatedAt());

        log.info("upadte DTO: {}", one);

        return boardMapper.update(one);
    }

    public Boolean updateViewCount(int boardId){

       return boardMapper.updateViewCount(boardId);

    }

    public Boolean upLikeCount(int boardId) {

        boolean upLikeCount = boardMapper.upLikeCount(boardId);

        return upLikeCount;
    }

    public Boolean upDislikeCount(int boardId){

        boolean upDislikeCount = boardMapper.upDislikeCount(boardId);

        return upDislikeCount;
    }
}

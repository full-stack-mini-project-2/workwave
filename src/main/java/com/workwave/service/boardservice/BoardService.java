package com.workwave.service.boardservice;

import com.workwave.dto.boarddto.BoardListDto;
import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.mapper.boardmapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class BoardService {

    private final BoardMapper boardMapper;

    public boolean save(BoardWriteDto dto) {

        Board b = dto.toEntity();

        log.info("Saving Board Entity: {}", b);

        return boardMapper.save(b);
    }

    public List<BoardListDto> findAll() {
        // boardMapper.findAll()이 List<Board>를 반환한다고 가정
        List<Board> boards = boardMapper.findAll();

        // Board 객체를 BoardListDto 객체로 변환
        return boards.stream()
                .map(board -> BoardListDto.builder()
                        .boardId(board.getBoardId())
                        .boardTitle(board.getBoardTitle())
                        .userId(board.getUserId())
                        .boardCreatedAt(board.getBoardCreateAt())
                        .build())
                .collect(Collectors.toList());
    }

//    public boolean findOne(long boardId) {
//
//        boardMapper.findOne(boardId);
//
//        return false;
//    }
}

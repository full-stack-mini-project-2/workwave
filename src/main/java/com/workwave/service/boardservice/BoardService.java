package com.workwave.service.boardservice;

import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.mapper.boardmapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
@RequiredArgsConstructor
public class BoardService {
    
    private final BoardMapper boardMapper;

    public boolean save(BoardWriteDto dto) {

        Board b = dto.toEntity();

        return boardMapper.save(b);
    }

}

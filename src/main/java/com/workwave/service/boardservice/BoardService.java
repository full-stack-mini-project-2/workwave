package com.workwave.service.boardservice;

import com.workwave.dto.boarddto.BoardWriteDto;
import com.workwave.entity.board.Board;
import com.workwave.mapper.boardmapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

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

}

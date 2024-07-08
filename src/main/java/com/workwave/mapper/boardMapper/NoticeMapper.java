package com.workwave.mapper.boardMapper;

import com.workwave.entity.board.Notice;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
    boolean save(Notice notice);
}

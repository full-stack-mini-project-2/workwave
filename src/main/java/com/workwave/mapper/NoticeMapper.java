package com.workwave.mapper;

import com.workwave.entity.Notice;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
    boolean save(Notice notice);
}

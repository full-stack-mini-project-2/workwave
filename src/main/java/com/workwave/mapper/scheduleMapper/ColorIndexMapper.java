package com.workwave.mapper.scheduleMapper;

import com.workwave.dto.scheduleDTO.request.ColorIndexDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ColorIndexMapper {

    //컬러 인덱스 리스트 가져오기
    List<ColorIndexDTO> getAllColorIndices();
    //컬러 아이디로 인덱스 구하기
    ColorIndexDTO getColorIndexById(int color_index_id);
    //컬러 인덱스 추가하기 (팔레트 수정)
    void insertColorIndex(ColorIndexDTO colorIndex);
    //컬러 인덱스 수정하기 (팔레트 수정)
    void updateColorIndex(ColorIndexDTO colorIndex);
    //컬러 인덱스 삭제하기 (팔레트 삭제)
    void deleteColorIndex(int color_index_id);
}

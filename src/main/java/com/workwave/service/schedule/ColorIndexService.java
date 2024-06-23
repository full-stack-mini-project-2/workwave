package com.workwave.service.schedule;

import com.workwave.dto.scheduleDTO.request.ColorIndexDto;
import com.workwave.mapper.scheduleMapper.ColorIndexMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ColorIndexService {
    private final ColorIndexMapper colorIndexMapper;

    public ColorIndexService(ColorIndexMapper colorIndexMapper) {
        this.colorIndexMapper = colorIndexMapper;
    }

    public List<ColorIndexDto> getAllColorIndices() {
        return colorIndexMapper.getAllColorIndices();
    }

    public ColorIndexDto getColorIndexById(int color_index_id) {
        return colorIndexMapper.getColorIndexById(color_index_id);
    }

    public void insertColorIndex(ColorIndexDto colorIndex) {
        colorIndexMapper.insertColorIndex(colorIndex);
    }

    public void updateColorIndex(ColorIndexDto colorIndex) {
        colorIndexMapper.updateColorIndex(colorIndex);
    }

    public void deleteColorIndex(int color_index_id) {
        colorIndexMapper.deleteColorIndex(color_index_id);
    }
}

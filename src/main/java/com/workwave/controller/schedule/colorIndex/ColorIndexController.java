package com.workwave.controller.schedule.colorIndex;

import com.workwave.entity.schedule.ColorIndex;
import com.workwave.mapper.scheduleMapper.ColorIndexMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@Slf4j
public class ColorIndexController {

    @Autowired
    private ColorIndexMapper colorIndexMapper;

    @PostMapping("/color")
    public void saveColor(@RequestBody ColorIndex colorIndex) {
        colorIndexMapper.saveColorIndex(colorIndex);
    }

}

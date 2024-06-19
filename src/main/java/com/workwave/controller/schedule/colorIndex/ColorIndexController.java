package com.workwave.controller.schedule.colorIndex;

import com.workwave.mapper.ColorIndexMapper;
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
    public void saveColor(@RequestBody String colorName) {
        colorIndexMapper.saveColor(colorName);
    }

}

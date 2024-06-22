package com.workwave.controller.schedule;

import com.workwave.dto.scheduleDTO.request.ColorIndexDTO;
import com.workwave.service.schedule.ColorIndexService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Slf4j
@RequestMapping("/colors")
public class ColorIndexController {

    @Autowired
    private ColorIndexService colorIndexService;

    @GetMapping("/colorList")
    public String getAllColorIndices(Model model) {
        List<ColorIndexDTO> colorIndices = colorIndexService.getAllColorIndices();
        model.addAttribute("colorIndices", colorIndices);
        return "schedule/colorIndex/colorList";
    }

    @GetMapping("/{id}")
    public String getColorIndexById(@PathVariable int id, Model model) {
        ColorIndexDTO colorIndex = colorIndexService.getColorIndexById(id);
        model.addAttribute("colorIndex", colorIndex);
        return "schedule/colorIndex/colorDetail";
    }

    @PostMapping
    public String insertColorIndex(ColorIndexDTO colorIndex) {
        colorIndexService.insertColorIndex(colorIndex);
        return "redirect:/colors";
    }

    @PutMapping("/{id}")
    public String updateColorIndex(@PathVariable int id, ColorIndexDTO colorIndex) {
        colorIndex.setColor_index_id(id);
        colorIndexService.updateColorIndex(colorIndex);
        return "redirect:/colors";
    }

    @DeleteMapping("/{id}")
    public String deleteColorIndex(@PathVariable int id) {
        colorIndexService.deleteColorIndex(id);
        return "redirect:/colors";
    }

}

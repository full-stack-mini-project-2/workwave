package com.workwave.mapper.traffic;

import com.workwave.dto.traffic.response.trafficInfo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class trafficMapperTest {

    @Autowired
    private com.workwave.mapper.trafficMapper trafficMapper;


    @Test
    @DisplayName("웹에서 데이터를 전송하면 DB에 저장되어야 한다.")
    void save() {
        //given
        trafficInfo build = trafficInfo.builder()
                .station("15역")
                .arrival("방학")
                .departure("쌍문")
                .needTime("15분")
                .build();

        //when
        boolean save = trafficMapper.save(build);

        //then

        assertNotNull(save);
    }


}
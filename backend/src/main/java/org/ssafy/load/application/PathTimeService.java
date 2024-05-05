package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.PathTimeRepository;

@Service
@RequiredArgsConstructor
public class PathTimeService {

    private final PathTimeRepository pathTimeRepository;

}

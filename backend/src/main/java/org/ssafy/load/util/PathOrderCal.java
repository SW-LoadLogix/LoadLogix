package org.ssafy.load.util;

import org.springframework.stereotype.Component;
import org.ssafy.load.dto.Building;

import java.util.Arrays;
import java.util.List;

public class PathOrderCal {
    private static final int INVAILD = 1_000_000_000;
    private final int maxVisit;
    private final int[][] dp;

    private final int[][] pathTimeMatrix;
    private final int buildingNum;
    private final List<Building> buildingList;

    public PathOrderCal(int[][] pathTimeMatrix, int buildingNum, List<Building> buildingList) {
        this.pathTimeMatrix = pathTimeMatrix;
        this.buildingNum = buildingNum;
        this.buildingList = buildingList;
        this.maxVisit = (1 << buildingNum) - 1;
        dp = new int[buildingNum][maxVisit + 1];

        for(int i=0; i<buildingNum; i++) {
            Arrays.fill(dp[i], -1);
        }
    }

    public List<Building> getPathOrder() {
        return getDp(0, 1);
    }

    private int getDp(int from, int visit, List<Integer> orders) {
        //다 방문됬으면 주의사항 체크
        if(visit == maxVisit) {
            if(pathTimeMatrix[from][0] == 0) return INVAILD;
            return pathTimeMatrix[from][0];
        }

        //이미 메모이제이션 됬으면
        if(dp[from][visit] != -1) return dp[from][visit];

        //출석
        dp[from][visit] = INVAILD;
        int

        for(int to=0; to<buildingNum; to++) {
            if(pathTimeMatrix[from][to] != 0 && (visit & (1<<to)) == 0) {
                dp[from][visit] = Math.min(dp[from][visit], getDp(to, visit | (1<<to)) + pathTimeMatrix[from][to]);
            }
        }
        return dp[from][visit];
    }
}

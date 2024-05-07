package org.ssafy.load.util;

import lombok.extern.slf4j.Slf4j;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.domain.BuildingEntity;
import org.ssafy.load.dto.Building;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Slf4j
public class PathOrderCal {
    private static final int INVALID = 1_000_000_000;
    private int maxVisit;
    private int[][] dp;

    private final int[][] pathTimeMatrix;
    private final int buildingNum;
    private final List<BuildingEntity> buildingList;

    public PathOrderCal(int[][] pathTimeMatrix, int buildingNum, List<BuildingEntity> buildingList) {
        if(buildingNum > 20) {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR, "N of TSP algorithm cannot be more than 20");
        }
        this.pathTimeMatrix = pathTimeMatrix;
        this.buildingNum = buildingNum;
        this.buildingList = buildingList;
    }

    public List<BuildingEntity> getPathOrder() {
        maxVisit = (1 << buildingNum) - 1;
        dp = new int[buildingNum][maxVisit + 1];
        for(int i=0; i<buildingNum; i++) {
            Arrays.fill(dp[i], -1);
        }

        List<Integer> indexOrderList = new ArrayList<>();
        List<BuildingEntity> orderedBuildingList = new ArrayList<>();

        getDp(0, 1, indexOrderList); //Building 0 is start vertex
        indexOrderList.add(0);

        for(int index : indexOrderList.reversed()) {
            orderedBuildingList.add(buildingList.get(index));
        }
        return orderedBuildingList;
    }

    private int getDp(int from, int visit, List<Integer> indexOrderList) {
        if(visit == maxVisit) {
            if(pathTimeMatrix[from][0] == 0) return INVALID;
            return pathTimeMatrix[from][0];
        }

        if(dp[from][visit] != -1) return dp[from][visit];

        dp[from][visit] = INVALID;
        int targetTo = 0;

        for(int to=1; to<buildingNum; to++) {
            if(pathTimeMatrix[from][to] != 0 && (visit & (1<<to)) == 0) {
                int value = getDp(to, visit | (1<<to), indexOrderList) + pathTimeMatrix[from][to];
                if(dp[from][visit] > value) {
                    targetTo = to;
                    dp[from][visit] = value;
                }
            }
        }
        indexOrderList.add(targetTo);
        return dp[from][visit];
    }
}

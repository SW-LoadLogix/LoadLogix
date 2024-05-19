package org.ssafy.load.util;

import lombok.extern.slf4j.Slf4j;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.domain.BuildingEntity;

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

        List<Integer> path = new ArrayList<>();
        getDp(0, 1); //Building 0 is start vertex
        getPath(0, 1, path);

        List<BuildingEntity> orderedBuildingList = new ArrayList<>();
        for(int num : path) {
            orderedBuildingList.add(buildingList.get(num));
        }
        return orderedBuildingList;
    }

    private int getDp(int from, int visit) {
        if(visit == maxVisit) {
            if(pathTimeMatrix[from][0] == 0) return INVALID;
            return pathTimeMatrix[from][0];
        }

        if(dp[from][visit] != -1) return dp[from][visit];

        dp[from][visit] = INVALID;

        for(int to=1; to<buildingNum; to++) {
            if(pathTimeMatrix[from][to] != 0 && (visit & (1<<to)) == 0) {
                dp[from][visit] = Math.min(dp[from][visit], getDp(to, visit | (1<<to)) + pathTimeMatrix[from][to]);
            }
        }
        return dp[from][visit];
    }

    private void getPath(int from, int visit, List<Integer> path) {
        path.add(from);

        if(visit == maxVisit) {
            return;
        }

        int minDuration = INVALID;
        int minTo = 1;

        for(int to=1; to<buildingNum; to++) {
            if((visit & (1<<to)) != 0) {
                continue;
            }

            if(pathTimeMatrix[from][to] + dp[to][visit | (1<<to)] < minDuration) {
                minDuration = pathTimeMatrix[from][to] + dp[to][visit | (1<<to)];
                minTo = to;
            }
        }

        getPath(minTo, visit | (1 << minTo), path);
    }
}

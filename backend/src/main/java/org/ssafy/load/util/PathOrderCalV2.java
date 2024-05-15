package org.ssafy.load.util;

import com.google.ortools.Loader;
import com.google.ortools.constraintsolver.*;
import jakarta.persistence.criteria.CriteriaBuilder;
import lombok.extern.slf4j.Slf4j;
import org.ssafy.load.common.dto.ErrorCode;
import org.ssafy.load.common.exception.CommonException;
import org.ssafy.load.domain.BuildingEntity;

import java.util.ArrayList;
import java.util.List;

@Slf4j
public class PathOrderCalV2 {
    private final int[][] distanceMatrix;
    private final int buildingNum;
    private final List<BuildingEntity> buildingList;

    public PathOrderCalV2(int[][] distanceMatrix, int buildingNum, List<BuildingEntity> buildingList) {
        if(buildingNum > 100) {
            throw new CommonException(ErrorCode.INTERNAL_SERVER_ERROR, "N of TSP algorithm cannot be more than 100");
        }
        this.distanceMatrix = distanceMatrix;
        this.buildingNum = buildingNum;
        this.buildingList = buildingList;
    }

    public List<BuildingEntity> getPathOrder() {
        Loader.loadNativeLibraries();
        RoutingIndexManager manager = new RoutingIndexManager(buildingNum, 1, 0);

        RoutingModel routing = new RoutingModel(manager);

        int transitCallbackIndex = routing.registerTransitCallback((long fromIndex, long toIndex) -> {
            int fromNode = manager.indexToNode(fromIndex);
            int toNode = manager.indexToNode(toIndex);
            return distanceMatrix[fromNode][toNode];
        });

        routing.setArcCostEvaluatorOfAllVehicles(transitCallbackIndex);

        RoutingSearchParameters searchParameters = main
                .defaultRoutingSearchParameters()
                .toBuilder()
                .setFirstSolutionStrategy(FirstSolutionStrategy.Value.PATH_CHEAPEST_ARC)
                .build();

        Assignment solution = routing.solveWithParameters(searchParameters);

        List<Integer> routes = get_routes(routing, manager, solution);
        List<BuildingEntity> orderedBuildingList = new ArrayList<>();
        for(int route : routes) {
            orderedBuildingList.add(buildingList.get(route));
        }
        return orderedBuildingList;
    }

    private List<Integer> get_routes(RoutingModel routing, RoutingIndexManager manager, Assignment solution) {
        List<Integer> routes = new ArrayList<>();

        log.info("Objective: " + solution.objectiveValue() + "miles");
        log.info("Route:");
        String route = "";
        long index = routing.start(0);
        while (!routing.isEnd(index)) {
            routes.add((int)index);
            route += manager.indexToNode(index) + " -> ";
            index = solution.value(routing.nextVar(index));
        }
        route += manager.indexToNode(routing.end(0));
        log.info(route);
        return routes;
    }
}

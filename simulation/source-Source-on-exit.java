if (!buildingInfos.isEmpty()) {
BuildingDto buildingInfo = buildingInfos.remove(0);
//System.out.println("buildingInfo: "+buildingInfo.toString());
agent.id = buildingInfo.getId();
agent.buildingMain = buildingInfo.getBuildingMain();
agent.buildingSub = buildingInfo.getBuildingSub();
//System.out.println(agent.id+" "+agent.width+" "+agent.buildingMain+" "+agent.buildingSub);
}
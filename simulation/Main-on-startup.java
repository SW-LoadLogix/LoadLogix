//sourcePallets.inject(1);
APIClient client = new APIClient();
try{
buildingInfos = client.getBuildingJuso();
//System.out.println("main:" +buildingInfos);
}catch(Exception e){
		System.out.println(e);
}
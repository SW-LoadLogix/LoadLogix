package org.ssafy.load.application;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.ssafy.load.dao.AddressRepository;
import org.ssafy.load.domain.AddressEntity;
import org.ssafy.load.dto.Address;
import org.ssafy.load.dto.response.BuildingResponse;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AddressService {
    private final AddressRepository addressRepository;

    public List<BuildingResponse> getBuildingJuso(){
        List<AddressEntity> addressList = addressRepository.findAll();
        List<BuildingResponse> buildingList = new ArrayList<>();
        for(AddressEntity entity : addressList){
            System.out.println(entity);
            buildingList.add(BuildingResponse.fromBuilding(entity));
        }
        return buildingList;
    }


}

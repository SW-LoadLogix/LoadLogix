package org.ssafy.load.dto;

import org.ssafy.load.domain.AddressEntity;

public record Address(
        Long id,
        Long dongCode,
        String sidoName,
        String gugunName,
        String dongName,
        int zibunMain,
        int zibunSub,
        Long loadCode,
        int buildingMain,
        int buildingSub
){
    static public Address of(
            Long id,
            Long dongCode,
            String sidoName,
            String gugunName,
            String dongName,
            int zibunMain,
            int zibunSub,
            Long loadCode,
            int buildingMain,
            int buildingSub
    ){
        return new Address(
                id,
                dongCode,
                sidoName,
                gugunName,
                dongName,
                zibunMain,
                zibunSub,
                loadCode,
                buildingMain,
                buildingSub
        );
    }

    static public Address from(AddressEntity entity){
        return Address.of(
                entity.getId(),
                entity.getDongCode(),
                entity.getSidoName(),
                entity.getGugunName(),
                entity.getDongName(),
                entity.getZibunMain(),
                entity.getZibunSub(),
                entity.getLoadCode(),
                entity.getBuildingMain(),
                entity.getBuildingSub()
        );
    }
}

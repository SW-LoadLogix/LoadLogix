package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.ssafy.load.dto.Coordinate;
import org.ssafy.load.dto.request.BuildingRegistRequest;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "building")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BuildingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="dong_code")
    private Long dongCode;  // 법정동코드
    @Column(name="sido_name")
    private String sidoName; // 시도명
    @Column(name="gugun_name")
    private String gugunName;  // 시군구명
    @Column(name="dong_name")
    private String dongName;  // 법정읍면동명
    @Column(name="zibun_main")
    private int zibunMain;  // 지번본번(번지)
    @Column(name="zibun_sub")
    private int zibunSub;  // 지번부번(호)
    @Column(name="load_code")
    private Long loadCode;  // 도로명코드
    @Column(name="building_main")
    private int buildingMain;  // 건물본번
    @Column(name="building_sub")
    private int buildingSub;  // 건물부번
    @Column(name="longitude")
    private Double longitude;
    @Column(name="latitude")
    private Double latitude;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "area_id")
    @OnDelete(action = OnDeleteAction.SET_NULL)
    private AreaEntity area;

    @OneToMany(mappedBy = "building", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<GoodsEntity> goodsEntities;

    static public BuildingEntity of(
            Long id,
            Long dongCode,
            String sidoName,
            String gugunName,
            String dongName,
            int zibunMain,
            int zibunSub,
            Long loadCode,
            int buildingMain,
            int buildingSub,
            double longitude,
            double latitude,
            AreaEntity area,
            List<GoodsEntity> goodsEntities
    ){
        return new BuildingEntity(
                id,
                dongCode,
                sidoName,
                gugunName,
                dongName,
                zibunMain,
                zibunSub,
                loadCode,
                buildingMain,
                buildingSub,
                longitude,
                latitude,
                area,
                goodsEntities
        );
    }

    static public BuildingEntity createNewEntity(BuildingRegistRequest buildingAddressRegistRequest, Coordinate coordinate, AreaEntity area) {
        return of(
                null,
                buildingAddressRegistRequest.dongCode(),
                buildingAddressRegistRequest.sidoName(),
                buildingAddressRegistRequest.gugunName(),
                buildingAddressRegistRequest.dongName(),
                buildingAddressRegistRequest.zibunMain(),
                buildingAddressRegistRequest.zibunSub(),
                buildingAddressRegistRequest.loadCode(),
                buildingAddressRegistRequest.buildingMain(),
                buildingAddressRegistRequest.buildingSub(),
                coordinate.longitude(),
                coordinate.latitude(),
                area,
                null
        );
    }
}
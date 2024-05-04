package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "building_address")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BuildingAddressEntity {
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

    @ManyToOne
    @JoinColumn(name = "area_id", nullable = true)
    @OnDelete(action = OnDeleteAction.SET_NULL)
    private DeliveryAreaEntity deliveryArea;

    @OneToMany(mappedBy = "building_address", cascade = CascadeType.ALL)
    private List<GoodsEntity> goodsEntities = new ArrayList<>();


    static public BuildingAddressEntity of(
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
            DeliveryAreaEntity deliveryArea,
            List<GoodsEntity> goodsEntities
    ){
        return new BuildingAddressEntity(
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
                deliveryArea,
                goodsEntities
        );
    }
}
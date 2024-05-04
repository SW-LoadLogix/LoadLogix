package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "delivery_area")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryAreaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name="area_name")
    private String areaName;
    @Column(name="convey_no")
    private int conveyNo;

    @OneToOne(mappedBy = "delivery_area", cascade = CascadeType.ALL)
    private AreaReadyStatusEntity areaReadyStatus;

    @OneToOne
    @JoinColumn(name = "worker_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private WorkerEntity worker;

    @OneToMany(mappedBy = "delivery_area", cascade = CascadeType.ALL)
    private List<BuildingAddressEntity>  buildingAddressEntities = new ArrayList<>();
    public static DeliveryAreaEntity of(
            Integer id, String area_name,
            int conveyNo,
            AreaReadyStatusEntity areaReadyStatus,
            WorkerEntity worker,
            List<BuildingAddressEntity> buildingAddressEntities
    ){
        return new DeliveryAreaEntity(id, area_name, conveyNo, areaReadyStatus, worker, buildingAddressEntities);
    }
}

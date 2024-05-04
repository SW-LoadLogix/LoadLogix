package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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


    @OneToOne(mappedBy = "deliveryAreaEntity", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private AreaReadyStatusEntity areaReadyStatusEntity;

    public static DeliveryAreaEntity of(Integer id, String areaName, int conveyNo, AreaReadyStatusEntity areaReadyStatusEntity){
        return new DeliveryAreaEntity(id, areaName, conveyNo, areaReadyStatusEntity);
    }

}

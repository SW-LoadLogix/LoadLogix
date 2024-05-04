package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "area_ready_status")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AreaReadyStatusEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Boolean state;
    private int count; // 구역당 할당된 개수

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "area_id")
    private DeliveryAreaEntity deliveryArea;

    public static AreaReadyStatusEntity of(Integer id, boolean state, int count, DeliveryAreaEntity deliveryArea){
        return new AreaReadyStatusEntity(id, state ,count, deliveryArea);
    }

}








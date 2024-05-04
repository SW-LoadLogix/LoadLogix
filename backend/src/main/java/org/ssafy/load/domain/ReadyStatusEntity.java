package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "ready_status")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ReadyStatusEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "area_status", columnDefinition = "BOOLEAN DEFAULT false")
    private Boolean areaStatus;
    private int count; // 구역당 할당된 개수
    @Column(name="worker_status", columnDefinition = "BOOLEAN DEFAULT false")
    private Boolean workerState;
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "area_id")
    private DeliveryAreaEntity deliveryArea;

    public static ReadyStatusEntity of(Integer id, Boolean areaStatus, int count, Boolean workerState ,DeliveryAreaEntity deliveryArea){
        return new ReadyStatusEntity(id, areaStatus ,count, workerState, deliveryArea);
    }

    public ReadyStatusEntity withUpdatedAreaStateAndCount(boolean areaStatus, int count) {
        return new ReadyStatusEntity(this.id, areaStatus, count, this.workerState, this.deliveryArea);
    }
    public ReadyStatusEntity withUpdatedWorkerState(boolean workerStatus) {
        return new ReadyStatusEntity(this.id, this.areaStatus, this.count, workerStatus, this.deliveryArea);
    }
}








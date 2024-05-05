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
    private boolean state;
    private int count; // 구역당 할당된 개수
    @OneToOne
    @JoinColumn(name = "area_id")
    private AreaEntity buildingAddressEntity;
}

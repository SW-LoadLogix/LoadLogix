package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

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
    @JoinColumn(name = "area_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private DeliveryAreaEntity deliveryArea;

    public static AreaReadyStatusEntity of(
            Integer id,
            boolean state,
            int count,
            DeliveryAreaEntity deliveryArea
    ) {
        return new AreaReadyStatusEntity(id, state, count, deliveryArea);
    }
}

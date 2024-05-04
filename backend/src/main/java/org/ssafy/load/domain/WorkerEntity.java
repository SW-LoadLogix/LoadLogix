package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "worker")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class WorkerEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String loginId;
    private String password;
    private String name;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "car_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private CarEntity car;

    @OneToOne(mappedBy = "worker", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private DeliveryAreaEntity deliveryArea;


    @OneToMany(mappedBy = "worker", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<LoadTaskEntity> loadTaskEntities = new ArrayList<>();

    public static WorkerEntity of(
            Long id,
            String loginId,
            String password,
            String name,
            CarEntity car,
            DeliveryAreaEntity deliveryArea,
            List<LoadTaskEntity> loadTaskEntities
    ) {
        return new WorkerEntity(id, loginId, password, name, car, deliveryArea, loadTaskEntities);
    }
}

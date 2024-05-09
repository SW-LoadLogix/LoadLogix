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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "car_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private CarEntity car;

    @OneToOne(mappedBy = "worker", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private AreaEntity area;

    public static WorkerEntity of(
            Long id,
            String loginId,
            String password,
            String name,
            CarEntity car,
            AreaEntity area
    ) {
        return new WorkerEntity(id, loginId, password, name, car, area);
    }

    public static WorkerEntity createNewWorker(String id, String password, String name, CarEntity car) {
        return WorkerEntity.of(null, id, password, name, car, null);
    }
}

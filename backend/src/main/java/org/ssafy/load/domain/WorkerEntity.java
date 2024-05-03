package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    private String userId;
    private String password;
    private String name;

    @OneToOne
    @JoinColumn(name = "car_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private CarEntity car;

    public static WorkerEntity of(
        Long id,
        String userId,
        String password,
        String name,
        CarEntity car
    ) {
        return new WorkerEntity(id, userId, password, name, car);
    }
}

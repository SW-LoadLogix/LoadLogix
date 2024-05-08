package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "area")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AreaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name="area_name")
    private String areaName;
    @Column(name="convey_no")
    private int conveyNo;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "worker_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private WorkerEntity worker ;

    @OneToMany(mappedBy = "area", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<LoadTaskEntity> loadTaskEntities;

    public static AreaEntity of(
            Integer id,
            String areaName,
            int conveyNo,
            WorkerEntity worker,
            List<LoadTaskEntity> loadTaskEntities){
        return new AreaEntity(id, areaName, conveyNo, worker, loadTaskEntities);
    }

}

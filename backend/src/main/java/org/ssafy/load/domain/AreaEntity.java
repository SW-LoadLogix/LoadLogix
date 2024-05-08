package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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

    @OneToOne(mappedBy = "area", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private LoadTaskEntity loadTask;

    public static AreaEntity of(
            Integer id,
            String areaName,
            int conveyNo,
            WorkerEntity worker,
            LoadTaskEntity loadTask){
        return new AreaEntity(id, areaName, conveyNo, worker, loadTask);
    }

}

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
    @Column(name = "area_name")
    private String areaName;
    @Column(name = "convey_no")
    private int conveyNo;

    @Column(name="count")
    private int count;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "worker_id")
    private WorkerEntity worker;

    @OneToMany(mappedBy = "area", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<LoadTaskEntity> loadTaskEntities;

    public static AreaEntity of(
        Integer id,
        String areaName,
        int conveyNo,
        int count,
        WorkerEntity worker,
        List<LoadTaskEntity> loadTaskEntities) {
        return new AreaEntity(id, areaName, conveyNo, count, worker, loadTaskEntities);
    }

    public void updateArea(int count) {
        this.count = count;
    }

}

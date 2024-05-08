package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "load_task")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LoadTaskEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "area_status", columnDefinition = "BOOLEAN DEFAULT false")
    private Boolean areaStatus;
    private int count; // 구역당 할당된 개수
    @Column(name="worker_status", columnDefinition = "BOOLEAN DEFAULT false")
    private Boolean workerState;
    @Column(columnDefinition = "BOOLEAN DEFAULT false")
    private Boolean complete;
    @Column(name="create_at")
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "area_id")
    private AreaEntity area;

    @OneToMany(mappedBy = "loadTask", cascade = CascadeType.ALL)
    private List<GoodsEntity> goodsEntities = new ArrayList<>();


    @PrePersist
    public void onPrePersist() {
        this.createdAt = LocalDateTime.now();
    }

    public static LoadTaskEntity of(Integer id, Boolean areaStatus, int count, Boolean workerState, Boolean complete, LocalDateTime createdAt, AreaEntity area, List<GoodsEntity> goodsEntities){
        return new LoadTaskEntity(id, areaStatus ,count, workerState, complete, createdAt, area, goodsEntities);
    }

    public LoadTaskEntity withUpdatedWorkerState(boolean workerStatus) {
        return new LoadTaskEntity(this.id, this.areaStatus, this.count, workerStatus, complete, createdAt,this.area, this.goodsEntities);
    }

}
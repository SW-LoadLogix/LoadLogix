package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "goods")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class GoodsEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int weight;
    private String detailAddress;
    private String detailJuso;
    private int ordering;
    private double x;
    private double y;
    private double z;

    @OneToOne
    @JoinColumn(name = "box_type_id") // 실제 데이터베이스의 외래키 컬럼명 지정
    private BoxTypeEntity boxType;

    @ManyToOne
    @JoinColumn(name = "building_id")
    private BuildingEntity building;

    @ManyToOne
    @JoinColumn(name = "load_task_id")
    private LoadTaskEntity loadTask;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    public void onPrePersist() {
        this.createdAt = LocalDateTime.now();
    }

    public static GoodsEntity of(
            Long id,
            int weight,
            String detailAddress,
            String detailJuso,
            int ordering,
            int x,
            int y,
            int z,
            BoxTypeEntity boxType,
            BuildingEntity building,
            LoadTaskEntity loadTask,
            LocalDateTime createdAt
    ) {
        return new GoodsEntity(id, weight, detailAddress, detailJuso, ordering, x, y, z, boxType, building, loadTask, createdAt);
    }
}

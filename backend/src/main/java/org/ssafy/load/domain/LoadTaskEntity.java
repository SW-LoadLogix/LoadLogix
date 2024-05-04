package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    private Long id;
    private boolean complete;

    @OneToMany(mappedBy = "loadTask", cascade = CascadeType.ALL)
    private List<GoodsEntity> goodsEntities = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "worker_id")
    private WorkerEntity worker;

    public static LoadTaskEntity of(
            Long id,
            boolean complete,
            List<GoodsEntity> goodsEntities,
            WorkerEntity worker
    ) {
        return new LoadTaskEntity(id, complete, goodsEntities, worker);
    }
}

package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "path")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PathEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int priority;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "load_task_id")
    private LoadTaskEntity loadTask;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "building_id")
    private BuildingEntity building;

    public static PathEntity of(
            Long id,
            int priority,
            LoadTaskEntity loadTask,
            BuildingEntity building
    ) {
        return new PathEntity(id, priority, loadTask, building);
    }

    public static PathEntity createNewEntity(
            int priority,
            LoadTaskEntity loadTask,
            BuildingEntity building
    ) {
        return PathEntity.of(null, priority, loadTask, building);
    }
}

package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "path_time")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class PathTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "building_id1")
    private BuildingEntity building1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "building_id2")
    private BuildingEntity building2;
    private int duration;
    private int distance;

    public static PathTimeEntity of(
            Long id,
            BuildingEntity building1,
            BuildingEntity building2,
            int duration,
            int distance
    ) {
        return new PathTimeEntity(id, building1, building2, duration, distance);
    }

    public static PathTimeEntity createNewEntity(
            BuildingEntity srcBuilding,
            BuildingEntity desBuilding,
            int duration,
            int distance
    ) {
        return PathTimeEntity.of(null, srcBuilding, desBuilding, duration, distance);
    }
}

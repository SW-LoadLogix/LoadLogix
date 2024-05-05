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

    @ManyToOne
    @JoinColumn(name = "building_id1")
    private BuildingEntity building1;

    @ManyToOne
    @JoinColumn(name = "building_id2")
    private BuildingEntity building2;
    private Long duration;

    public static PathTimeEntity of(
            Long id,
            BuildingEntity building1,
            BuildingEntity building2,
            Long duration
    ) {
        return new PathTimeEntity(id, building1, building2, duration);
    }

    public static PathTimeEntity createNewEntity(
            BuildingEntity srcBuilding,
            BuildingEntity desBuilding,
            Long duration
    ) {
        return PathTimeEntity.of(null, srcBuilding, desBuilding, duration);
    }
}

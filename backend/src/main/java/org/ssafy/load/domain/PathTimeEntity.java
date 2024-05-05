package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.nio.file.Path;
import java.util.List;

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
    private BuildingEntity srcBuilding;

    @ManyToOne
    @JoinColumn(name = "building_id2")
    private BuildingEntity desBuilding;

    private Long duration;

    public static PathTimeEntity of(
            Long id,
            BuildingEntity srcBuilding,
            BuildingEntity desBuilding,
            Long duration
    ) {
        return new PathTimeEntity(id, srcBuilding, desBuilding, duration);
    }

    public static PathTimeEntity createNewEntity(
            BuildingEntity srcBuilding,
            BuildingEntity desBuilding,
            Long duration
    ) {
        return PathTimeEntity.of(null, srcBuilding, desBuilding, duration);
    }
}

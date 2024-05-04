package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    @JoinColumn(name = "building_address_id1")
    private BuildingAddressEntity buildingAddress1;

    @ManyToOne
    @JoinColumn(name = "building_address_id2")
    private BuildingAddressEntity buildingAddress2;

    private Long duration;

    public static PathTimeEntity of(
            Long id,
            BuildingAddressEntity buildingAddress1,
            BuildingAddressEntity buildingAddress2,
            Long duration
    ) {
        return new PathTimeEntity(id, buildingAddress1, buildingAddress2, duration);
    }
}

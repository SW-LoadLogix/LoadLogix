package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.ssafy.load.dto.DeliveryArea;

@Entity
@Table(name = "delivery_area")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryAreaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="area_name")
    private String areaName;
    public static DeliveryAreaEntity of(Long id, String area_name){
        return new DeliveryAreaEntity(id, area_name);
    }
}

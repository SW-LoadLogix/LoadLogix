package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "car")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class CarEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int height;
    private int length;
    private int width;
    private String type;
    private Integer maxPayload;

    public static CarEntity of(
            Long id,
            int height,
            int length,
            int width,
            String type,
            Integer maxPayload
    ) {
        return new CarEntity(id, height, length, width, type, maxPayload);
    }

    public void updateCar(int height, int length, int width, int maxPayload) {
        this.height = height;
        this.length = length;
        this.width = width;
        this.maxPayload = maxPayload;
    }

    public static CarEntity createEmptyNewEntity() {
        return CarEntity.of(null, 0, 0, 0, null, 1000000);
    }
}
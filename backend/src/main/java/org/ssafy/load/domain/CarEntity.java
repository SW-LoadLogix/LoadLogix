package org.ssafy.load.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
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

    @OneToOne(mappedBy = "car", cascade = CascadeType.ALL)
    private WorkerEntity worker;

    public static CarEntity of(
        Long id,
        int height,
        int length,
        int width,
        String type,
        WorkerEntity worker
    ) {
        return new CarEntity(id, height, length, width, type, worker);
    }
}
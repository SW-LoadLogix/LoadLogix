package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

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
    private int order;
    private double x;
    private double y;
    private double z;

    public static GoodsEntity of(
        Long id,
        int width,
        String detailAddress,
        String detailJuso,
        int order,
        int x,
        int y,
        int z
    ) {
        return new GoodsEntity(id, width, detailAddress, detailJuso, order, x, y, z);
    }
}

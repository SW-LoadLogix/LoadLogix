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
public class GoodsEntity{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int width;
    private int length;
    private int height;
    private int weight;

    public static GoodsEntity of(
            Long id,
            int width,
            int length,
            int height,
            int weight
    ){
        return new GoodsEntity(id, width, length, height, weight);
    }
}

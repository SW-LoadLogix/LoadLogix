package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.ssafy.load.common.type.BoxType;

@Entity
@Table(name = "box_type")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoxTypeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private BoxType type;

    private int height;
    private int length;
    private int width;

    @OneToOne(mappedBy = "box_type", cascade = CascadeType.ALL)
    private GoodsEntity goods;

    public static BoxTypeEntity of(
            Long id,
            BoxType type,
            int height,
            int length,
            int width,
            GoodsEntity goods
    ) {
        return new BoxTypeEntity(id, type, height, length, width, goods);
    }
}

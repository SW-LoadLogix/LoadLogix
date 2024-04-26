package org.ssafy.load.domain;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.ssafy.load.dto.Address;

@Entity
@Table(name = "address")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AddressEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name="address_id")
    private Long addressId;  // 도로명 주소 관리 번호
    @Column(name="dong_code")
    private Long dongCode;  // 법정동코드
    @Column(name="sido_name")
    private String sidoName; // 시도명
    @Column(name="gugun_name")
    private String gugunName;  // 시군구명
    @Column(name="dong_name")
    private String dongName;  // 법정읍면동명
    @Column(name="zibun_main")
    private int zibunMain;  // 지번본번(번지)
    @Column(name="zibun_sub")
    private int zibunSub;  // 지번부번(호)
    @Column(name="load_code")
    private Long loadCode;  // 도로명코드
    @Column(name="building_main")
    private int buildingMain;  // 건물본번
    @Column(name="building_sub")
    private int buildingSub;  // 건물부번

    static public AddressEntity of(
            Long id,
            Long addressId,
            Long dongCode,
            String sidoName,
            String gugunName,
            String dongName,
            int zibunMain,
            int zibunSub,
            Long loadCode,
            int buildingMain,
            int buildingSub
    ){
        return new AddressEntity(
                id,
                addressId,
                dongCode,
                sidoName,
                gugunName,
                dongName,
                zibunMain,
                zibunSub,
                loadCode,
                buildingMain,
                buildingSub
        );
    }

}

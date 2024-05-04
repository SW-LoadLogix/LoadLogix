package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "admin")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AdminEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String loginId;
    private String password;
    private String name;

    public static AdminEntity of(
            Long id,
            String loginId,
            String password,
            String name
    ) {
        return new AdminEntity(id, loginId, password, name);
    }
}

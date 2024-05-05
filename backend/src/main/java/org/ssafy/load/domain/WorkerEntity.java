package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "worker")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class WorkerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String userId;
    private String password;
    private String name;

    public static WorkerEntity of(
        Long id,
        String userId,
        String password,
        String name
    ) {
        return new WorkerEntity(id, userId, password, name);
    }
}

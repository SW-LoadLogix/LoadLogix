package org.ssafy.load.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table(name = "worker_ready_status")
@ToString
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class WorkerReadyStatusEntity {

    @Id
    private Long id;
    private boolean state;

    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    @JoinColumn(name = "id")
    private WorkerEntity worker;

    public static WorkerReadyStatusEntity of(
            Long id,
            boolean state,
            WorkerEntity worker
    ){
        return new WorkerReadyStatusEntity(id, state, worker);
    }
}

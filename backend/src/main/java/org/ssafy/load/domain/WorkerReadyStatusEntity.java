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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Boolean state;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "worker_id")
    private WorkerEntity worker;

    public static WorkerReadyStatusEntity of(
            Long id,
            Boolean state,
            WorkerEntity worker
    ){
        return new WorkerReadyStatusEntity(id, state, worker);
    }

    public WorkerReadyStatusEntity withUpdateState(Boolean state){
        return WorkerReadyStatusEntity.of(
                this.id,
                state,
                this.worker
        );
    };
}

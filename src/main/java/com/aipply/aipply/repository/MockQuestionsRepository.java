package com.aipply.aipply.repository;

import com.aipply.aipply.model.MockQuestions;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MockQuestionsRepository extends JpaRepository<MockQuestions, Integer> {

    @Query("SELECT mq FROM MockQuestions mq WHERE mq.job.id = :jobId")
    List<MockQuestions> findByJobId(@Param("jobId") int jobId);

    @Query("SELECT mq FROM MockQuestions mq WHERE mq.user.id = :userId")
    List<MockQuestions> findByUserId(@Param("userId") int userId);

    @Query("SELECT mq FROM MockQuestions mq WHERE mq.job.id = :jobId AND mq.user.id = :userId")
    List<MockQuestions> findByJobIdAndUserId(@Param("jobId") int jobId, @Param("userId") int userId);
}

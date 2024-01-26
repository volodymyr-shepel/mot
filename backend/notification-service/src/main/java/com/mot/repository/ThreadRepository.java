package com.mot.repository;

import com.mot.models.Thread;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface ThreadRepository extends JpaRepository<Thread, UUID> { }

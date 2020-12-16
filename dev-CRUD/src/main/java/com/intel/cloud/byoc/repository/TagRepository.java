package com.intel.cloud.byoc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.intel.cloud.byoc.model.Tag;

@Repository
public interface TagRepository extends JpaRepository<Tag, Long>{

}

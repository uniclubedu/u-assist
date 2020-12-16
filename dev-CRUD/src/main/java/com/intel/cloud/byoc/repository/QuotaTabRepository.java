package com.intel.cloud.byoc.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.intel.cloud.byoc.model.QuotaTab;

@Repository
public interface QuotaTabRepository extends JpaRepository<QuotaTab, Integer> {

}

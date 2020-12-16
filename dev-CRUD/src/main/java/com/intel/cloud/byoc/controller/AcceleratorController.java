package com.intel.cloud.byoc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.intel.cloud.byoc.exception.ResourceNotFoundException;
import com.intel.cloud.byoc.model.Accelerator;
import com.intel.cloud.byoc.model.Container;
import com.intel.cloud.byoc.repository.AcceleratorRepository;


@RestController
@RequestMapping("/api/v1")



public class AcceleratorController {
	
	@Autowired
private AcceleratorRepository acceleratorRepository;
	
	@GetMapping(value = "/container", produces = {"application/json"} )
	public List<Accelerator> getAllEmployees() {
		return acceleratorRepository.findAll();
	} 
	
	@GetMapping(value = "/accelerator/{id}", produces = {"application/json"} )
	public ResponseEntity<Accelerator> getAcceleratorById(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Accelerator container = acceleratorRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Accelerator not found for this id :: " + user_id));
		return ResponseEntity.ok().body(container);
	}

	
	@DeleteMapping("/accelerator/{id}")
	public Map<String, Boolean> deleteAccelerator(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Accelerator accelerator = acceleratorRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Accelerator not found for this id :: " + user_id));

		acceleratorRepository.delete(accelerator);
		Map<String, Boolean> response = new HashMap<>();
		response.put("deleted", Boolean.TRUE);
		return response;
	}

	

}

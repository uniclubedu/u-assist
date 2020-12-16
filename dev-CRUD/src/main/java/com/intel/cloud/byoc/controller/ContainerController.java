package com.intel.cloud.byoc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.intel.cloud.byoc.exception.ResourceNotFoundException;
import com.intel.cloud.byoc.model.Container;
import com.intel.cloud.byoc.repository.ContainerRepository;

@RestController
@RequestMapping("/api/v1")
public class ContainerController {
	@Autowired
	private ContainerRepository containerRepository;

	@GetMapping(value = "/container", produces = {"application/json"} )
	public List<Container> getAllEmployees() {
		return containerRepository.findAll();
	} 

	@GetMapping(value = "/container/{id}", produces = {"application/json"} )
	public ResponseEntity<Container> getContainerById(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Container container = containerRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Container not found for this id :: " + user_id));
		return ResponseEntity.ok().body(container);
	}
	
	@DeleteMapping("/container/{id}")
	public Map<String, Boolean> deleteContainer(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Container container = containerRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Container not found for this id :: " + user_id));

		containerRepository.delete(container);
		Map<String, Boolean> response = new HashMap<>();
		response.put("deleted", Boolean.TRUE);
		return response;
	}


}

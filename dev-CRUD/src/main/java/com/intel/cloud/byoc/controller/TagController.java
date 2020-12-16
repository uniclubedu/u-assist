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
import com.intel.cloud.byoc.model.Tag;
import com.intel.cloud.byoc.repository.AcceleratorRepository;
import com.intel.cloud.byoc.repository.ContainerRepository;
import com.intel.cloud.byoc.repository.TagRepository;

@RestController
@RequestMapping("/api/v1")

public class TagController {
	
	@Autowired
	private TagRepository tagRepository;
	
	@GetMapping(value = "/tag", produces = {"application/json"} )
	public List<Tag> getAllEmployees() {
		return tagRepository.findAll();
	} 
	
	@GetMapping(value = "/tag/{id}", produces = {"application/json"} )
	public ResponseEntity<Tag> getTagById(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Tag container = tagRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Tag not found for this id :: " + user_id));
		return ResponseEntity.ok().body(container);
	}
	
	
	@DeleteMapping("/tag/{id}")
	public Map<String, Boolean> deleteTag(@PathVariable(value = "id") Long user_id)
			throws ResourceNotFoundException {
		Tag tag = tagRepository.findById(user_id)
				.orElseThrow(() -> new ResourceNotFoundException("Tag not found for this id :: " + user_id));

		tagRepository.delete(tag);
		Map<String, Boolean> response = new HashMap<>();
		response.put("deleted", Boolean.TRUE);
		return response;
	}


}

package com.intel.cloud.byoc.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "accelerator_tab")
public class Accelerator {

	private long accelerator_id;
	private Boolean acc_cpu_intel_atom_processor;
	private Boolean acc_cpu_intel_celeron_processor;
	private Boolean acc_cpu_intel_core_processor;
	private Boolean acc_cpu_intel_pentium_processor;
	private Boolean acc_cpu_intel_xeon_processor;
	private Boolean acc_cpu_intel_xeon_phi_processor;
	private Boolean acc_gpu;
	private Integer tag_id;
	
	public Accelerator(Integer accelerator_id, Boolean acc_cpu_intel_atom_processor,
			Boolean acc_cpu_intel_celeron_processor, Boolean acc_cpu_intel_core_processor,
			Boolean acc_cpu_intel_pentium_processor, Boolean acc_cpu_intel_xeon_processor,
			Boolean acc_cpu_intel_xeon_phi_processor, Boolean acc_gpu, Integer tag_id) {
		super();
		this.accelerator_id = accelerator_id;
		this.acc_cpu_intel_atom_processor = acc_cpu_intel_atom_processor;
		this.acc_cpu_intel_celeron_processor = acc_cpu_intel_celeron_processor;
		this.acc_cpu_intel_core_processor = acc_cpu_intel_core_processor;
		this.acc_cpu_intel_pentium_processor = acc_cpu_intel_pentium_processor;
		this.acc_cpu_intel_xeon_processor = acc_cpu_intel_xeon_processor;
		this.acc_cpu_intel_xeon_phi_processor = acc_cpu_intel_xeon_phi_processor;
		this.acc_gpu = acc_gpu;
		this.tag_id = tag_id;
	}
	public Long getAccelerator_id() {
		return accelerator_id;
	}
	public void setAccelerator_id(Integer accelerator_id) {
		this.accelerator_id = accelerator_id;
	}
	public Boolean getAcc_cpu_intel_atom_processor() {
		return acc_cpu_intel_atom_processor;
	}
	public void setAcc_cpu_intel_atom_processor(Boolean acc_cpu_intel_atom_processor) {
		this.acc_cpu_intel_atom_processor = acc_cpu_intel_atom_processor;
	}
	public Boolean getAcc_cpu_intel_celeron_processor() {
		return acc_cpu_intel_celeron_processor;
	}
	public void setAcc_cpu_intel_celeron_processor(Boolean acc_cpu_intel_celeron_processor) {
		this.acc_cpu_intel_celeron_processor = acc_cpu_intel_celeron_processor;
	}
	public Boolean getAcc_cpu_intel_core_processor() {
		return acc_cpu_intel_core_processor;
	}
	public void setAcc_cpu_intel_core_processor(Boolean acc_cpu_intel_core_processor) {
		this.acc_cpu_intel_core_processor = acc_cpu_intel_core_processor;
	}
	public Boolean getAcc_cpu_intel_pentium_processor() {
		return acc_cpu_intel_pentium_processor;
	}
	public void setAcc_cpu_intel_pentium_processor(Boolean acc_cpu_intel_pentium_processor) {
		this.acc_cpu_intel_pentium_processor = acc_cpu_intel_pentium_processor;
	}
	public Boolean getAcc_cpu_intel_xeon_processor() {
		return acc_cpu_intel_xeon_processor;
	}
	public void setAcc_cpu_intel_xeon_processor(Boolean acc_cpu_intel_xeon_processor) {
		this.acc_cpu_intel_xeon_processor = acc_cpu_intel_xeon_processor;
	}
	public Boolean getAcc_cpu_intel_xeon_phi_processor() {
		return acc_cpu_intel_xeon_phi_processor;
	}
	public void setAcc_cpu_intel_xeon_phi_processor(Boolean acc_cpu_intel_xeon_phi_processor) {
		this.acc_cpu_intel_xeon_phi_processor = acc_cpu_intel_xeon_phi_processor;
	}
	public Boolean getAcc_gpu() {
		return acc_gpu;
	}
	public void setAcc_gpu(Boolean acc_gpu) {
		this.acc_gpu = acc_gpu;
	}
	public Integer getTag_id() {
		return tag_id;
	}
	public void setTag_id(Integer tag_id) {
		this.tag_id = tag_id;
	}
	@Override
	public String toString() {
		return "Accelerator [accelerator_id=" + accelerator_id + ", acc_cpu_intel_atom_processor="
				+ acc_cpu_intel_atom_processor + ", acc_cpu_intel_celeron_processor=" + acc_cpu_intel_celeron_processor
				+ ", acc_cpu_intel_core_processor=" + acc_cpu_intel_core_processor
				+ ", acc_cpu_intel_pentium_processor=" + acc_cpu_intel_pentium_processor
				+ ", acc_cpu_intel_xeon_processor=" + acc_cpu_intel_xeon_processor
				+ ", acc_cpu_intel_xeon_phi_processor=" + acc_cpu_intel_xeon_phi_processor + ", acc_gpu=" + acc_gpu
				+ ", tag_id=" + tag_id + "]";
	}
	
	

}

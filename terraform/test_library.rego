package terraform.test.library

import data.terraform.inputs
import data.terraform.library

test_small_create = true {
	i = inputs.lineage0
	library.num_creates = 3 with input as i
	library.num_deletes = 0 with input as i
	library.num_modifies = 0 with input as i
}

test_resource_types = true {
	i = inputs.lineage0
	x = library.resource_types with input as i
	x = {"aws_autoscaling_group", "aws_instance", "aws_launch_configuration"}
}

test_small_create_by_type = true {
	true
	i = inputs.lineage0
	library.num_creates_of_type.aws_instance = 1 with input as i
	library.num_creates_of_type.aws_autoscaling_group = 1 with input as i
	library.num_creates_of_type.aws_launch_configuration = 1 with input as i
	not has_non_zero_value(library.num_deletes_by_type, true) with input as i
	not has_non_zero_value(library.num_modifies_by_type, true) with input as i
}

test_mix = true {
	i = inputs.lineage1
	library.num_creates = 1 with input as i
	library.num_deletes = 1 with input as i
	library.num_modifies = 1 with input as i
}

test_mix_by_type = true {
	i = inputs.lineage1
	library.num_creates_of_type.aws_instance = 1 with input as i
	library.num_modifies_of_type.aws_autoscaling_group = 1 with input as i
	library.num_deletes_of_type.aws_instance = 1 with input as i
}

test_large_create = true {
	i = inputs.large_create
	library.num_creates = 5 with input as i
	library.num_deletes = 0 with input as i
	library.num_modifies = 0 with input as i
}

test_large_create_by_type = true {
	i = inputs.large_create
	library.num_creates_of_type.aws_instance = 1 with input as i
	library.num_creates_of_type.aws_autoscaling_group = 3 with input as i
	library.num_creates_of_type.aws_launch_configuration = 1 with input as i
	not has_non_zero_value(library.num_deletes_by_type, true) with input as i
	not has_non_zero_value(library.num_modifies_by_type, true) with input as i
}

has_non_zero_value(dictionary) {
	dictionary[_] = x
	x != 0
}


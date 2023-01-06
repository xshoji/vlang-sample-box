module main

// global-variables - v/docs.md at master · vlang/v
// https://github.com/vlang/v/blob/master/doc/docs.md#global-variables
// > By default V does not allow global variables. However, in low level applications they have their place so their usage can be enabled with the compiler flag -enable-globals.
__global (
	// shared-objects - v/docs.md at master · vlang/v
	// https://github.com/vlang/v/blob/master/doc/docs.md#shared-objects
	// > Data can be exchanged between a thread and the calling thread via a shared variable.
	values_map shared map[string]string
)

// v -enable-globals run main.v
fn main() {
	lock values_map {
		println(values_map)
		add_value('key1', 'value1')
		println(values_map)
	}
	
	lock values_map {
		add_value('key2', 'value2')
		println(values_map)
	}
}

fn add_value(key string, value string) {
	values_map[key] = value
}

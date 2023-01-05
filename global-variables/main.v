module main

import sync
import json

__global (
	values_map map[string]string
)

// v -enable-globals run main.v
fn main() {
	mut mutex := sync.new_mutex()
	println(json.encode(values_map))
	mutex.@lock()
	add_value('key1', 'value1')
	println(json.encode(values_map))
	mutex.unlock()

	mutex.@lock()
	add_value('key2', 'value2')
	println(json.encode(values_map))
	mutex.unlock()
}

fn add_value(key string, value string) {
	values_map[key] = value
}

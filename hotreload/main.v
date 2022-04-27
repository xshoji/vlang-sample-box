module main

import time

[live] 
fn get_string() string {
	return 'aaa'
}

//$ v -live run main.v
fn main() {
	for {
		string_value := get_string()
		println('string_value: $string_value')
		time.sleep(1_000_000_000) // 1_000_000_000 = 1sec
	}
}

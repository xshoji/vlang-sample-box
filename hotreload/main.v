module main

import time

[live] 
fn get_string() string {
	return 'bbb'
}

//$ v -live run main.v
fn main() {
	for {
		string_value := get_string()
		println('string_value: $string_value')
		sec := time.Duration(1000_000_000)
		time.sleep(sec)
	}
}

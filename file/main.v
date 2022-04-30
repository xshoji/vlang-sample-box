module main

import io
import os
import time

fn generate_temp_file_path() string {
	now := time.now()
	file_name := now.unix.str() + now.microsecond.str() + '.txt'
	temp_file_path := os.temp_dir() + os.path_separator + file_name
	return temp_file_path
}

fn write_osfile(path string, text string) ? {
	println('<< write_osfile >>\npath:$path, text:$text')
	mut file := os.create(path) ?
	defer {
		file.close()
	}
	written_bytes_int := file.write(text.bytes()) ?
	println('written_bytes_int: $written_bytes_int')
}

// > coreutils/base64.v at main · vlang/coreutils
// > https://github.com/vlang/coreutils/blob/main/src/base64/base64.v#L116
fn read_osfile(mut file os.File) ?string {
	println('<< read_osfile >>\nfile:$file')
	defer {
		file.close()
	}
	// > io ｜ vdoc
	// > https://modules.vlang.io/io.html#read_all
	// > v/request.v at master · vlang/v
	// > https://github.com/vlang/v/blob/master/vlib/net/http/request.v#L165
	return io.read_all(reader: file) or {
		eprintln(err)
		exit(1)
	}.bytestr()
}

fn main() {
	temp_file_path := generate_temp_file_path()
	write_osfile(temp_file_path, 'aaa') ?
	mut file := os.open(temp_file_path) ?
	file_contents := read_osfile(mut file) ?
	println('file_contents: $file_contents')
}

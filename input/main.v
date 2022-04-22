module main

import os
import flag

const (
	chunk_size_decode = 16 * 1024
	buffer_size_decode = 16 * 1024
)

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('Input handling sample.')
	fp.version('v0.0.1')
	fp.description('\nExample 1: echo "aaa" |v run main.v\nExample 2: v run main.v /tmp/a.txt')
	fp.limit_free_args(1, 2) ?
	args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}

	println('>> args:\n$args')
	println('')
	mut file := get_file(os.args)
	file_contents := read_osfile(mut file) ?
	println('>> input contents:\n$file_contents')
}

fn get_file(args []string) os.File {
	if args.len == 1 || args[1] == '-' {
		return os.stdin()
	} else {
		file_path := args[1]
		return os.open(file_path) or {
			eprintln(err)
			exit(1)
		}
	}
}

// > coreutils/base64.v at main · vlang/coreutils  
// > https://github.com/vlang/coreutils/blob/main/src/base64/base64.v#L116  
fn read_osfile(mut file os.File) ?string {
	defer {
		file.close()
	}
	mut in_buffer := []byte{len: chunk_size_decode}

	// read the file in chunks for constant memory usage.
	mut file_contents := ""
	for {
		mut n_bytes := 0
		// using slice magic to overwrite possible '\n' and fill the single
		// buffer with base64 encoded data only.
		for {
			read_bytes := file.read_bytes_into_newline(mut in_buffer[n_bytes..]) or {
				eprintln(err)
				exit(1)
			}
			// edge case, when buffer is filled completely and last element it not \n.
			if read_bytes == 0 || ((n_bytes + read_bytes) == buffer_size_decode
				&& in_buffer.last() != `\n`)
				|| in_buffer[n_bytes + read_bytes - 1] != `\n` { // edge case, last read byte is not a newline.
				n_bytes = n_bytes + read_bytes
				break
			}
			n_bytes = n_bytes + read_bytes - 1 // overwrite newline
		}
		if n_bytes <= 0 {
			break
		}
		unsafe {
			file_contents += tos(in_buffer.data, n_bytes)
		}
	}
	return file_contents
}

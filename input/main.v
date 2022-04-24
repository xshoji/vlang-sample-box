module main

import os
import flag
import io

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
	// > io ｜ vdoc  
	// > https://modules.vlang.io/io.html#read_all  
	// > v/request.v at master · vlang/v  
	// > https://github.com/vlang/v/blob/master/vlib/net/http/request.v#L165  
	return io.read_all(reader: file) or {
		eprintln(err)
		exit(1)
	}.bytestr()
}

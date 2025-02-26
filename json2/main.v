module main

import os
import flag
import x.json2

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('json2 sample.')
	fp.version('v0.0.1')

	json := '{
	  "key1": "aaaa",
	  "key2": 1000,
	  "key3": [
	    "aaa",
	    "bbb",
	    "ccc"
	  ],
	  "key4": {
        "key4-key1": "aaaa",
        "key4-key2": 1000,
        "key4-key3": [
          "aaa",
          "bbb",
          "ccc"
        ]
	  }
	}'
    obj := json2.raw_decode(json)!
	data := obj.as_map() as map[string]json2.Any
	println(data['key1'] or { "" }.str())
}

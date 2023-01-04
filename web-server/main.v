module main

import vweb
import flag
import os
import json

struct App {
	vweb.Context
}

fn main() {
	// Handle arguments
	mut fp := flag.new_flag_parser(os.args)
	port := fp.int('port', `p`, 8080, '[optional] port (default: 8080)')
	help := fp.bool('help', `h`, false, 'help')

	// Valid required options.
	if help {
		println(fp.usage())
		return
	}

	// Start web application
	println('vweb app example')
	vweb.run(&App{}, port)
}

['/get/:value'; get]
pub fn (mut app App) get_endpoint(value string) vweb.Result {
	query_string := json.encode(app.query)
	return app.json(json.encode({
		'pathValue': value
		'queryParameters': query_string
	}))
}

['/post'; post]
pub fn (mut app App) post_endpoint() vweb.Result {
	return app.json(json.encode({
		'requestBody': app.req.data
	}))
}

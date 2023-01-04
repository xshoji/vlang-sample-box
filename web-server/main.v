module main

import vweb
import flag
import os
import json

const (
	endpoint_prefix = 'vweb/api/v1'
)

struct App {
	vweb.Context
}

fn main() {
	// Handle arguments
	mut fp := flag.new_flag_parser(os.args)
	port := fp.int('port', `p`, 8080, '[optional] port')
	help := fp.bool('help', `h`, false, 'help')

	// Valid required options.
	if help {
		println(fp.usage())
		return
	}

	println('vweb example')
	vweb.run(&App{}, port)
}

['/get/:value'; get]
pub fn (mut app App) get_endpoint(value string) vweb.Result {
	return app.json(json.encode({
		'endpointPrefix': endpoint_prefix
		'value': value
	}))
}

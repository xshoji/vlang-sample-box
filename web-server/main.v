module main

import vweb
import flag
import os
import json
import log
import time
import term

const (
	// Log level (1:fatal, 2:error, 3:warn, 4:info, 5:debug) (default = 5:debug) | e.g. export V_LOG_LEVEL=3
	log_level = $env('V_LOG_LEVEL')
)

fn logging(level log.Level, value string) {
	// get log level (default = 5:debug)
	log_level_local := if log_level.int() > 0 { log_level.int() } else { 5 }
	level_cli_text := match level {
		.fatal { term.red('FATAL') }
		.error { term.red('ERROR') }
		.warn { term.yellow('WARN ') }
		.info { term.white('INFO ') }
		.debug { term.blue('DEBUG') }
	}
	// print to stdout
	if int(level) <= log_level_local {
		println('${time.now().format_ss_micro()} [$level_cli_text] $value')
	}
	// print to stderr
	if int(level) <= int(log.Level.error) {
		eprintln('${time.now().format_ss_micro()} [$level_cli_text] $value')
	}
}


struct App {
	vweb.Context
}

// export V_LOG_LEVEL=3; v run main.v -p 8888
fn main() {
	// Handle arguments
	mut fp := flag.new_flag_parser(os.args)
	fp.description('
  This is web-server sample app.
  Log level is specified as Environment variable e.g. export V_LOG_LEVEL=3
  (1:fatal, 2:error, 3:warn, 4:info, 5:debug) (default = 5:debug)')

	port := fp.int('port', `p`, 8080, '[optional] port (default: 8080)')
	help := fp.bool('help', `h`, false, 'help')

	// Valid required options.
	if help {
		println(fp.usage())
		return
	}

	// Start web application
	logging(log.Level.info, 'start vweb app.')
	vweb.run(&App{}, port)
}

['/get/:value'; get]
pub fn (mut app App) get_endpoint(value string) vweb.Result {
	query_string := json.encode(app.query)
	return app.json(json.encode({
		'pathValue':       value
		'queryParameters': query_string
	}))
}

['/post'; post]
pub fn (mut app App) post_endpoint() vweb.Result {
	return app.json(json.encode({
		'requestBody': app.req.data
	}))
}

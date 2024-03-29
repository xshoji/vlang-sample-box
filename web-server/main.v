module main

import vweb
import flag
import os
import log
import time
import term
import net.http

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
		else { '' } // never come here
	}
	// print to stdout
	if int(level) <= log_level_local {
		println('${time.now().format_ss_micro()} [${level_cli_text}] ${value}')
	}
	// print to stderr
	if int(level) <= int(log.Level.error) {
		eprintln('${time.now().format_ss_micro()} [${level_cli_text}] ${value}')
	}
}

// v/vweb_example.v at master · vlang/v
// https://github.com/vlang/v/blob/master/examples/vweb/vweb_example.v
struct App {
	vweb.Context
mut:
	global_map shared map[string]string
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

struct GetResponse {
	path_value       string            [required]
	query_parameters map[string]string [required]
	global_map       map[string]string
}

['/get/:value'; get]
pub fn (mut app App) get_endpoint(value string) vweb.Result {
	return app.json_pretty(GetResponse{
		path_value: value
		query_parameters: app.query
		global_map: app.global_map
	})
}

struct PostResponse {
	form_data  map[string]string          [required]
	form_files map[string][]http.FileData [required]
	global_map map[string]string
}

['/post'; post]
pub fn (mut app App) post_endpoint() vweb.Result {
	lock app.global_map {
		for key, value in app.form {
			app.global_map[key] = value
		}
	}
	return app.json_pretty(PostResponse{
		form_data: app.form
		form_files: app.files
		global_map: app.global_map
	})
}

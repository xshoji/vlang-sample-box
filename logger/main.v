module main

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

// export V_LOG_LEVEL=3; v run main.v
fn main() {
	
	// Custom logging function
	logging(log.Level.fatal, 'fatal log.')
	logging(log.Level.error, 'error log.')
	logging(log.Level.warn, 'warn log.')
	logging(log.Level.info, 'info log.')
	logging(log.Level.debug, 'debug log.')


	// log.Log pattern.
	mut logger := &log.Log{
		level: log.Level.debug
		output_target: log.LogTarget.console
	}
	logger.set_output_label('my label')
	logger.debug('debug log.')
	logger.info('info log.')
	logger.warn('warn log.')
	logger.error('error log.')
	logger.fatal('fatal log.')
	
}

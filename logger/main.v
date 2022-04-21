module main

import log

fn main() {
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

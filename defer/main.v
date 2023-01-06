module main

import time
import log
import os

fn get_logger() &log.Log {
	return &log.Log{
		level: log.Level.debug
		output_target: log.LogTarget.console
	}
}

fn defer_func() {
	mut logger := get_logger()
	logger.info('Called defer block')
}

fn main() {
	mut logger := get_logger()
	logger.info('Start')

	// SIGINT ( Ctrl + C ) handling block
	// > v/signal.v at 36ec47cd203a1f119da74b868ceb92f6da7ea930 · vlang/v
	// > https://github.com/vlang/v/blob/36ec47cd203a1f119da74b868ceb92f6da7ea930/vlib/os/signal.v#L43
	os.signal_opt(os.Signal.int, fn (s os.Signal) {
		defer_func()
		exit(1)
	}) !
	// defer block
	defer {
		defer_func()
	}
	for i in 0 .. 5 {
		duration := time.Duration(1000 * time.millisecond)
		time.sleep(duration)
		logger.info(i.str())
	}
	logger.info('End')
}

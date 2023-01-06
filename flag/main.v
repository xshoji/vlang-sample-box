module main

import os
import flag
import term

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('flag_example_tool')
	fp.version('v0.0.1')
	fp.description('This tool is only designed to show how the flag lib is working')
	fp.skip_executable()
	// limit_free_args(min, max)は、自由引数のリミット値設定（最低長、最大長）
	// 例えば
	// v run flag/main.v -a 100 -b bbb --bool-val aaa （--bool-val までがパラメタで、aaaが自由引数1個）
	// はOKやけど
	// v run flag/main.v -a 100 -b bbb --bool-val aaa bbb ccc（aaa, bbb, cccで自由引数3個）
	// はエラー、みたいなことができる。
	fp.limit_free_args(0, 2) !
	a_int_val := fp.int('int-val', `a`, 0, '[required] some int')
	b_str_val := fp.string('str-val', `b`, '', '[required] some string')
	i_int_val := fp.int('int-val', `i`, 0o123, '[optional] some int to define 0o123 is its default val')
	f_float_val := fp.float('float-val', `f`, 1.0, '[optional] some floating point val, by default 1.0 .')
	s_str_val := fp.string('str-val', `s`, '', '[optional] some text')
	b_bool_val := fp.bool('bool-val', 0, false, '[optional] some boolean flag. --b-bool-val will set it to true.')

	// xxx_opt系関数は、--help指定した場合でも必須を要求されてしまうので使いづらい
	// あとoptのエラーハンドリングにひっかかった時点でのusageを返してしまうのでコマンドオプション全文が見えない
	// req_val := fp.string_opt('req_val', `r`, '[required] text with `-r` as an abbreviation, this parameter must be specified') or {
	// 	eprintln(err)
	// 	println(fp.usage())
	// 	return
	// }

	// Valid required options.
	if a_int_val == 0 || b_str_val == '' {
		eprintln(error(term.red('------\nERROR: Not enough required parameters.\n------')))
		println(fp.usage())
		return
	}

	// finalize() は、残りのすべての引数 (オプション以外) を返します。
	// すべての引数が定義された後に、.finalize()を呼び出します。
	// 残りの引数は、コマンドラインで定義されたのと同じ順序で返されます。
	// 追加のフラグが見つかった場合、すなわち
	// (--' または '-' で始まるもの) が見つかると、エラーを返します。
	additional_args := fp.finalize() or {
		eprintln(error(term.red('------\nERROR: ${err}}\n------')))
		println(fp.usage())
		return
	}
	println('r_int_val : $a_int_val')
	println('r_str_val : $b_str_val')
	println('int_val   : $i_int_val')
	println('bool_val  : $b_bool_val')
	println('float_val : $f_float_val')
	println('str_val   : "$s_str_val"')
	println(additional_args.join_lines())
}

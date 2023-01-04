module main

import os
import flag

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('flag_example_tool')
	fp.version('v0.0.1')
	fp.description('This tool is only designed to show how the flag lib is working')
	fp.skip_executable()
	// limit_free_args(min, max)は、自由引数のリミット値設定（最低長、最大長）
	// 例えば
	// v run main.v --int_val 1 --bool_val aaa （aaaが自由引数１個）
	// はOKやけど
	// v run main.v --int_val 1 --bool_val aaa bbb（aaa, bbbで自由引数２個）
	// はエラー、みたいなことができる。
	fp.limit_free_args(0, 2)
	r_int_val := fp.int('r_int_val', `a`, 0, '[required] some int with `-a` as an abbreviation.')
	r_str_val := fp.string('r_str_val', `b`, '', '[required] some text with `-b` as an abbreviation')
	int_val := fp.int('int_val', `i`, 0o123, 'some int to define 0o123 is its default val')
	float_val := fp.float('float_val', `f`, 1.0, 'some floating point val, by default 1.0 .')
	str_val := fp.string('str_val', `s`, '', 'some text with `-s` as an abbreviation, so you can pass --str_val abc or just -s abc')
	bool_val := fp.bool('bool_val', 0, false, 'some boolean flag. --bool_val will set it to true.')

	// xxx_opt系関数は、--help指定した場合でも必須を要求されてしまうので使いづらい
	// あとoptのエラーハンドリングにひっかかった時点でのusageを返してしまうのでコマンドオプション全文が見えない
	// req_val := fp.string_opt('req_val', `r`, '[required] text with `-r` as an abbreviation, this parameter must be specified') or {
	// 	eprintln(err)
	// 	println(fp.usage())
	// 	return
	// }

	// Valid required options.
	if r_int_val == 0 || r_str_val == '' {
		eprintln(error('\nERROR: Not enough required parameters.\n'))
		println(fp.usage())
		return
	}

	// finalize() は、残りのすべての引数 (オプション以外) を返します。
	// すべての引数が定義された後に、.finalize()を呼び出します。
	// 残りの引数は、コマンドラインで定義されたのと同じ順序で返されます。
	// 追加のフラグが見つかった場合、すなわち
	// (--' または '-' で始まるもの) が見つかると、エラーを返します。
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	println('r_int_val : $r_int_val')
	println('r_str_val : $r_str_val')
	println('int_val   : $int_val')
	println('bool_val  : $bool_val')
	println('float_val : $float_val')
	println('str_val   : "$str_val"')
	println(additional_args.join_lines())
}

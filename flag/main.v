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
	file_size := fp.int('file-size', `f`, 0, '[required] file size')
	item_name := fp.string('item-name', `i`, '', '[required] item name')
	// 0o123 = 8進数表現。10進数の83と等価。
	count := fp.int('count', `c`, 0o123, '[optional] count ( default: 0o123 )')
	ratio := fp.float('ratio', `r`, 1.0, '[optional] ratio ( default 1.0 )')
	title := fp.string('title', `t`, '', '[optional] title')
	is_global := fp.bool('global', `g`, false, '[optional] boolean type flag. --global will set it to true.')
	person_names := fp.string_multi('person-names', `p`, '[optional] multiple string values')


	// xxx_opt系関数は、--help指定した場合でも必須を要求されてしまうので使いづらい
	// あとoptのエラーハンドリングにひっかかった時点でのusageを返してしまうのでコマンドオプション全文が見えない
	// req_val := fp.string_opt('req_val', `r`, '[required] text with `-r` as an abbreviation, this parameter must be specified') or {
	// 	eprintln(err)
	// 	println(fp.usage())
	// 	return
	// }

	// Valid required options.
	if file_size == 0 || item_name == '' {
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
	println('file_size    : $file_size')
	println('item_name    : $item_name')
	println('count        : $count')
	println('is_global    : $is_global')
	println('ratio        : $ratio')
	println('title        : $title')
	println('person_names : $person_names')
	println(additional_args.join_lines())
}

module main

import time
import strconv

fn main() {
	// > v/docs.md at master · vlang/v
	// > https://github.com/vlang/v/blob/master/doc/docs.md#strings

	// Primitive types
	value_int8 := 1
	value_int := 100
	value_int64 := time.now().unix_time_milli()
	value_float64 := 100.12
	value_rune := '\n'
	value_string := 'test'
	value_bytes := 'test'.bytes()
	println('<< primitive >>')
	println('value_int, value_int64, value_float, valueRune, value_string\n$value_int, $value_int8, $value_int64, $value_float64, $value_rune, $value_string\n')
	println('')

	// String sequence
	value_string2 := '{
  "aaa", "bbb",
  "ccc": 111
}'
	println('<< foundString sequence >>')
	println(value_string2)
	println('')

	// Cast
	// > Golangでの文字列・数値変換 - 小野マトペの納豆ペペロンチーノ日記
	// > http://matope.hatenablog.com/entry/2014/04/22/101127
	println('<< cast >>')
	// FormatIntの第2引数は基数。2なら2進数、16なら16進数になる
	println('value_int: $value_int    -> value_string: $value_int.str()')
	println('value_int8: $value_int8   -> value_string: $value_int8.str()')
	println('value_int8: $value_int8   -> value_string: ${i64(value_int8).str()}')
	println('value_int64: $value_int64  -> value_string: $value_int64.str()')
	println('value_float: $value_float64   -> value_string: $value_float64.str()')
	println('value_float: $value_float64  -> value_int: ${int(value_float64)}')
	println('value_int: $value_int    -> value_float: ${f64(value_int)}')
	println('value_string: $value_string -> value[]byte: $value_string.bytes()')
	value_int2 := value_string.int()
	println('value_string: $value_string -> value_int: $value_int2')
	value_string3 := 'words'
	value_int_string_int_func := value_string3.int()
	value_int_string_strconv_atoi_func := strconv.atoi(value_string3) or { 100 }
	println('int(): $value_int_string_int_func, strconv.atoi: $value_int_string_strconv_atoi_func')
	value_string4 := '200'
	println('value_string: $value_string4 -> value_int64: $value_string4.i64()')
	println('value[]byte: $value_bytes -> value_string: $value_bytes.bytestr()')

	// Pointer
	value_int_pointer := &value_int
	println('<< pointer >>')
	println('value_int pointer: $value_int_pointer')
	println('value_int pointers value: ${*value_int_pointer}')
	println('')

	// array
	mut value_int_array := [1, 2, 3]
	println('<< array >>')
	println('value_int_array: $value_int_array')
	value_int_array << 4
	println('add 4 to value_int_array: $value_int_array')
	value_int_array << [5, 6, 7]
	println('add [5,6,7] to value_int_array: $value_int_array')
	println('value_int_array[0]: ${value_int_array[0]}')
	// println('value_int_array[100]: ${value_int_array[100]}') // V panic: array.get: index out of range
	value_int_array_out_of_range := value_int_array[100] or { 999 }
	println('value_int_array[100] or { ... }: $value_int_array_out_of_range')
	println('1 in value_int_array: ${1 in value_int_array}')
	println('9 in value_int_array: ${9 in value_int_array}')
	println('value_int_array.len: $value_int_array.len')
	println('value_int_array.cap: $value_int_array.cap')
	array_5_length := []int{len: 5, init: -1}
	println('array_5_length: $array_5_length')
	array_empty := []int{}
	println('array_empty: $array_empty')
	println('array.filter (even): ${value_int_array.filter(it % 2 == 0)}')
	println('array.filter (odd): ${value_int_array.filter(it % 2 == 1)}')
	array_over_5 := value_int_array.filter(fn (x int) bool {
		return x >= 5
	})
	println('array.filter (x >= 5): $array_over_5')
	array_over_5_squared := value_int_array.filter(it >= 5).map(it * it)
	println('array.filter(it >= 5).map(it * it): $array_over_5_squared')
	println('')

	// slice
	println('<< slice >>')
	array_strings := ['john', 'mike', 'bob']
	println('array_strings: $array_strings')
	println('array_strings[0..2]: ${array_strings[0..2]}')
	println('array_strings[1..]: ${array_strings[1..]}')
	println('array_strings[..2]: ${array_strings[..2]}')
	println('')

	// map
	mut map_values_string_string := {
		'aaa': 'aaa'
		'bbb': 'aaa'
		'ccc': 'aaa'
	}
	map_values_string_int := {
		'aaa': 1
		'bbb': 2
		'ccc': 3
	}
	println('<< map >>')
	println('map_values_string_string: $map_values_string_string')
	println('map_values_string_string[\'aaa\']: ${map_values_string_string['aaa']}')
	println('map_values_string_string[\'xxx\']: ${map_values_string_string['xxx']}')
	map_values_xxx := map_values_string_string['xxx'] or { 'no data' }
	println('map_values_string_string[\'xxx\'] or { ... }: $map_values_xxx')
	println('type of map_values_string_string: ${typeof(map_values_string_string).name}')
	map_values_string_string['ddd'] = 'ddd'
	println('add ddd:ddd to map_values_string_string: $map_values_string_string')
	println('map_values_string_int: $map_values_string_int')
	println('type of map_values_string_int: ${typeof(map_values_string_int).name}')
	println('')

	// for
	println("<< for >>")
	println("value_int_array size: ${value_int_array.len}")
	for _, v in value_int_array {
		println(v)
	}
	println("map_values_string_string size: ${map_values_string_string.len}")
	for k, v in map_values_string_string {
		println(k + ":" + v)
	}
	println('')

}

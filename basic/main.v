module main

import time
import strconv
import strutil
import mystruct
import json
import rand
import rand.seed
import crypto.sha256
import encoding.hex
import regex
import os

const (
	const_string_value = 'const_string_value'
	const_int_value    = 111
)

interface Any {}

fn new_any(val Any) Any {
	return val
}

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
	println('<< Primitive >>')
	println('value_int, value_int64, value_float, valueRune, value_string\n${value_int}, ${value_int8}, ${value_int64}, ${value_float64}, ${value_rune}, ${value_string}\n')
	println('')

	// String sequence
	value_string2 := '{
  "aaa", "bbb",
  "ccc": 111
}'
	println('<< String sequence >>')
	println(value_string2)
	println('')

	// Cast
	// > Golangでの文字列・数値変換 - 小野マトペの納豆ペペロンチーノ日記
	// > http://matope.hatenablog.com/entry/2014/04/22/101127
	println('<< Cast >>')
	println('value_int: ${value_int}    -> value_string: ${value_int.str()}')
	println('value_int8: ${value_int8}   -> value_string: ${value_int8.str()}')
	println('value_int8: ${value_int8}   -> value_string: ${i64(value_int8).str()}')
	println('value_int64: ${value_int64}  -> value_string: ${value_int64.str()}')
	println('value_float: ${value_float64}   -> value_string: ${value_float64.str()}')
	println('value_float: ${value_float64}  -> value_int: ${int(value_float64)}')
	println('value_int: ${value_int}    -> value_float: ${f64(value_int)}')
	println('value_string: ${value_string} -> value[]byte: ${value_string.bytes()}')
	value_int2 := value_string.int()
	println('value_string: ${value_string} -> value_int: ${value_int2}')
	value_string3 := 'words'
	value_int_string_int_func := value_string3.int()
	value_int_string_strconv_atoi_func := strconv.atoi(value_string3) or { 100 }
	println('int(): ${value_int_string_int_func}, strconv.atoi: ${value_int_string_strconv_atoi_func}')
	value_string4 := '200'
	println('value_string: ${value_string4} -> value_int64: ${value_string4.i64()}')
	println('value[]byte: ${value_bytes} -> value_string: ${value_bytes.bytestr()}')

	// Pointer
	value_int_pointer := &value_int
	println('<< Pointer >>')
	println('value_int pointer: ${value_int_pointer}')
	println('value_int pointers value: ${*value_int_pointer}')
	println('')
	println("<< Rewrite pointer's value >>")
	mut string_value := 'aaa'
	println('mut string_value: ${string_value}')
	mut string_pointer := &string_value
	println('mut string_pointer: ${string_pointer}')
	unsafe {
		*string_pointer = 'bbb'
	}
	println('mut string_value: ${string_value}')
	println('')

	// array
	mut value_int_array := [1, 2, 3]
	println('<< Array >>')
	println('value_int_array: ${value_int_array}')
	value_int_array << 4
	println('add 4 to value_int_array: ${value_int_array}')
	value_int_array << [5, 6, 7]
	println('add [5,6,7] to value_int_array: ${value_int_array}')
	println('value_int_array[0]: ${value_int_array[0]}')
	// println('value_int_array[100]: ${value_int_array[100]}') // V panic: array.get: index out of range
	value_int_array_out_of_range := value_int_array[100] or { 999 }
	// こうすることで発生するエラーを呼び出し元まで伝達させることができる
	// https://github.com/vlang/v/blob/master/doc/docs.md#:~:text=The%20same%20optional%20check%20applies%20to%20arrays%3A
	value_int_array_in_range := value_int_array[1]!
	println('value_int_array[100] or { ... }: ${value_int_array_out_of_range}')
	println('value_int_array[1] ?: ${value_int_array_in_range}')
	println('1 in value_int_array: ${1 in value_int_array}')
	println('9 in value_int_array: ${9 in value_int_array}')
	println('value_int_array.len: ${value_int_array.len}')
	println('value_int_array.cap: ${value_int_array.cap}')
	array_5_length := []int{len: 5, init: -1}
	println('array_5_length: ${array_5_length}')
	array_empty := []int{}
	println('array_empty: ${array_empty}')
	println('array.filter (even): ${value_int_array.filter(it % 2 == 0)}')
	println('array.filter (odd): ${value_int_array.filter(it % 2 == 1)}')
	array_over_5 := value_int_array.filter(fn (x int) bool {
		return x >= 5
	})
	println('array.filter (x >= 5): ${array_over_5}')
	array_over_5_squared := value_int_array.filter(it >= 5).map(it * it)
	println('array.filter(it >= 5).map(it * it): ${array_over_5_squared}')
	println('')

	// slice
	println('<< Slice >>')
	array_strings := ['john', 'mike', 'bob']
	println('array_strings: ${array_strings}')
	println('array_strings[0..2]: ${array_strings[0..2]}')
	println('array_strings[1..]: ${array_strings[1..]}')
	println('array_strings[..2]: ${array_strings[..2]}')
	println('')

	// map
	mut map_values_string_string_empty := map[string]string{}
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
	println('<< Map >>')
	println('map_values_string_string_empty: ${map_values_string_string_empty}')
	println('map_values_string_string: ${map_values_string_string}')
	println('map_values_string_string[\'aaa\']: ${map_values_string_string['aaa']}')
	println('map_values_string_string[\'xxx\']: ${map_values_string_string['xxx']}')
	map_values_xxx := map_values_string_string['xxx'] or { 'no data' }
	println('map_values_string_string[\'xxx\'] or { ... }: ${map_values_xxx}')
	println('\'aaa\' in map_values_string_string: ${'aaa' in map_values_string_string}')
	println('\'ddd\' in map_values_string_string: ${'ddd' in map_values_string_string}')
	println('type of map_values_string_string: ${typeof(map_values_string_string).name}')
	map_values_string_string['ddd'] = 'ddd'
	println('add ddd:ddd to map_values_string_string: ${map_values_string_string}')
	map_values_string_string.delete('aaa')
	println('delete aaa:aaa on map_values_string_string: ${map_values_string_string}')
	println('map_values_string_int: ${map_values_string_int}')
	println('type of map_values_string_int: ${typeof(map_values_string_int).name}')
	// 最新版でのみ対応されてる
	// > passing int variable as "any" interface value causes error · Issue #13787 · vlang/v
	// > https://github.com/vlang/v/issues/13787
	mut map_values_string_any := map[string]Any{}
	map_values_string_any['aaa'] = new_any('200'.int())
	map_values_string_any['bbb'] = new_any('bbb')
	map_values_string_any['ccc'] = new_any(true)
	map_values_string_any['ddd'] = new_any([1, 2, 3])
	map_values_string_any['eee'] = new_any(map[string]string{})
	println('map_values_string_any: ${map_values_string_any}')
	println('type of map_values_string_any: ${typeof(map_values_string_any).name}')
	println('')

	// For
	println('<< For loop >>')
	println('value_int_array size: ${value_int_array.len}')
	for _, v in value_int_array {
		println(v)
	}
	println('map_values_string_string size: ${map_values_string_string.len}')
	for k, v in map_values_string_string {
		println(k + ':' + v)
	}
	println('')

	// If
	value1 := 'a'
	mut value2 := 'a'
	mut if_result := if value1 == value2 { 'same value' } else { 'different value' }
	println('<< If >>')
	println('value1: ${value1}')
	println('value2: ${value2}')
	println('value1 == value2 : ${if_result}')
	value2 = 'b'
	if_result = if value1 == value2 { 'same value' } else { 'different value' }
	println('value1: ${value1}')
	println('value2: ${value2}')
	println('value1 == value2 : ${if_result}')
	// value3 := 1
	// if_result = if value1 == value3 { 'same value' } else { 'not same value' } // infix expr: cannot use `int` (right expression) as `string`
	if_result = if typeof(value1).name == 'string' {
		'value1 is string'
	} else {
		'value1 is not string'
	}
	println(' value1 is string : ${if_result}')
	println('')

	// Call module function
	println('<< Module function >>')
	println(strutil.to_json('aaa', 'bbb'))
	// println(strutil.build_string('aaa', 'bbb')) function `strutil.build_string` is private
	println('')

	// Struct
	println('<< Struct >>')
	mut user := mystruct.User{
		id: 1111
		name: 'Taro'
	}
	println(user)
	println('set value to partner field ... ')
	// user.get_partner() => none => exec or block => &mystruct.User{name: 'hanako', id: 2222 } => 'hanako'
	partner_name1 := user.get_partner() or { &mystruct.User{
		name: 'hanako'
		id: 2222
	} }.name
	println(partner_name1)
	user.set_partner(&mystruct.User{ name: 'yoko', id: 2222 })
	println(user)
	// user.get_partner() => &mystruct.User{name: 'yoko', id: 2222 } => 'yoko'
	partner_name2 := user.get_partner() or { &mystruct.User{
		name: 'hanako'
		id: 2222
	} }.name
	println(partner_name2)
	println('')

	// << anonymous struct >>
	// anonymous-structs - v/docs.md at master · vlang/v
	// https://github.com/vlang/v/blob/master/doc/docs.md#anonymous-structs

	// Json handling
	println('<< Json handling >>')
	mut address := mystruct.Address{
		country: 'Japan'
	}
	address.city = &mystruct.City{
		name: 'Saitama'
		postcode: 123456
	}
	println(json.encode(address))
	// Error handing function decodes json
	decode_func := fn (json_address string) mystruct.Address {
		return json.decode(mystruct.Address, json_address) or {
			println('Json decode faild. json = ${json_address}')
			return mystruct.Address{}
		}
	}
	mut json_address := '{"countryS"}'
	mut address2 := decode_func(json_address)
	println(address2)
	json_address = '{"country":"US"}'
	address2 = decode_func(json_address)
	println(address2)
	println('')

	// Closure
	println('<< Closure >>')
	mut main_scope_i := 0
	println('[main] main_scope_i: ${main_scope_i}')
	counter := fn [mut main_scope_i] () {
		println('[counter] main_scope_i: ${main_scope_i}')
		main_scope_i++
	}
	counter()
	counter()
	counter()
	println('[main] main_scope_i: ${main_scope_i}')
	println('')

	// Create random integer
	println('<< Random integer >>')
	create_random_number := fn () int {
		rand.seed(seed.time_seed_array(2))
		return rand.intn(1000000000 - 1) or { 0 } + 1
	}
	println(create_random_number())
	println('')

	// Create random foundString
	println('<< Random string >>')
	create_random_string := fn () string {
		seedstring := seed.time_seed_32().str()
		sha_bytes := sha256.sum256(seedstring.bytes())
		return hex.encode(sha_bytes)
	}
	println(create_random_string())
	println('')

	// DateTime format
	println('<< Datetime >>')
	now := time.now()
	println('format_plane    : ${now}')
	println('format_ss_micro : ${now.format_ss_micro()}')
	custom_format_time := now.get_fmt_str(time.FormatDelimiter.slash, time.FormatTime.hhmmss24_milli,
		time.FormatDate.mmddyyyy)
	println('format_custom   : ${custom_format_time}')
	println('<< Add time >>')
	println('add 1 hour   : ${now.add(1 * time.hour)}')
	println('')

	// Replace & Regex
	println('<< Replace string >>')
	println('// string.replace()')
	mozi := 'aaabbbaaaccc'
	println('original : ${mozi}')
	println('replace  : ${mozi.replace('aaa', '!!!')}')

	println('// re.replace()')
	txt := 'Today it is a good day.'
	mut re := regex.regex_opt(r'(a\w)[ ,.]')?
	replaced_txt := re.replace(txt, r'__[\0]__')
	println('original : ${txt}')
	println('replace  : ${replaced_txt}')

	println('// re.replace()')
	txt2 := '1 22 333 4444 5555 666 77 8'
	mut re2 := regex.regex_opt(r'\s[0-9]{3}\s')?
	matched_txts := re2.find_all_str(txt2)
	println('original : ${txt2}')
	println('matches  : ${matched_txts}')
	println('')

	// Execute os commands
	println('<< Execute os commands >>')
	ls_result := os.execute('ls -al')
	println('ls_result.exit_code:\n${ls_result.exit_code}\n')
	println('ls_result.output:\n${ls_result.output}')
	println('os.hostname(): ${os.hostname()}')
	println('os.temp_dir(): ${os.temp_dir()}')

	temp_dir_path := os.temp_dir() + os.path_separator + create_random_string()
	println('temp_dir_path: ${temp_dir_path}')
}

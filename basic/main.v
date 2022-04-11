module main

import time
import strconv

fn main() {

  // > v/docs.md at master · vlang/v  
  	// > https://github.com/vlang/v/blob/master/doc/docs.md#strings  

	// primitive types
	value_int8 := 1
	value_int := 100
	value_int64 := time.now().unix_time_milli()
	value_float64 := 100.12
	value_rune := '\n'
	value_string := "test"
	value_bytes := "test".bytes()
	println("<< primitive >>")
	println("valueInt, valueInt64, valueFloat, valueRune, valueString\n$value_int, $value_int8, $value_int64, $value_float64, $value_rune, $value_string\n")
	println("")


	// 文字シーケンス
	value_string2 := '{
  "aaa", "bbb",
  "ccc": 111
}'
	println("<< foundString sequence >>")
	println(value_string2)
	println("")


	// cast
	// > Golangでの文字列・数値変換 - 小野マトペの納豆ペペロンチーノ日記
	// > http://matope.hatenablog.com/entry/2014/04/22/101127
	println("<< cast >>")
	// FormatIntの第2引数は基数。2なら2進数、16なら16進数になる
	println("valueInt: $value_int    -> valueString: $value_int.str()")
	println("valueInt8: $value_int8   -> valueString: $value_int8.str()")
	println("valueInt8: $value_int8   -> valueString: ${i64(value_int8).str()}")
	println("valueInt64: $value_int64  -> valueString: $value_int64.str()")
	println("valueFloat: $value_float64   -> valueString: $value_float64.str()")
	println("valueFloat: $value_float64  -> valueInt: ${int(value_float64)}")
	println("valueInt: $value_int    -> valueFloat: ${f64(value_int)}")
	println("valueString: $value_string -> value[]byte: ${value_string.bytes()}")
	value_int2 := value_string.int()
	println("valueString: $value_string -> valueInt: $value_int2")
	value_string3 := "words"
	value_int_string_int_func := value_string3.int()
	value_int_string_strconv_atoi_func := strconv.atoi(value_string3) or { 100 }
	println("int(): $value_int_string_int_func, strconv.atoi: $value_int_string_strconv_atoi_func")
	value_string4 := "200"
	println("valueString: $value_string4 -> valueInt64: ${value_string4.i64()}")
	println("value[]byte: $value_bytes -> valueString: $value_bytes.bytestr()")


}

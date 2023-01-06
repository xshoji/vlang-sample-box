module mystruct

//------------------
// User
//------------------
// v/docs.md at master · vlang/v
// https://github.com/vlang/v/blob/master/doc/docs.md#manual-control-for-stack-and-heap
[heap]
pub struct User {
	// private immutable (default)
	my_number int
mut:
	// private mutable
	age     int
    // structs-with-reference-fields - v/docs.md at master · vlang/v
    // https://github.com/vlang/v/blob/master/doc/docs.md#structs-with-reference-fields
	partner &User = 0
pub:
	// public immutable
	name string [required]
	id   int    [required]
pub mut:
	// public mutable
	// description ?string =? initializing 'byte *' (aka 'unsigned char *') with an expression of incompatible type 'Option_string' (aka 'struct Option_string'
	description string
	// anonymous-structs - v/docs.md at master · vlang/v
	// https://github.com/vlang/v/blob/master/doc/docs.md#anonymous-structs
	anonymous_struct struct {
		string_value string
		int_value int
	}
}

pub fn (mut u User) set_partner(partner &User) {
	u.partner = partner
}

pub fn (u User) get_partner() ?&User {
	// Here the compiler check is suppressed by the unsafe block. 
	// v/docs.md at master · vlang/v
    // https://github.com/vlang/v/blob/master/doc/docs.md#:~:text=Here%20the%20compiler%20check%20is%20suppressed%20by%20the%20unsafe%20block.
	unsafe {
		if u.partner == 0 {
			return none
		} else {
			return u.partner
		}
	}
}

//------------------
// Address
//------------------
pub struct Address {
	// private immutable (default)
	country string
pub mut:
	city City
}

pub struct City {
	// private immutable (default)
	name     string
	postcode int
}

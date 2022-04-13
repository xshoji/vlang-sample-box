module mystruct

//------------------
// User
//------------------
// > v/docs.md at master · vlang/v
// > https://github.com/vlang/v/blob/master/doc/docs.md#manual-control-for-stack-and-heap
[heap]
pub struct User {
	// private immutable (default)
	my_number int
mut:
	// private mutable
	age     int
	partner &User = 0
pub:
	// public immutable
	name string [required]
	id   int    [required]
pub mut:
	// public mutable
	// description ?string =? initializing 'byte *' (aka 'unsigned char *') with an expression of incompatible type 'Option_string' (aka 'struct Option_string'
	description string
}

pub fn (mut u User) set_partner(partner &User) {
	u.partner = partner
}

pub fn (u User) get_partner() ?&User {
	if u.partner == 0 {
		return none
	} else {
		return u.partner
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

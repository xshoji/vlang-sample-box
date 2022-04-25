module main

import cityenum

fn main() {
  nonecity := cityenum.City.@none
  tokyo := cityenum.City.tokyo
  osaka := cityenum.City.osaka
  fukuoka := cityenum.City.fukuoka
	println('$nonecity, $tokyo, $osaka, $fukuoka')
	println('nonecity.is_none(): ${nonecity.is_none()}')
	println('tokyo.is_none(): ${tokyo.is_none()}')
}

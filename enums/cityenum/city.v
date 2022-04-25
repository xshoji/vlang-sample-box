module cityenum

pub enum City {
	@none // 本来予約後のnoneは使えないが、@でエスケープすることでenumとして利用可能になる
	tokyo
	osaka
	fukuoka
}

pub fn (c City) is_none() bool {
	if c == City.@none {
		return true
	} else {
		return false
	}
}

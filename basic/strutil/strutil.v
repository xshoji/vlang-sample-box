module strutil

// public
pub fn to_json(key string, value string) string {
	return build_string(key, value)
}

// private
fn build_string(key string, value string) string {
	return '{"$key": "$value"}'
}

package util;

class Math {
	public static function sign(num:Float):Int {
		return num == 0 ? 0 : (num > 0 ? 1 : -1);
	}
}

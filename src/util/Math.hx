package util;

class Math {
	public inline static function sign(num:Float):Int {
		return num == 0 ? 0 : (num > 0 ? 1 : -1);
	}

	public inline static function clamp(num:Float, min:Float, max:Float) {
		return std.Math.min(std.Math.max(num, min), max);
	}

	public inline static function calcMovement(velocity:Float, dt:Float, acceleration:Float) {
		return velocity * dt + 0.5 * acceleration * dt * dt;
	}
}

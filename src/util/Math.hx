package util;

/**
	Useful Math operations.
**/
class Math {
	/**
		Returns -1 if `num` is negative, 1 if positive, and 0 if 0.
	**/
	public inline static function sign(num:Float):Int {
		return num == 0 ? 0 : (num > 0 ? 1 : -1);
	}

	/**
		Returns closest value to `num` that is between `min` and `max`
	**/
	public inline static function clamp(num:Float, min:Float, max:Float) {
		return std.Math.min(std.Math.max(num, min), max);
	}

	/**
		Calculates a physically acurate movement delta for an object.
	**/
	public inline static function calcMovement(velocity:Float, dt:Float, ?acceleration:Float) {
		return velocity * dt + 0.5 * acceleration * dt * dt;
	}

	/**
		Nudges `value` towards `target` by `increment`, without
		going past, in whichever direction is appropriate
	**/
	public static function approach(value:Float, target:Float, increment:Float):Float {
		var diff = target - value;

		return std.Math.abs(diff) < increment ? target : value + increment * sign(diff);
	}

	public static function absMax(val1:Float, val2:Float) {
		return std.Math.abs(val1) > std.Math.abs(val2) ? val1 : val2;
	}
}

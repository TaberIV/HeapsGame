package input.player;

import hxd.Key;

/**
	Implements keyboard input for the Player.
**/
class PlayerKeyboard implements PlayerController {
	public var xAxis(get, null):Float;
	public var yAxis(get, null):Float;

	public var jumpDown(get, null):Bool;
	public var jumpPressed(get, null):Bool;

	public function get_xAxis():Float {
		var ret = 0;

		if (Key.isDown(Key.LEFT)) {
			ret -= 1;
		}
		if (Key.isDown(Key.RIGHT)) {
			ret += 1;
		}

		return ret;
	}

	public function get_yAxis():Float {
		var ret = 0;

		if (Key.isDown(Key.UP)) {
			ret -= 1;
		}
		if (Key.isDown(Key.DOWN)) {
			ret += 1;
		}

		return ret;
	}

	public function get_jumpDown() {
		return Key.isDown(Key.SPACE);
	}

	public function get_jumpPressed() {
		return Key.isPressed(Key.SPACE);
	}

	public function new() {}
}

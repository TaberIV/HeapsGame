package input.player;

import hxd.Pad;

/**
	Implements Gamepad input for the Player.
**/
class PlayerPad extends PadController implements PlayerController {
	public var jumpDown(get, null):Bool;
	public var jumpPressed(get, null):Bool;

	function get_jumpDown() {
		return pad.isDown(Pad.DEFAULT_CONFIG.A);
	}

	function get_jumpPressed() {
		return pad.isPressed(Pad.DEFAULT_CONFIG.A);
	}
}

package input.player;

import hxd.Pad;

class PlayerPad implements PlayerController {
	private var pad:Pad;

	public var xAxis(get, null):Float;
	public var yAxis(get, null):Float;

	public var jumpDown(get, null):Bool;
	public var jumpPressed(get, null):Bool;

	public function get_xAxis():Float {
		return pad.xAxis;
	}

	public function get_yAxis():Float {
		return pad.yAxis;
	}

	public function get_jumpDown() {
		return pad.isDown(Pad.DEFAULT_CONFIG.A);
	}

	public function get_jumpPressed() {
		return pad.isPressed(Pad.DEFAULT_CONFIG.A);
	}

	public function new() {
		pad = hxd.Pad.createDummy();
		Pad.wait(function(pad) return);
	}
}

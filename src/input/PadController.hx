package input;

import hxd.Pad;

class PadController {
	private var pad:Pad;
	private var deadzone:Float;
	private var outterDeadzone:Float;

	public var xAxis(get, null):Float;
	public var yAxis(get, null):Float;

	private function get_xAxis():Float {
		if (Math.abs(pad.xAxis) < deadzone) {
			return 0;
		} else if (Math.abs(pad.xAxis) > outterDeadzone) {
			return util.Math.sign(pad.xAxis);
		} else {
			return pad.xAxis;
		}
	}

	private function get_yAxis():Float {
		if (Math.abs(pad.yAxis) < deadzone) {
			return 0;
		} else if (Math.abs(pad.yAxis) > outterDeadzone) {
			return util.Math.sign(pad.yAxis);
		} else {
			return pad.yAxis;
		}
	}

	public function new(?deadzone:Float = 0.25, ?outterDeadzone = 0.95) {
		pad = hxd.Pad.createDummy();
		Pad.wait(onPadConnect);

		this.deadzone = deadzone;
		this.outterDeadzone = outterDeadzone;
	}

	private function onPadConnect(gp:Pad) {
		// Connect pad
		pad = gp;
		trace("Connected");
	}
}

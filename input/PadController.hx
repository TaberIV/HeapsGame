package input;

import hxd.Pad;

class PadController {
	private var pad:Pad;
	private var deadzone:Float;
	private var outterDeadzone:Float;

	public var xAxis(get, never):Float;
	public var yAxis(get, never):Float;

	public var xAxisPressed(get, never):Int;
	public var yAxisPressed(get, never):Int;

	private function get_xAxis():Float {
		if (Math.abs(pad.xAxis) < deadzone) {
			return 0;
		} else if (Math.abs(pad.xAxis) > outterDeadzone) {
			return util.Calc.sign(pad.xAxis);
		} else {
			return pad.xAxis;
		}
	}

	private function get_yAxis():Float {
		if (Math.abs(pad.yAxis) < deadzone) {
			return 0;
		} else if (Math.abs(pad.yAxis) > outterDeadzone) {
			return util.Calc.sign(pad.yAxis);
		} else {
			return pad.yAxis;
		}
	}

	private function get_xAxisPressed():Int {
		return 0;
	}

	private function get_yAxisPressed():Int {
		return 0;
	}

	public function new(?deadzone:Float = 0.25, ?outterDeadzone = 0.95) {
		pad = Pad.createDummy();
		Pad.wait(onPadConnect);

		this.deadzone = deadzone;
		this.outterDeadzone = outterDeadzone;
	}

	private function onPadConnect(gp:Pad) {
		// Connect pad
		pad = gp;
	}

	public function destroy() {
		pad = null;
	}
}

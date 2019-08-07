package input;

import hxd.Pad;

class PadController {
	private var manager:PadManager;
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

	/**
		Grabs new gamepad from input manager.
		@param manager PadManager
		@param index Used to get input from a specific controller that is already in use.
		@param deadzone = 0.25
		@param outterDeadzone = 0.95
	**/
	public function new(manager:PadManager, ?index:Int, ?deadzone:Float = 0.25, ?outterDeadzone = 0.95) {
		this.manager = manager;

		this.deadzone = deadzone;
		this.outterDeadzone = outterDeadzone;

		newPad(index);
	}

	private function newPad(?index:Int) {
		pad = Pad.createDummy();
		manager.getPad(onPad, index);
	}

	private function onPad(pad:Pad) {
		this.pad = pad;
		pad.onDisconnect = onDisconnect;
	}

	private function onDisconnect() {
		newPad();
	}

	public function destroy() {
		manager.releasePad(pad);
		pad = null;
	}
}

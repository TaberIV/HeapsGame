package input;

import hxd.Pad;

class PadManager {
	var pads:Map<Int, Pad>;
	var users:Map<Int, Array<PadController>>;

	public function new() {
		pads = new Map();
		users = new Map();

		Pad.wait(onConnect);
	}

	private function onConnect(pad:Pad) {
		pad.onDisconnect = onDisconnect;
		pads[pad.index] = pad;
		users[pad.index] = new Array();

		Pad.wait(onConnect);
	}

	private function onDisconnect() {}

	public function getPad(c:PadController, onPad:Pad->Void, ?index:Int) {
		// Find an index with a controller
		if (index == null || pads[index] == null || !pads[index].connected) {
			for (i in pads.keys()) {
				var pad = pads.get(i);

				if (pad != null && pad.connected) {
					index = pad.index;
					break;
				}
			}
		}

		// If no controller (with index if indicated, or at all otherwise) is found, wait.
		if (index != null) {
			onPad(pads[index]);
			users[index].push(c);
		}
	}

	public function releasePad(pad:Pad):Void {}
}

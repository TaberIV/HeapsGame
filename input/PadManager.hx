package input;

import hxd.Pad;

class PadManager {
	var pads:Map<Int, Pad>;

	public function new() {
		pads = new Map();

		Pad.wait(onConnected);
	}

	private function onConnected(pad:Pad) {
		pads.set(pad.index, pad);

		Pad.wait(onConnected);
	}

	public function getPad(p:PadController, onPad:Pad->Void, ?index:Int) {
		// Find an index with a controller
		if (index == null) {
			for (i in pads.keys()) {
				var pad = pads.get(i);

				if (pad != null && pad.connected) {
					index = pad.index;
					break;
				}
			}
		}

		// If no controller (with index if indicated, or at all otherwise) is found, wait.
		if (index != null && pads[index] != null && pads[index].connected) {
			onPad(pads[index]);
		}
	}

	public function releasePad(pad:Pad):Void {}
}

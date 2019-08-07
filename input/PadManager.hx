package input;

import hxd.Pad;

class PadManager {
	private var pads:Array<hxd.Pad>;
	private var waiting:Array<{onPad:Pad->Void, ?index:Int}>;

	public function new() {
		pads = new Array();
		waiting = new Array();

		Pad.wait(waitPad);
	}

	private function waitPad(pad:Pad) {
		trace('Controller ${pad.index} connected.');
		pads[pad.index] = pad;

		for (w in waiting) {
			if (w.index == null || w.index == pad.index) {
				w.onPad(pad);
			}
		}

		Pad.wait(waitPad);
	}

	public function getPad(onPad:Pad->Void, ?index:Int) {
		// Find an index with a controller
		if (index == null) {
			for (i in 0...pads.length) {
				var p = pads[i];

				if (p != null && p.connected) {
					index = i;
					break;
				}
			}
		}

		// If no controller (with index if indicated, or at all otherwise) is found, wait.
		if (index == null || pads[index] == null || !pads[index].connected) {
			waiting.push({onPad: onPad, index: index});
		} else {
			onPad(pads[index]);
		}
	}

	public function releasePad(pad:Pad):Void {}
}

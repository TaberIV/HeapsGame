package input;

import hxd.Pad;

class PadManager {
	var pads:Map<Int, Pad>;
	var users:Map<Int, Array<PadController>>;
	var waitlist:Array<Array<PadController>>;

	public function new() {
		pads = new Map();
		users = new Map();
		waitlist = new Array();

		Pad.wait(onConnect);
	}

	private function onConnect(pad:Pad) {
		pad.onDisconnect = onDisconnect(pad);
		pads[pad.index] = pad;
		users[pad.index] = new Array();

		if (waitlist.length > 0) {
			var userList = waitlist.shift();

			for (user in userList) {
				getPad(user, pad.index);
			}
		}

		Pad.wait(onConnect);
	}

	private function onDisconnect(pad:Pad):Void->Void {
		return function() {
			pads.remove(pad.index);
			waitlist.push(users[pad.index]);
			users.remove(pad.index);
		}
	}

	public function getPad(c:PadController, ?index:Int):Bool {
		if (index == null) {
			// Find an unused controller
			for (i in pads.keys()) {
				var pad = pads[i];
				var userList = users[i];

				if (pad != null && pad.connected && userList.length == 0) {
					index = pad.index;
					break;
				}
			}
		} else if (!pads.exists(index)) {
			// Requested controller is not connected
			return false;
		}

		if (index != null) {
			// Register to controller
			c.connectPad(pads[index]);
			users[index].push(c);

			return true;
		} else {
			// No controller found, add to waitlist
			waitlist.push([c]);

			return false;
		}
	}

	public function releasePad(c:PadController):Bool {
		return users[c.pad.index].remove(c);
	}
}

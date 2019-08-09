package input;

import hxd.Pad;

class PadManager {
	var pads:Map<Int, Pad>;
	var users:Map<Int, Array<PadController>>;
	var waitlist:Array<Array<PadController>>;

	public var reconnectOnExisting:Bool = false;
	public var idUsers(default, null):Map<String, Int>;

	public function new() {
		pads = new Map();
		users = new Map();
		waitlist = new Array();

		idUsers = new Map();

		Pad.wait(onConnect);
	}

	private function onConnect(pad:Pad) {
		trace('Controller ${pad.index} connected.');
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
			trace('Controller ${pad.index} disconnected.');
			var userList = users[pad.index];

			pads.remove(pad.index);
			users.remove(pad.index);

			if (userList.length > 0) {
				if (reconnectOnExisting) {
					// Try to get free pad for displaced users
					var c = userList[0];
					var connected = getPad(c);

					if (connected) {
						// Free pad found, add other users
						for (i in 1...userList.length) {
							getPad(userList[i], c.pad.index);
						}
					} else {
						// No pad found, add other users to waitlist
						waitlist.pop(); // Remove single item list
						waitlist.push(userList);
					}
				} else {
					// Add users to waitlist for new pad
					waitlist.push(userList);
				}
			}
		}
	}

	public function getPad(c:PadController, ?index:Int):Bool {
		if (index == null) {
			// Find an unused controller
			for (i in pads.keys()) {
				var pad = pads[i];
				var userList = users[i];

				if (pad != null && userList.length == 0) {
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

	public function setId(c:PadController, id:String):Bool {
		if (c.pad.connected) {
			idUsers.set(id, c.pad.index);
			return true;
		} else {
			return false;
		}
	}

	public function getPadFromId(id:String):Null<Pad> {
		if (idUsers.exists(id)) {
			var pad = pads[idUsers[id]];
			idUsers.remove(id);

			return pad;
		} else {
			return null;
		}
	}

	public function releasePad(c:PadController):Bool {
		var removedUser = users.exists(c.pad.index) ? users[c.pad.index].remove(c) : false;
		var removedWaitlist = false;

		for (group in waitlist) {
			if (removedWaitlist = group.remove(c)) {
				break;
			}
		}

		return removedUser || removedWaitlist;
	}
}

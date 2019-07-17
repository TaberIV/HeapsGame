package input;

import haxe.Timer;

class Buffer {
	private var time:Float;
	private var timer:Timer;

	public var buffered(default, null):Bool = false;

	public function new(time:Float) {
		this.time = time;
	}

	public function pressed() {
		buffered = true;

		if (timer != null) {
			timer.stop();
		}

		timer = new Timer(Std.int(time * 1000));
		timer.run = expired;
	}

	private function expired() {
		buffered = false;

		timer.stop();
		timer = null;
	}
}

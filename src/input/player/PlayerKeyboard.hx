package input.player;

import hxd.Key;

class PlayerKeyboard extends PlayerController {
	private var leftDown:Bool;
	private var rightDown:Bool;

	private var upDown:Bool;
	private var downDown:Bool;

	private var wasJumpReleased:Bool;

	public function new() {
		leftDown = false;
		rightDown = false;

		wasJumpReleased = false;

		hxd.Window.getInstance().addEventTarget(onEvent);
	}

	function onEvent(event:hxd.Event) {
		switch (event.kind) {
			case EKeyDown:
				switch (event.keyCode) {
					case Key.LEFT:
						leftDown = true;
						xAxis = rightDown ? 0 : -1;
					case Key.RIGHT:
						rightDown = true;
						xAxis = leftDown ? 0 : 1;
					case Key.UP:
						upDown = true;
						yAxis = downDown ? 0 : -1;
					case Key.DOWN:
						downDown = true;
						yAxis = upDown ? 0 : 1;
					case Key.SPACE:
						jumpPressed = !jumpDown;
						jumpDown = true;
				}
			case EKeyUp:
				switch (event.keyCode) {
					case Key.LEFT:
						leftDown = false;
						xAxis = rightDown ? 1 : 0;
					case Key.RIGHT:
						rightDown = false;
						xAxis = leftDown ? -1 : 0;
					case Key.UP:
						upDown = false;
						yAxis = downDown ? 1 : 0;
					case Key.DOWN:
						downDown = false;
						yAxis = upDown ? -1 : 0;
					case Key.SPACE:
						jumpDown = false;
				}
			default:
		}
	}
}

package level;

import entity.Entity;

class Camera {
	private var level:Level;

	private var x:Float;
	private var y:Float;

	private var viewWidth(get, never):Int;
	private var viewHeight(get, never):Int;

	private var xMin(get, never):Int;
	private var yMin(get, never):Int;
	private var xMax(get, never):Int;
	private var yMax(get, never):Int;

	public var zoom(get, set):Float;
	public var entity:Entity;

	public function new(level:Level, ?zoom:Float = 1) {
		this.level = level;

		set_zoom(zoom);
	}

	private function get_viewWidth() {
		return level.scene.width;
	}

	private function get_viewHeight() {
		return level.scene.height;
	}

	private function get_zoom() {
		switch level.scene.scaleMode {
			case Zoom(x):
				return x;
			default:
				return -1;
		}
	}

	private function set_zoom(zoom:Float) {
		level.scene.scaleMode = ScaleMode.Zoom(zoom);
		return zoom;
	}

	private inline function get_xMin():Int {
		return Std.int(viewWidth >> 1);
	}

	private inline function get_yMin():Int {
		return Std.int(viewHeight >> 1);
	}

	private inline function get_xMax():Int {
		return level.widthPx - Std.int(viewWidth >> 1);
	}

	private inline function get_yMax():Int {
		return level.heightPx - Std.int(viewHeight >> 1);
	}

	private function track(entity:Entity) {
		if (entity != null) {
			x = util.Calc.clamp(entity.x, xMin, xMax);
			y = util.Calc.clamp(entity.y, yMin, yMax);
		}
	}

	public function update(dt:Float) {
		track(entity);
		level.setCameraPos(x, y);
	}
}

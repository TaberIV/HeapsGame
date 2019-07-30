package level;

import entity.Entity;

class Camera {
	private var level:Level;

	private var x:Float;
	private var y:Float;

	private var viewWidth:Int;
	private var viewHeight:Int;

	private var zoom:Float;

	private var xMin(get, never):Int;
	private var yMin(get, never):Int;
	private var xMax(get, never):Int;
	private var yMax(get, never):Int;

	public var entity:Entity;

	public function new(level:Level, viewWidth:Int, viewHeight:Int, ?zoom:Float = 1) {
		this.level = level;
		this.viewWidth = viewWidth;
		this.viewHeight = viewHeight;

		setZoom(zoom);
	}

	public function setZoom(zoom:Float):Void {
		this.zoom = zoom;
		level.setScale(zoom);
	}

	private inline function get_xMin():Int {
		return Std.int((viewWidth >> 1) / zoom);
	}

	private inline function get_yMin():Int {
		return Std.int((viewHeight >> 1) / zoom);
	}

	private inline function get_xMax():Int {
		return level.widthPx - Std.int((viewWidth >> 1) / level.scaleX);
	}

	private inline function get_yMax():Int {
		return level.heightPx - Std.int((viewHeight >> 1) / level.scaleY);
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = util.Calc.clamp(entity.x, xMin, xMax);
			y = util.Calc.clamp(entity.y, yMin, yMax);

			level.setCameraPos(x, y);
		}
	}
}

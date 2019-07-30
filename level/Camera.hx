package level;

import entity.Entity;

class Camera {
	private var level:Level;

	private var x:Float;
	private var y:Float;

	private var width:Int;
	private var height:Int;

	private var xMin:Int;
	private var yMin:Int;
	private var xMax:Int;
	private var yMax:Int;

	public var entity:Entity;

	public function new(level:Level, viewWidth:Int, viewHeight:Int, worldWidth:Int, worldHeight:Int) {
		this.level = level;
		this.width = viewWidth;
		this.height = viewHeight;

		xMin = Std.int((width >> 1) / level.scaleX);
		yMin = Std.int((height >> 1) / level.scaleY);
		xMax = Std.int(worldWidth - (width >> 1) / level.scaleX);
		yMax = Std.int(worldHeight - (height >> 1) / level.scaleY);
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = util.Calc.clamp(entity.x, xMin, xMax);
			y = util.Calc.clamp(entity.y, yMin, yMax);

			level.setCameraPos(x, y);
		}
	}
}

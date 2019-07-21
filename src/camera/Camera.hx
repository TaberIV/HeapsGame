package camera;

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

	public function new(level:Level, levelWidth:Int, levelHeight:Int) {
		this.level = level;
		width = level.width;
		height = level.height;

		xMin = Std.int(width / 2);
		yMin = Std.int(height / 2);
		xMax = levelWidth - Std.int(width / 2);
		yMax = levelHeight - Std.int(height / 2);
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = util.Math.clamp(entity.x, xMin, xMax);
			y = util.Math.clamp(entity.y, yMin, yMax);

			level.x = width / 2 - x;
			level.y = height / 2 - y;
		}
	}
}

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

	public function new(level:Level, worldWidth:Int, worldHeight:Int) {
		this.level = level;
		this.width = level.width;
		this.height = level.height;

		xMin = width >> 1;
		yMin = height >> 1;
		xMax = worldWidth - (width >> 1);
		yMax = worldHeight - (height >> 1);
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = util.Math.clamp(entity.x, xMin, xMax);
			y = util.Math.clamp(entity.y, yMin, yMax);

			level.setCameraPos(Math.round(x), Math.round(y));
		}
	}
}

package camera;

import Std.int;
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

		xMin = int(width / 2);
		yMin = int(height / 2);
		xMax = worldWidth - int(width / 2);
		yMax = worldHeight - int(height / 2);
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = util.Math.clamp(entity.x, xMin, xMax);
			y = util.Math.clamp(entity.y, yMin, yMax);

			level.setCameraPos(Math.round(x), Math.round(y));
		}
	}
}

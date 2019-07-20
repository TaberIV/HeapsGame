package camera;

import entity.Entity;

class Camera {
	private var level:Level;

	private var x:Float;
	private var y:Float;

	private var width:Int;
	private var height:Int;

	public var entity:Entity;

	public function new(level:Level) {
		this.level = level;
		this.width = level.width;
		this.height = level.height;
	}

	public function update(dt:Float) {
		if (entity != null) {
			x = entity.x;
			y = entity.y;

			level.x = width / 2 - x;
			level.y = height / 1.8 - y;
		}
	}
}

package entity;

/**
	Entities are game objects that makeup or interact with the level.
**/
class Entity {
	private var xRemainder:Float;
	private var yRemainder:Float;

	private var spr:draw.Sprite;

	public var x(default, null):Int;
	public var y(default, null):Int;

	public var level:Level;
	public var col:collision.Collider;

	public function new(level:Level, x:Float, y:Float) {
		set_x_Float(x);
		set_y_Float(y);

		this.level = level;

		init();
	}

	private function set_x_Float(x:Float) {
		this.x = Math.round(x);
		xRemainder = x - this.x;
	}

	private function set_y_Float(y:Float) {
		this.y = Math.round(y);
		yRemainder = y - this.y;
	}

	public function init() {}

	public function update(dt:Float):Void {}
}

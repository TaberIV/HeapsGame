package entity;

import collision.Collider;
import level.Level;
import draw.Sprite;

/**
	Entities are game objects that makeup or interact with the level.
**/
class Entity {
	private var isDestroyed(default, null):Bool = false;

	private var xRemainder:Float;
	private var yRemainder:Float;

	public var x(default, null):Int;
	public var y(default, null):Int;

	public var id(default, null):String;

	public var level(default, null):Level;
	public var spr:Sprite;
	public var col:Collider;

	private function set_x_Float(x:Float) {
		this.x = Math.round(x);
		xRemainder = x - this.x;
	}

	private function set_y_Float(y:Float) {
		this.y = Math.round(y);
		yRemainder = y - this.y;
	}

	public function new(level:Level, x:Float, y:Float, ?id:String) {
		this.level = level;

		set_x_Float(x);
		set_y_Float(y);

		this.id = id;

		level.addEntity(this);

		onActivate = function() return;

		init();
	}

	public function init() {}

	public function update(dt:Float):Void {}

	public dynamic function onActivate() {}

	public function destroy() {
		isDestroyed = true;

		if (spr != null) {
			spr.destroy();
			spr = null;
		}
		if (col != null) {
			col.destroy();
			col = null;
		}
	}
}

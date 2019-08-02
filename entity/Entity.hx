package entity;

import collision.Collider;
import level.Level;
import draw.Sprite;

/**
	Entities are game objects that makeup or interact with the level.
**/
class Entity {
	private var xRemainder:Float;
	private var yRemainder:Float;

	public var x(default, null):Int;
	public var y(default, null):Int;

	public var id(default, null):String;

	public var level(default, null):Level;
	public var spr:Sprite;
	public var col:Collider;

	public var onActivate:Void->Void;

	public function new(level:Level, x:Float, y:Float, ?id:String) {
		this.level = level;

		set_x_Float(x);
		set_y_Float(y);

		this.id = id;

		level.addEntity(this);

		onActivate = function() return;

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

	public function destroy() {
		if (spr != null) {
			spr.destroy();
			spr = null;
		}

		level.removeEntity(this);
	}
}

package collision;

import entity.*;

/**
	Axis Aligned Bounding Box connected to Entity
**/
class Collider {
	private var xOrigin:Int;
	private var yOrigin:Int;

	private var ent:entity.Entity;
	private var colSys:CollisionSystem;

	public var xMin(get, null):Int;
	public var yMin(get, null):Int;

	public var xMax(get, null):Int;
	public var yMax(get, null):Int;

	public var x(get, null):Int;
	public var y(get, null):Int;

	public var width(default, null):Int;
	public var height(default, null):Int;

	public var active:Bool = true;

	public function new(ent:Entity, width:Int, height:Int, ?centered:Bool = false) {
		this.ent = ent;
		colSys = ent.level.col;

		xOrigin = centered ? width >> 1 : 0;
		yOrigin = centered ? height >> 1 : 0;

		this.width = width;
		this.height = height;

		if (Std.downcast(ent, Actor) != null) {
			colSys.addActor(Std.downcast(ent, Actor));
		} else if (Std.downcast(ent, Solid) != null) {
			colSys.addSolid(Std.downcast(ent, Solid));
		}
	}

	public static function fromOrigin(ent:Entity, width:Int, height:Int, xOrigin:Int, yOrigin:Int) {
		var c = new Collider(ent, width, height, false);
		c.xOrigin = xOrigin;
		c.yOrigin = yOrigin;

		return c;
	}

	public static function fromSprite(ent:Actor, top:Int, bottom:Int, left:Int, right:Int) {
		var width = ent.spr.width;
		var height = ent.spr.height;

		return fromOrigin(ent, width - (left + right), height - (top + bottom), (width >> 1) - left, (height >> 1) - top);
	}

	public static inline function pointsIntersects(xMin:Int, yMin:Int, xMax:Int, yMax:Int, c:Collider) {
		return !(xMin >= c.xMax || yMin >= c.yMax || xMax <= c.xMin || yMax <= c.yMin);
	}

	public inline function intersects(c:Collider) {
		return pointsIntersects(xMin, yMin, xMax, yMax, c);
	}

	public function intersectsAt(c:Collider, x:Int, y:Int) {
		var xMin = x - xOrigin;
		var yMin = y - yOrigin;

		var xMax = xMin + width;
		var yMax = yMin + height;

		return pointsIntersects(xMin, yMin, xMax, yMax, c);
	}

	public function getOverlapingActors() {
		return colSys.getOverlappingActors(this);
	}

	public function getSolidAt(x:Int, y:Int):Solid {
		var xMin = x - xOrigin;
		var yMin = y - yOrigin;

		var xMax = xMin + width;
		var yMax = yMin + height;

		return colSys.pointsCollide(xMin, yMin, xMax, yMax);
	}

	public function collideAt(x:Int, y:Int):Bool {
		return getSolidAt(x, y) != null;
	}

	inline function get_xMin() {
		return x - xOrigin;
	}

	inline function get_yMin() {
		return y - yOrigin;
	}

	inline function get_xMax() {
		return xMin + width;
	}

	inline function get_yMax() {
		return yMin + height;
	}

	inline function get_x() {
		return ent.x;
	}

	inline function get_y() {
		return ent.y;
	}

	public function destroy():Void {
		if (Std.downcast(ent, Actor) != null) {
			colSys.removeActor(Std.downcast(ent, Actor));
		} else if (Std.downcast(ent, Solid) != null) {
			colSys.removeSolid(Std.downcast(ent, Solid));
		}
		
		ent = null;
	}
}

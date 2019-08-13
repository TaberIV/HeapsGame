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

	public var xMin(get, never):Int;
	public var yMin(get, never):Int;

	public var xMax(get, never):Int;
	public var yMax(get, never):Int;

	public var x(get, never):Int;
	public var y(get, never):Int;

	public var width(default, null):Int;
	public var height(default, null):Int;

	public var active:Bool = true;

	public function new(ent:Entity, width:Int, height:Int, ?xOrigin:Int, ?yOrigin:Int) {
		this.ent = ent;
		colSys = ent.level.col;

		this.xOrigin = xOrigin == null ? width >> 1 : xOrigin;
		this.yOrigin = yOrigin == null ? height >> 1 : yOrigin;

		this.width = width;
		this.height = height;

		var a, j, s;
		if ((a = Std.downcast(ent, Actor)) != null) {
			colSys.addActor(a);
		} else if ((j = Std.downcast(ent, JumpThroughSolid)) != null) {
			colSys.addJumpThrough(j);
		} else if ((s = Std.downcast(ent, Solid)) != null) {
			colSys.addSolid(s);
		}
	}

	public static function fromSprite(ent:Entity, top:Int, bottom:Int, left:Int, right:Int, ?xOrigin:Int, ?yOrigin:Int) {
		var sprWidth = ent.spr.width;
		var sprHeight = ent.spr.height;

		var width = sprWidth - (left + right);
		var height = sprHeight - (top + bottom);

		xOrigin = xOrigin == null ? (sprWidth >> 1) : xOrigin;
		yOrigin = yOrigin == null ? (sprHeight >> 1) : yOrigin;

		return new Collider(ent, width, height, xOrigin - left, yOrigin - top);
	}

	public inline function pointsIntersects(xMin:Int, yMin:Int, xMax:Int, yMax:Int) {
		return !(xMin >= this.xMax || yMin >= this.yMax || xMax <= this.xMin || yMax <= this.yMin);
	}

	public inline function intersects(c:Collider) {
		return c.pointsIntersects(xMin, yMin, xMax, yMax);
	}

	public function intersectsAt(c:Collider, x:Int, y:Int) {
		var xMin = x - xOrigin;
		var yMin = y - yOrigin;

		var xMax = xMin + width;
		var yMax = yMin + height;

		return c.pointsIntersects(xMin, yMin, xMax, yMax);
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

	public function getJumpThroughAt(x:Int, y:Int, ?dirY:Int = 1):JumpThroughSolid {
		if (dirY <= 0) {
			return null;
		}

		var xMin = x - xOrigin;
		var xMax = xMin + width;

		var yMax = yMin + height;

		return colSys.jumpThroughAt(xMin, xMax, yMax);
	}

	public function collideAt(x:Int, y:Int, ?dirY:Int = 0):Bool {
		var col = getSolidAt(x, y);

		if (col != null || dirY <= 0) {
			return col != null;
		} else {
			return getJumpThroughAt(x, y) != null;
		}
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

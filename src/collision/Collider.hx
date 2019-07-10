package collision;

import entity.Entity;

/**
	Axis Aligned Bounding Box connected to Entity
**/
class Collider {
	private var xOrigin:Int;
	private var yOrigin:Int;

	private var ent:entity.Entity;
	private var colSys:CollisionSystem;

	public var xMin:Int;
	public var yMin:Int;

	public var xMax(default, null):Int;
	public var yMax(default, null):Int;

	public var x(get, set):Int;
	public var y(get, set):Int;

	public var width(get, null):Int;
	public var height(get, null):Int;

	public function new(ent:Entity, x:Int, y:Int, width:Int, height:Int, ?centered:Bool = false) {
		this.ent = ent;
		colSys = ent.level.col;

		xOrigin = centered ? Std.int(width >> 1) : 0;
		yOrigin = centered ? Std.int(height >> 1) : 0;

		xMin = x - xOrigin;
		yMin = y - yOrigin;

		xMax = xMin + width;
		yMax = yMin + height;
	}

	public inline function intersects(c:Collider) {
		return !(xMin >= c.xMax || yMin >= c.yMax || xMax <= c.xMin || yMax <= c.yMin);
	}

	public function intersectsAt(c:Collider, x:Int, y:Int) {
		// Store current location
		var tx = this.x;
		var ty = this.y;

		// Temporarily move
		this.x = x;
		this.y = y;

		// Test intersection
		var intersects = intersects(c);

		// Move back
		this.x = tx;
		this.y = ty;

		return intersects;
	}

	public function collideAt(x:Int, y:Int) {
		// Store current location
		var tx = this.x;
		var ty = this.y;

		// Temporarily move
		this.x = x;
		this.y = y;

		// Test collision
		var collide = colSys.collidesSolid(this);

		// Move back
		this.x = tx;
		this.y = ty;

		return collide;
	}

	public function getOverlapingActors() {
		return colSys.getOverlappingActors(this);
	}

	inline function get_x() {
		return xMin + xOrigin;
	}

	inline function get_y() {
		return yMin + yOrigin;
	}

	inline function set_x(x:Int) {
		var dist = x - get_x();
		xMin += dist;
		xMax += dist;
		return x;
	}

	inline function set_y(y:Int) {
		var dist = y - get_y();
		yMin += dist;
		yMax += dist;
		return y;
	}

	inline function get_width() {
		return xMax - xMin;
	}

	inline function get_height() {
		return yMax - yMin;
	}

	public function destroy():Void {
		ent = null;
	}
}

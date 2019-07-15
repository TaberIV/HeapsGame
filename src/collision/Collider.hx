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

		xOrigin = centered ? Std.int(width >> 1) : 0;
		yOrigin = centered ? Std.int(height >> 1) : 0;

		this.width = width;
		this.height = height;
	}

	private static inline function pointsIntersects(xMin:Int, yMin:Int, xMax:Int, yMax:Int, c:Collider) {
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
		ent = null;
	}
}

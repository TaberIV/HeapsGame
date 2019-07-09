package entity.solid;

/**
	`Solids` are `Entities` that `Actors` cannot overlap with. A `Solid` may, or may not, move.
**/
class Solid extends Entity {
	public var col:collision.SolidCollider;

	public function move(x:Float, y:Float) {
		xRemainder += x;
		yRemainder += y;

		var moveX:Int = Math.round(xRemainder);
		var moveY:Int = Math.round(yRemainder);

		if (moveX != 0 || moveY != 0) {
			var riders = col.getRidingActors();
		}
	}

	override function destroy() {
		super.destroy();
		col.destroy();
	}
}

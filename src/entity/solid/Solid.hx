package entity.solid;

/**
	`Solids` are `Entities` that `Actors` cannot overlap with. A `Solid` may, or may not, move.
**/
class Solid extends Entity {
	public var col:collision.SolidCollider;

	public var velX(default, null):Float;
	public var velY(default, null):Float;

	public function move(x:Float, y:Float) {
		xRemainder += x;
		yRemainder += y;

		var moveX:Int = Math.round(xRemainder);
		var moveY:Int = Math.round(yRemainder);

		if (moveX != 0 || moveY != 0) {
			col.active = false;

			if (moveX != 0) {
				xRemainder -= moveX;
				this.x += moveX;

				// Push or carry actors
				// Todo: Implement function that returns these in two lists
				for (a in level.col.actors) {
					if (a.col.intersects(col)) {
						var aMove = moveX > 0 ? col.xMax - a.col.xMin : col.xMin - a.col.xMax;
						a.moveX(aMove, a.squish);
						a.setRiding(this);
					} else if (a.isRiding(this)) {
						a.moveX(moveX);
						a.setRiding(this);
					}
				}
			}

			if (moveY != 0) {
				yRemainder -= moveY;
				this.y += moveY;

				// Push or carry actors
				for (a in level.col.actors) {
					if (a.col.intersects(col)) {
						var aMove = moveY > 0 ? col.yMax - a.col.yMin : col.yMin - a.col.yMax;
						a.moveY(aMove, a.squish);
						a.setRiding(this);
					} else if (a.isRiding(this)) {
						a.moveY(moveY);
						a.setRiding(this);
					}
				}
			}
		}

		col.active = true;
	}

	override function destroy() {
		super.destroy();
		col.destroy();
	}
}

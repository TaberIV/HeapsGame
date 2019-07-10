package entity.solid;

import entity.actor.Actor;

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
			col.active = false;

			if (moveX != 0) {
				xRemainder -= moveX;
				this.x += moveX;
				col.x = this.x;

				// Push or carry actors
				level.col.forEachActor(function(a:Actor) {
					if (a.col.intersects(col)) {
						var aMove = moveX > 0 ? col.xMax - a.col.xMin : col.xMin - a.col.xMax;
						a.moveX(aMove, a.squish);
					} else if (a.isRiding(this)) {
						a.moveX(moveX);
					}
				});
			}

			if (moveY != 0) {
				yRemainder -= moveY;
				this.y += moveY;
				col.y = this.y;

				// Push or carry actors
				level.col.forEachActor(function(a:Actor) {
					if (a.col.intersects(col)) {
						var aMove = moveY > 0 ? col.yMax - a.col.yMin : col.yMin - a.col.yMax;
						a.moveY(aMove, a.squish);
					} else if (a.isRiding(this)) {
						a.moveY(moveY);
					}
				});
			}
		}

		col.active = true;
	}

	override function destroy() {
		super.destroy();
		col.destroy();
	}
}

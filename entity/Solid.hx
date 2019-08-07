package entity;

import level.Level;
import collision.Collider;

/**
	`Solids` are `Entities` that `Actors` cannot overlap with. A `Solid` may, or may not, move.
**/
class Solid extends Entity {
	public var velX(default, null):Float;
	public var velY(default, null):Float;

	public static function levelSolid(level:Level, x:Int, y:Int, w:Int, h:Int) {
		var solid = new Solid(level, x, y);
		solid.col = new Collider(solid, w, h, 0, 0);

		return solid;
	}

	public function move(x:Float, y:Float) {
		xRemainder += x;
		yRemainder += y;

		var moveX:Int = Math.round(xRemainder);
		var moveY:Int = Math.round(yRemainder);

		if (moveX != 0 || moveY != 0) {
			col.active = false;

			if (moveX != 0) {
				// Push or carry actors
				// Todo: Implement function that returns these in two lists
				for (a in level.col.actors) {
					if (col.intersectsAt(a.col, this.x + moveX, this.y)) {
						var aMove = moveX > 0 ? col.xMax - a.col.xMin : col.xMin - a.col.xMax;
						a.moveX(aMove, a.squish);
					} else if (a.isRiding(this)) {
						a.moveX(moveX);
					}
				}

				xRemainder -= moveX;
				this.x += moveX;
			}

			if (moveY != 0) {
				// Push or carry actors
				for (a in level.col.actors) {
					if (col.intersectsAt(a.col, this.x, this.y + moveY)) {
						var aMove = moveY > 0 ? col.yMax - a.col.yMin : col.yMin - a.col.yMax;
						a.moveY(aMove, a.squish);
					} else if (a.isRiding(this)) {
						a.moveY(moveY);
					}
				}

				yRemainder -= moveY;
				this.y += moveY;
			}
		}

		col.active = true;
	}
}

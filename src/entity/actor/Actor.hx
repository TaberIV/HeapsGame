package entity.actor;

import entity.solid.Solid;

/**
	Actors are Entities that move and collide with solids.
**/
class Actor extends Entity {
	private var lastRide:Solid;

	public var col:collision.Collider;

	public function moveX(amount:Float, ?action:() -> Void) {
		xRemainder += amount;
		var move:Int = Math.round(xRemainder);

		if (move != 0) {
			xRemainder -= move;
			var sign:Int = util.Math.sign(move);

			// Move and check for collision
			while (move != 0) {
				if (col == null || !col.collideAt(x + sign, y)) {
					// No collision
					x += sign;

					move -= sign;
				} else {
					// Collision with solid
					if (action != null) {
						action();
					}

					move = 0;
				}
			}
		}
	}

	public function moveY(amount:Float, ?action:() -> Void) {
		yRemainder += amount;
		var move:Int = Math.round(yRemainder);

		if (move != 0) {
			yRemainder -= move;
			var sign:Int = util.Math.sign(move);

			// Move and check for collision
			while (move != 0) {
				if (col == null || !col.collideAt(x, y + sign)) {
					// No collision
					y += sign;

					move -= sign;
				} else {
					// Collision with solid
					move = 0;

					if (action != null) {
						action();
					}
				}
			}
		}
	}

	public function isRiding(solid:Solid):Bool {
		return false;
	}

	public function squish():Void {
		destroy();
	}

	override function destroy() {
		super.destroy();
		col.destroy();
	}
}

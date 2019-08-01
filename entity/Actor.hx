package entity;

import entity.Solid;

/**
	Actors are Entities that move and collide with solids.
**/
class Actor extends Entity {
	private var lastRide:Solid;

	public function moveX(amount:Float, ?action:Solid->Void) {
		xRemainder += amount;
		var move:Int = Math.round(xRemainder);

		if (move != 0) {
			xRemainder -= move;
			var sign:Int = util.Calc.sign(move);

			// Move and check for collision
			while (move != 0) {
				var solid = col.getSolidAt(x + sign, y);

				if (solid == null) {
					// No collision
					x += sign;

					move -= sign;
				} else {
					// Collision with solid
					if (action != null) {
						action(solid);
					}

					move = 0;
				}
			}
		}
	}

	public function moveY(amount:Float, ?action:Solid->Void) {
		yRemainder += amount;
		var move:Int = Math.round(yRemainder);

		if (move != 0) {
			yRemainder -= move;
			var sign:Int = util.Calc.sign(move);

			// Move and check for collision
			while (move != 0) {
				var solid = col.getSolidAt(x, y + sign);

				if (solid == null) {
					// No collision
					y += sign;

					move -= sign;
				} else {
					// Collision with solid
					move = 0;

					if (action != null) {
						action(solid);
					}
				}
			}
		}
	}

	public function isRiding(solid:Solid):Bool {
		return false;
	}

	public function squish(?solid:Solid):Void {
		destroy();
	}

	override function destroy() {
		super.destroy();
		col.destroy();
	}
}

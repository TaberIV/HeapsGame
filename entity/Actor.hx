package entity;

import entity.Solid;

/**
	Actors are Entities that move and collide with solids.
**/
class Actor extends Entity {
	private var lastRide:Solid;

	public function moveX(amount:Float, ?action:Solid->Void, ?slipWidth:Int) {
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
					var slip = 0;
					if (slipWidth > 0) {
						// if (!col.collideAt(x + sign, y + slipWidth)) {
						// 	slip = 1;
						// } else
						if (!col.collideAt(x + sign, y - slipWidth)) {
							slip = -1;
						}
					}

					if (slip != 0) {
						yRemainder += slip * Math.abs(move);
					} else if (action != null) {
						action(solid);
					}
					move = 0;
				}
			}
		}
	}

	public function moveY(amount:Float, ?action:Solid->Void, ?slipWidth:Int) {
		yRemainder += amount;
		var move:Int = Math.round(yRemainder);

		if (move != 0) {
			yRemainder -= move;
			var sign:Int = util.Calc.sign(move);

			// Move and check for collision
			while (move != 0) {
				var solid = col.getSolidAt(x, y + sign);
				solid = solid == null ? col.getJumpThroughAt(x, y + sign, sign) : solid;

				if (solid == null) {
					// No collision
					y += sign;
					move -= sign;
				} else {
					var slip = 0;
					if (slipWidth > 0) {
						if (!col.collideAt(x + slipWidth, y + sign)) {
							slip = 1;
						} else if (!col.collideAt(x - slipWidth, y + sign)) {
							slip = -1;
						}
					}

					if (slip != 0) {
						xRemainder += slip * Math.abs(move);
					} else if (action != null) {
						action(solid);
					}
					move = 0;
				}
			}
		}
	}

	public function isRiding(solid:Solid, ?moveX:Int = 0, ?moveY:Int = 0):Bool {
		return false;
	}

	public function squish(?solid:Solid):Void {
		destroy();
	}
}

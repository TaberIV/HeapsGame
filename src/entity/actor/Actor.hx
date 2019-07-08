package entity.actor;

import entity.solid.Solid;

class Actor extends Entity {
	public function moveX(amount:Float) {
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
					col.x = x;
				} else {
					// Collision with solid
					xRemainder = 0;
					break;
				}
			}
		}
	}

	public function moveY(amount:Float) {
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
					col.y = y;
				} else {
					// Collision with solid
					move = 0;
				}
			}
		}
	}
}

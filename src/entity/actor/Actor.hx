package entity.actor;

import entity.solid.Solid;

class Actor extends Entity {
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
					col.x = x;

					move -= sign;
				} else {
					// Collision with solid
					xRemainder = sign > 0 ? Math.floor(xRemainder) : Math.ceil(xRemainder);
					move = 0;

					if (action != null) {
						action();
					}
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
					col.y = y;

					move -= sign;
				} else {
					// Collision with solid
					yRemainder = sign > 0 ? Math.floor(yRemainder) : Math.ceil(yRemainder);
					move = 0;

					if (action != null) {
						action();
					}
				}
			}
		}
	}
}

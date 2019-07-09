package entity.actor;

import collision.Collider;
import input.player.*;

class Player extends Actor {
	// Size Constants
	private var width:Int = 32;
	private var height:Int = 52;

	// Movement parameters
	private var moveSpeed:Float = 200;
	private var jumpDist:Float = 200;
	private var jumpHeight:Float = 150;
	private var jumpHeightMod:Float = 0.4;

	// Determined movement values
	private var jumpVelocity:Float;
	private var gravity:Float;
	private var fastGravity:Float;

	// Movement state
	private var velX:Float;
	private var velY:Float;
	private var fastFall:Bool;

	// References
	private var controller:PlayerController;

	override public function init() {
		// Create sprite
		spr = new draw.BoxSprite(this, width, height, 0xFF0000, true);
		col = new Collider(level, this.x, this.y, width, height, true);

		// Create input controller
		controller = new PlayerKeyboard();
		level.game.registerController(controller);

		// Determine movement values
		jumpVelocity = -2 * jumpHeight * moveSpeed / (jumpDist / 2);
		gravity = 2 * jumpHeight * moveSpeed * moveSpeed / (jumpDist * jumpDist / 4);
		fastGravity = gravity / jumpHeightMod;
	}

	public override function update(dt:Float):Void {
		// * Horizontal velocity
		velX = controller.xAxis * moveSpeed;

		// * Verticle velocity
		// Gravity
		fastFall = velY < 0 && (!controller.jumpDown || fastFall);
		var grav = fastFall ? fastGravity : gravity;
		velY += grav * dt;

		// Jump
		if (isGrounded() && controller.jumpPressed) {
			velY = jumpVelocity;
		}

		// * Move
		moveX(velX * dt, colX);
		moveY(util.Math.calcMovement(velY, dt, grav), colY);
	}

	private function isGrounded() {
		return col.collideAt(x, y + 1);
	}

	private function colX() {
		velX = 0;
	}

	private function colY() {
		velY = 0;
	}
}

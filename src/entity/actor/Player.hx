package entity.actor;

import entity.solid.Solid;
import input.player.*;

/**
	Player controlled Actor.
**/
class Player extends Actor {
	// Size Constants
	private static inline var width:Int = 32;
	private static inline var height:Int = 52;

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
		col = new collision.ActorCollider(this, width, height);

		// Create input controller
		controller = new PlayerKeyboard();

		// Determine movement values
		jumpVelocity = -2 * jumpHeight * moveSpeed / (jumpDist / 2);
		gravity = 2 * jumpHeight * moveSpeed * moveSpeed / (jumpDist * jumpDist / 4);
		fastGravity = gravity / jumpHeightMod;
	}

	public override function update(dt:Float):Void {
		// * Horizontal velocity
		if (isGrounded() || controller.xAxis != 0) {
			velX = controller.xAxis * moveSpeed;
		}

		// * Verticle velocity
		var yAcc = accelerateY(dt);

		// * Move
		moveX(velX * dt, colX);
		moveY(util.Math.calcMovement(velY, dt, yAcc), colY);
	}

	private function accelerateY(dt:Float):Float {
		var yAcc = applyGravity(dt);

		// Jump
		if (isGrounded() && controller.jumpPressed) {
			velY = jumpVelocity;
			yAcc = 0;

			if (lastRide != null && isRiding(lastRide)) {
				velX += lastRide.velX;
				velY += lastRide.velY;
				lastRide = null;
			}
		}

		return yAcc;
	}

	private function applyGravity(dt:Float):Float {
		fastFall = velY < 0 && (!controller.jumpDown || fastFall);
		var grav = fastFall ? fastGravity : gravity;
		velY += grav * dt;

		return grav;
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

	public override function isRiding(solid:Solid):Bool {
		return col.intersectsAt(solid.col, x, y + 1);
	}

	public override function destroy() {
		super.destroy();
		controller = null;
	}
}

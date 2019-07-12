package entity.actor;

import entity.solid.Solid;
import input.player.*;
import util.Math.*;

/**
	Player controlled Actor.
**/
class Player extends Actor {
	// Size Constants
	private static inline var width:Int = 32;
	private static inline var height:Int = 52;

	// Movement parameters
	private var moveSpeed:Float = 200;
	private var accelTime:Float = 0.2;
	private var deccelTime:Float = 0.01;

	private var jumpDist:Float = 200;
	private var jumpHeight:Float = 150;
	private var jumpHeightMod:Float = 0.4;
	private var airMobility:Float = 0.5;

	// Determined movement values
	private var moveForce:Float;
	private var friction:Float;
	private var runReduce:Float;

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
		moveForce = moveSpeed / accelTime;
		friction = moveSpeed / deccelTime;

		jumpVelocity = -2 * jumpHeight * moveSpeed / (jumpDist / 2);
		gravity = 2 * jumpHeight * moveSpeed * moveSpeed / (jumpDist * jumpDist / 4);
		fastGravity = gravity / jumpHeightMod;
	}

	public override function update(dt:Float):Void {
		// * Acceleration
		var accX = accelerateX(dt);
		var accY = accelerateY(dt);

		// * Move
		moveX(calcMovement(velX, dt, accX), colX);
		moveY(calcMovement(velY, dt, accY), colY);
	}

	private function accelerateX(dt:Float):Float {
		var accX:Float = 0;
		var mult:Float = isGrounded() ? 1 : airMobility;

		// Friction
		if (isGrounded() && velX != 0) {
			if (sign(controller.xAxis) != sign(velX)) {
				accX += -sign(velX) * friction;
				velX = approach(velX, 0, friction * dt);
			} else if (Math.abs(velX) > moveSpeed) {
				accX += -sign(velX) * runReduce;
				velX = approach(velX, sign(velX) * moveSpeed, runReduce * dt);
			}
		}

		if (controller.xAxis != 0) {
			accX += sign(controller.xAxis) * moveForce * mult;
			velX = approach(velX, moveSpeed * controller.xAxis, moveForce * mult * dt);
		}

		return accX;
	}

	private function accelerateY(dt:Float):Float {
		var accY = applyGravity(dt);

		// Jump
		if (isGrounded() && controller.jumpPressed) {
			velY = jumpVelocity;
			accY = 0;

			if (lastRide != null && isRiding(lastRide)) {
				velX += lastRide.velX;
				velY += lastRide.velY;
				lastRide = null;
			}
		}

		return accY;
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

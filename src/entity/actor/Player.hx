package entity.actor;

import entity.solid.Solid;
import input.player.*;
import util.Calc.*;

/**
	Player controlled Actor.
**/
class Player extends Actor {
	// Size Constants
	private static inline var width:Int = 32;
	private static inline var height:Int = 52;

	// Movement parameters
	private var moveSpeed:Float = 350;
	private var accelTime:Float = 0.3;
	private var deccelTime:Float = 0.1;

	private var jumpDist:Float = 320;
	private var jumpHeight:Float = 150;
	private var jumpHeightMod:Float = 0.4;
	private var airMobility:Float = 0.5;
	private var jumpBoost:Float = 50;

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

	private var onGround:Bool;

	// Collision state
	private var ride:Solid;
	private var colX:Solid;
	private var colY:Solid;

	// References
	private var controller:PlayerController;

	override public function init() {
		// Create sprite
		spr = new draw.BoxSprite(this, width, height, 0xFF0000, true);
		col = new collision.ActorCollider(this, width, height);

		// Create input controller
		controller = new PlayerAdditive();

		// Determine movement values
		moveForce = moveSpeed / accelTime;
		friction = moveSpeed / deccelTime;
		runReduce = friction / 5;

		var horSpeed = moveSpeed + jumpBoost;
		jumpVelocity = -2 * jumpHeight * horSpeed / (jumpDist / 2);
		gravity = 2 * jumpHeight * horSpeed * horSpeed / (jumpDist * jumpDist / 4);
		fastGravity = gravity / jumpHeightMod;
	}

	public override function update(dt:Float):Void {
		// Set frame constants
		onGround = checkGrounded();

		// Acceleration
		var accX = accelerateX(dt);
		var accY = accelerateY(dt);

		// Move
		moveX(calcMovement(velX, dt, accX), onColX);
		moveY(calcMovement(velY, dt, accY), onColY);

		if (ride != null && !isRiding(ride)) {
			releaseRide();
		}
	}

	private function accelerateX(dt:Float):Float {
		var accX:Float = 0;
		var mult:Float = onGround ? 1 : airMobility;

		// Friction
		if ((onGround || !Math.isFinite(friction)) && sign(controller.xAxis) != sign(velX)) {
			velX = approach(velX, 0, friction * dt);
		}

		// Reduce back if over run speed
		if (sign(controller.xAxis) == sign(velX) && Math.abs(velX) > moveSpeed) {
			if (onGround) {
				velX = approach(velX, sign(velX) * moveSpeed, runReduce * dt);
			}
		} else if (controller.xAxis != 0) {
			velX = approach(velX, moveSpeed * controller.xAxis, moveForce * mult * dt);
		}

		return accX;
	}

	private function accelerateY(dt:Float):Float {
		var accY = applyGravity(dt);

		// Jump
		if (onGround && controller.jumpPressed) {
			velY = jumpVelocity;

			// Jump boost
			if (Math.abs(velX) > moveSpeed && sign(controller.xAxis) == sign(velX)) {
				velX = sign(velX) * Math.max(Math.abs(velX), moveSpeed + jumpBoost);
			} else {
				velX += sign(controller.xAxis) * jumpBoost;
			}

			accY = 0;
		}

		return accY;
	}

	private function applyGravity(dt:Float):Float {
		fastFall = velY < 0 && (!controller.jumpDown || fastFall);
		var grav = fastFall ? fastGravity : gravity;
		velY += grav * dt;

		return grav;
	}

	private function checkGrounded() {
		return col.collideAt(x, y + 1);
	}

	private function onColX(solid:Solid) {
		velX = solid.velX;
		colX = solid;
	}

	private function onColY(solid:Solid) {
		velY = 0;
		colY = solid;
	}

	public override function isRiding(solid:Solid):Bool {
		var riding = col.intersectsAt(solid.col, x, y + 1);

		if (riding && ride != solid) {
			velX -= solid.velX;
			ride = solid;
		}

		return riding;
	}

	public function releaseRide() {
		velX += ride.velX;
		velY += ride.velY;
		ride = null;
	}

	public override function destroy() {
		super.destroy();
		controller = null;
	}
}

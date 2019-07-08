package entity.actor;

import collision.Collider;
import input.player.*;

class Player extends Actor {
	private static inline var moveSpeed = 200;

	private var velX:Float;
	private var velY:Float;

	private var controller:PlayerController;

	override public function new(level:Level, x:Float, y:Float) {
		super(level, x, y);

		// Create sprite
		spr = new draw.PlayerSprite(this);
		col = new Collider(level, this.x, this.y, 32, 52, true);

		// Create controller
		controller = new PlayerKeyboard();
		level.game.registerController(controller);
	}

	public override function update(dt:Float):Void {
		velX = controller.xAxis * moveSpeed;
		velY = controller.yAxis * moveSpeed;

		moveX(velX * dt);
		moveY(velY * dt);
	}
}

package entity.actor;

import collision.Collider;
import input.player.*;

class Player extends Actor {
	private var width:Int = 32;
	private var height:Int = 52;

	private var moveSpeed:Float = 200;

	private var velX:Float;
	private var velY:Float;

	private var controller:PlayerController;

	override public function new(level:Level, x:Float, y:Float) {
		super(level, x, y);

		// Create sprite
		spr = new draw.BoxSprite(this, width, height, 0xFF0000, true);
		col = new Collider(level, this.x, this.y, width, height, true);

		// Create input controller
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

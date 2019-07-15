import collision.*;
import entity.Entity;

class Level extends h2d.Scene {
	public var game:Game;
	public var ents:Array<Entity>;
	public var col:CollisionSystem;

	public function new(game:Game) {
		super();
		this.game = game;

		ents = new Array<Entity>();
		col = new collision.CollisionSystem();

		// ! Test
		ents.push(new entity.actor.Player(this, width / 2, height / 2));

		// ents.push(new entity.solid.Wall(this, 64, height - 182, 192, 32));
		// ents.push(new entity.solid.Wall(this, 3 * width / 4, height / 2, 32, 64));
		ents.push(new entity.solid.Wall(this, 0, height - 32, width - 128, 32));
		ents.push(new entity.solid.MovingWall(this, 3 * width / 4, height, 64, 32, 0, -50));
		ents.push(new entity.solid.MovingWall(this, 0, height - 126, 64, 64, 64, 0));
	}

	public function addEntity(ent:Entity):Void {
		ents.push(ent);
	}

	public function removeEntity(ent:Entity):Bool {
		return ents.remove(ent);
	}

	public function update(dt:Float):Void {
		for (ent in ents) {
			ent.update(dt);
		}
	}
}

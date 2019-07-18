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

import entity.solid.Wall;
import collision.*;
import entity.Entity;

class Level extends h2d.Scene {
	private var game:Game;
	private var data:Data.Levels;
	private var level:h2d.CdbLevel;

	public var ents:Array<Entity>;
	public var col:CollisionSystem;

	public function new(game:Game, index:Int) {
		super();
		this.game = game;
		this.data = Data.levels.all[index];
		this.level = new h2d.CdbLevel(Data.levels, index, this);

		ents = new Array<Entity>();
		col = new collision.CollisionSystem();

		// Create entities
		var tileSize = data.props.tileSize;

		for (ent in data.entities) {
			ents.push(switch (ent.kindId) {
				case Data.EntitiesKind.player:
					new entity.actor.Player(this, ent.x * tileSize, ent.y * tileSize);
			});
		}

		var colliders = level.buildStringProperty("collision");
		for (i in 0...colliders.length) {
			if (colliders[i] == Data.CollisionKind.full.toString()) {
				ents.push(new Wall(this, (i % data.width) * tileSize, Std.int(i / data.width) * tileSize, tileSize, tileSize));
			}
		}
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

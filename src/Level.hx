import collision.*;
import entity.Entity;

class Level extends h2d.Scene {
	private var index:Int;
	private var data:Data.Levels;
	private var level:h2d.CdbLevel;

	private var ents:Array<Entity>;

	public var col:CollisionSystem;

	public function new(game:Game, index:Int) {
		super();
		this.index = index;
		this.data = Data.levels.all[index];
		this.level = new h2d.CdbLevel(Data.levels, index, this);

		ents = new Array<Entity>();
		col = new collision.CollisionSystem(this);

		// Build level collision
		var tileSize = data.props.tileSize;
		var colliders = level.buildStringProperty("collision");
		col.buildLevel(colliders, level.width, level.height, data.props.tileSize);

		// Create entities
		for (ent in data.entities) {
			switch (ent.kindId) {
				case Data.EntitiesKind.player:
					new entity.actor.Player(this, ent.x * tileSize, ent.y * tileSize);
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

import camera.Camera;
import collision.*;
import entity.Entity;

class Level extends h2d.Scene {
	private var index:Int;
	private var data:Data.Levels;
	private var level:h2d.CdbLevel;

	private var ents:Array<Entity>;
	private var camera:Camera;

	public var col:CollisionSystem;

	public function new(game:Game, index:Int) {
		super();
		this.index = index;
		this.data = Data.levels.all[index];
		this.level = new h2d.CdbLevel(Data.levels, index, this);

		ents = new Array<Entity>();
		col = new collision.CollisionSystem(this);

		init();
	}

	private function init() {
		// Move foreground in front of entities
		for (o in level.getLayer(1)) {
			level.addChildAt(o, 2);
		}

		// Build level collision
		final tileSize = data.props.tileSize;
		var colGrid = level.buildStringProperty("collision");
		col.buildLevel(colGrid, level.width, level.height, data.props.tileSize);

		// Create entities
		camera = new Camera(level, width, height, data.width * tileSize, data.height * tileSize);

		for (ent in data.entities) {
			switch (ent.kindId) {
				case Data.EntitiesKind.player:
					camera.entity = new entity.actor.Player(this, ent.x * tileSize, ent.y * tileSize);
			}
		}
	}

	public override function addChild(s:h2d.Object) {
		if (level == null) {
			super.addChild(s);
		} else {
			level.addChildAt(s, 1);
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

		camera.update(dt);
	}
}

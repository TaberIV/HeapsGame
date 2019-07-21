import h2d.Scene;
import h2d.CdbLevel;
import h2d.Object;
import collision.*;
import camera.Camera;
import entity.Entity;
import draw.Sprite;

class Level extends Scene {
	private var game:Game;
	private var data:Data.Levels;
	private var world:CdbLevel;
	private var ents:Array<Entity>;
	private var camera:Camera;

	public var col:CollisionSystem;

	public function new(game:Game, index:Int) {
		super();
		this.game = game;
		this.data = Data.levels.all[index];
		this.world = new CdbLevel(Data.levels, index, this);

		ents = new Array<Entity>();
		col = new collision.CollisionSystem(this);

		init();
	}

	private function init() {
		// Build world collision
		final tileSize = data.props.tileSize;
		var colGrid = world.buildStringProperty("collision");
		col.buildLevel(colGrid, world.width, world.height, tileSize);

		// Create entities
		camera = new Camera(this, world.width * tileSize, world.height * tileSize);

		for (ent in data.entities) {
			switch (ent.kindId) {
				case Data.EntitiesKind.player:
					camera.entity = new entity.actor.Player(this, ent.x * tileSize, ent.y * tileSize);
			}
		}
	}

	public function addEntity(ent:Entity):Void {
		ents.push(ent);
	}

	public function removeEntity(ent:Entity):Bool {
		return ents.remove(ent);
	}

	public function addSprite(s:Sprite) {
		world.addChildAt(s, 1);
		world.under(s);
	}

	public function update(dt:Float):Void {
		for (ent in ents) {
			ent.update(dt);
		}

		camera.update(dt);
	}

	public function setCameraPos(x:Int, y:Int) {
		world.x = width / 2 - x;
		world.y = height / 2 - y;
	}
}

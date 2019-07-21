import h2d.CdbLevel;
import collision.*;
import camera.Camera;
import entity.Entity;
import draw.Sprite;

class Level extends CdbLevel {
	private var scene:LevelScene;
	private var data:Data.Levels;

	private var ents:Array<Entity>;
	private var camera:Camera;

	private var heightPx:Int;
	private var widthPx:Int;

	public var col:CollisionSystem;

	public function new(scene:LevelScene, index:Int) {
		super(Data.levels, index, scene);

		this.scene = scene;
		this.data = Data.levels.all[index];

		ents = new Array<Entity>();
		col = new collision.CollisionSystem(this);

		init();
	}

	private function init() {
		final tileSize = level.props.tileSize;
		heightPx = height * tileSize;
		widthPx = width * tileSize;

		// Build collision
		var colGrid = buildStringProperty("collision");
		col.buildLevel(colGrid, width, height, tileSize);

		// Camera
		camera = new Camera(this, scene.width, scene.height, widthPx, heightPx);

		// Create entities
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
		addChildAt(s, 1);
		under(s);
	}

	public function update(dt:Float):Void {
		for (ent in ents) {
			ent.update(dt);
		}

		camera.update(dt);
	}

	public function setCameraPos(x:Int, y:Int) {
		this.x = (scene.width >> 1) - x;
		this.y = (scene.height >> 1) - y;
	}
}

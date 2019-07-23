import h2d.CdbLevel;
import collision.*;
import camera.Camera;
import entity.Entity;

class Level extends CdbLevel {
	private var ents:Array<Entity>;
	private var camera:Camera;

	private var heightPx:Int;
	private var widthPx:Int;

	public var col:CollisionSystem;

	public function new(allLevels:Index<Dynamic>, index:Int, ?parent:Object) {
		super(allLevels, index, parent);

		ents = new Array<Entity>();
		col = new CollisionSystem(this);

		final tileSize = level.props.tileSize;
		heightPx = height * tileSize;
		widthPx = width * tileSize;

		init();
	}

	private function init() {
		// Build collision
		var colGrid = buildStringProperty("collision");
		col.buildLevel(colGrid, width, height, tileSize);

		// Camera
		camera = new Camera(this, scene.width, scene.height, widthPx, heightPx);
	}

	public function addEntity(ent:Entity, ?focus:Bool):Void {
		ents.push(ent);

		if (focus) {
			camera.entity = ent;
		}
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

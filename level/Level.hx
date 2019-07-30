package level;

import h2d.Scene;
import h2d.CdbLevel;
import cdb.Types.Index;
import entity.Entity;
import collision.CollisionSystem;
import draw.Sprite;

class Level extends h2d.CdbLevel {
	private var scene:Scene;
	private var ents:Array<Entity>;

	public var heightPx(default, null):Int;
	public var widthPx(default, null):Int;

	public var col:CollisionSystem;

	public function new(allLevels:Index<Dynamic>, index:Int, parent:Scene, ?lscale:Float = 1) {
		super(allLevels, index, parent);
		this.scene = parent;
		scale(lscale);

		ents = new Array<Entity>();
		col = new CollisionSystem(this);

		final tileSize = level.props.tileSize;
		heightPx = height * tileSize;
		widthPx = width * tileSize;

		init();
	}

	private function init() {
		final tileSize = level.props.tileSize;

		// Build collision
		var colGrid = buildStringProperty("collision");
		col.buildLevel(colGrid, width, height, tileSize);
	}

	public function addEntity(ent:Entity):Void {
		ents.push(ent);
	}

	public function removeEntity(ent:Entity):Bool {
		return ents.remove(ent);
	}

	public function addSprite(s:Sprite) {
		addChildAt(s, 1);
	}

	public function update(dt:Float):Void {
		for (ent in ents) {
			ent.update(dt);
		}
	}

	public function setCameraPos(x:Float, y:Float) {
		this.x = (scene.width >> 1) - x * scaleX;
		this.y = (scene.height >> 1) - y * scaleY;
	}
}

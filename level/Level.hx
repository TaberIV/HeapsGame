package level;

import h2d.Scene;
import h2d.CdbLevel;
import cdb.Types.Index;
import entity.Entity;
import collision.CollisionSystem;
import draw.Sprite;

typedef LevelObject = (level:Level, x:Int, y:Int, w:Int, h:Int, tileSize:Int) -> Entity;

class Level extends h2d.CdbLevel {
	private var scene:Scene;
	private var ents:Array<Entity>;
	private var levelLayer:Int;

	public var heightPx(default, null):Int;
	public var widthPx(default, null):Int;

	public var col:CollisionSystem;

	public function new(allLevels:Index<Dynamic>, index:Int, parent:Scene, ?levelLayer:Int = 1) {
		super(allLevels, index, parent);
		this.scene = parent;
		this.levelLayer = levelLayer;

		ents = new Array<Entity>();
		col = new CollisionSystem(this);

		final tileSize = level.props.tileSize;
		heightPx = height * tileSize;
		widthPx = width * tileSize;
	}

	public function buildProperty(property:String, colMap:Map<String, LevelObject>) {
		var prop = buildStringProperty(property);

		for (i in 0...prop.length) {
			var obj = colMap.get(prop[i]);

			if (obj != null) {
				obj(this, i % width, Std.int(i / width), 1, 1, level.props.tileSize);
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
		addChildAt(s, levelLayer);
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

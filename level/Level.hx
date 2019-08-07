package level;

import h2d.Scene;
import h2d.CdbLevel;
import cdb.Types.Index;
import input.PadManager;
import entity.Entity;
import collision.CollisionSystem;
import draw.Sprite;

typedef LevelObject = (level:Level, x:Int, y:Int, w:Int, h:Int) -> Entity;

class Level extends h2d.CdbLevel {
	private var scene:Scene;
	private var ents:Array<Entity>;
	private var levelLayer:Int;

	public var heightPx(default, null):Int;
	public var widthPx(default, null):Int;

	public var col:CollisionSystem;
	public var padManager:PadManager;

	public function new(allLevels:Index<Dynamic>, index:Int, parent:Scene, ?levelLayer:Int = 1) {
		super(allLevels, index, parent);
		this.scene = parent;
		this.levelLayer = levelLayer;

		ents = new Array<Entity>();
		col = new CollisionSystem(this);

		heightPx = height * level.props.tileSize;
		widthPx = width * level.props.tileSize;
	}

	public function buildProperty(property:String, propMap:Map<String, LevelObject>, ?cMap:Map<String, Bool>) {
		final tileSize = level.props.tileSize;

		var prop = buildStringProperty(property);

		for (i in 0...prop.length) {
			var kind = propMap.get(prop[i]);

			if (kind != null) {
				if (cMap == null || cMap.get(prop[i]) != true) {
					kind(this, (i % width) * tileSize, Std.int(i / width) * tileSize, tileSize, tileSize);
				}
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

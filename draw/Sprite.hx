package draw;

import h2d.Object;
import h2d.Tile;
import h2d.Bitmap;
import entity.Entity;

/**
	`Sprite` is a wrapper class for `h2d.Object`.
**/
class Sprite extends Object {
	private var ent:Entity;

	public var width(default, null):Int;
	public var height(default, null):Int;

	public var dir(default, set):Int;

	private function set_dir(dir:Int) {
		if (dir != 1 && dir != -1) {
			return this.dir;
		}

		this.dir = dir;
		scaleX = dir;
		return dir;
	}

	private static function centerTile(t) {
		return t.center();
	}

	public function new(ent:Entity) {
		super();
		this.ent = ent;
		ent.level.addSprite(this);
	}

	public static function box(ent:Entity, width:Int, height:Int, color:Int, centered:Bool) {
		var spr = new Sprite(ent);
		spr.width = width;
		spr.height = height;

		var tile = Tile.fromColor(color, width, height);
		new Bitmap(centered ? tile.center() : tile, spr);

		return spr;
	}

	private override function draw(ctx:h2d.RenderContext) {
		if (x != ent.x || y != ent.y) {
			x = ent.x;
			y = ent.y;
		}

		super.draw(ctx);
	}

	public function destroy() {
		ent = null;
		remove();
	}
}

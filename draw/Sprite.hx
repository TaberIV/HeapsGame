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

	public function new(ent:Entity) {
		super();
		this.ent = ent;
		ent.level.addSprite(this);
	}

	public static function box(ent:Entity, width:Int, height:Int, color:Int, centered:Bool) {
		var spr = new Sprite(ent);

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

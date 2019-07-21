package draw;

import h2d.Tile;
import h2d.Bitmap;

/**
	BoxSprite is used to quickly create rectangular sprites of a solid color.
**/
class BoxSprite extends Sprite {
	public override function new(ent:entity.Entity, width:Int, height:Int, color:Int, centered:Bool) {
		super(ent);

		var tile = Tile.fromColor(color, width, height);
		new Bitmap(centered ? tile.center() : tile, this);
	}
}

package draw;

/**
	BoxSprite is used to quickly create rectangular sprites of a solid color.
**/
class BoxSprite extends Sprite {
	public override function new(ent:entity.Entity, width:Int, height:Int, color:Int, centered:Bool) {
		super(ent);

		var tile = h2d.Tile.fromColor(color, width, height);
		new h2d.Bitmap(centered ? tile.center() : tile, this);
	}
}

package draw;

class BoxSprite extends Sprite {
	public override function new(ent:entity.Entity, width:Int, height:Int, color:Int, centered:Bool) {
		super(ent);

		var tile = h2d.Tile.fromColor(color, width, height);
		new h2d.Bitmap(centered ? tile.center() : tile, this);
	}
}

package draw;

class WallSprite extends Sprite {
	public override function new(ent:entity.solid.Wall) {
		super(ent);

		new h2d.Bitmap(h2d.Tile.fromColor(0x707070, ent.width, ent.height).center(), this);
	}
}

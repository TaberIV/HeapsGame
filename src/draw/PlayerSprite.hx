package draw;

class PlayerSprite extends Sprite {
	public override function new(ent:entity.actor.Player) {
		super(ent);

		new h2d.Bitmap(h2d.Tile.fromColor(0xFF0000, 32, 52).center(), this);
	}
}

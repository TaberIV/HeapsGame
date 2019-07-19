package entity.solid;

import collision.SolidCollider;

class LevelSolid extends Solid {
	public override function new(level:Level, x:Int, y:Int, w:Int, h:Int, tileSize:Int) {
		super(level, x * tileSize, y * tileSize);

		col = new SolidCollider(this, w * tileSize, h * tileSize);
	}
}

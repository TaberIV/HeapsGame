package entity.solid;

class Wall extends Solid {
	private var width:Int;
	private var height:Int;

	override public function new(level:Level, x:Float, y:Float, width:Int, height:Int) {
		super(level, x, y);

		this.width = width;
		this.height = height;

		spr = new draw.BoxSprite(this, width, height, 0x707070, false);
		col = new collision.Collider(level, this.x, this.y, width, height);
		level.col.addSolid(col);
	}
}

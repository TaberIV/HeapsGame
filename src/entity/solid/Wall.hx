package entity.solid;

class Wall extends Solid {
	public var width:Int;
	public var height:Int;

	override public function new(level:Level, x:Float, y:Float, width:Int, height:Int) {
		super(level, x, y);

		this.width = width;
		this.height = height;

		spr = new draw.WallSprite(this);
		col = new collision.Collider(level, this.x, this.y, width, height, true);
		level.col.addSolid(col);
	}
}

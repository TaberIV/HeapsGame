package entity.solid;

/**
	Wall is a quick way to create a Solid in code.
**/
class Wall extends Solid {
	private var width:Int;
	private var height:Int;

	override public function new(level:Level, x:Float, y:Float, width:Int, height:Int) {
		super(level, x, y);

		this.width = width;
		this.height = height;

		spr = new draw.BoxSprite(this, width, height, 0x707070, false);
		col = new collision.SolidCollider(this, width, height);
	}
}

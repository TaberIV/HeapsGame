package entity.solid;

class MovingWall extends Wall {
	private var xSpeed:Float;
	private var ySpeed:Float;

	public override function new(level:Level, x:Float, y:Float, width:Int, height:Int, xSpeed:Float, ySpeed:Float) {
		super(level, x, y, width, height);

		this.xSpeed = xSpeed;
		this.ySpeed = ySpeed;
	}

	public override function update(dt:Float) {
		move(xSpeed * dt, ySpeed * dt);
	}
}

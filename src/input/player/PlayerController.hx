package input.player;

class PlayerController implements Controller {
	public var xAxis:Float;
	public var yAxis:Float;

	public var jumpDown:Bool;
	public var jumpPressed:Bool;

	public function resetPressed():Void {
		jumpPressed = false;
	}
}

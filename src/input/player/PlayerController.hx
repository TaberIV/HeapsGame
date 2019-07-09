package input.player;

interface PlayerController {
	public var xAxis(get, null):Float;
	public var yAxis(get, null):Float;

	public var jumpDown(get, null):Bool;
	public var jumpPressed(get, null):Bool;
}

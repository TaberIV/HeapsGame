import entity.Entity;

class Game extends hxd.App {
	var level:Level;
	var controllers:Array<input.Controller>;

	override function init():Void {
		controllers = new Array<input.Controller>();
		setLevel(new Level(this));
	}

	function setLevel(level:Level):Void {
		setScene(level);
		this.level = level;
	}

	override function update(dt:Float):Void {
		// Update level
		if (level != null) {
			level.update(dt);
		}

		// Reset pressed inputs
		for (cont in controllers) {
			cont.resetPressed();
		}
	}

	public function registerController(controller:input.Controller):Void {
		controllers.push(controller);
	}

	static function main():Void {
		new Game();
	}
}

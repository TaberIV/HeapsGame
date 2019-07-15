class Game extends hxd.App {
	var level:Level;

	override function init():Void {
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
	}

	static function main():Void {
		new Game();
	}
}

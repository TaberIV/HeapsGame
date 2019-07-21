import h2d.Scene;

class LevelScene extends Scene {
	private var game:Game;
	private var level:Level;

	public function new(game:Game, levelIndex:Int) {
		super();
		this.game = game;
		level = new Level(this, levelIndex);
	}

	public function update(dt:Float) {
		level.update(dt);
	}
}

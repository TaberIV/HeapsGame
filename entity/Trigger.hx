package entity;

import collision.Collider;
import level.Level;
import entity.Actor;

/**
	`Triggers` act when entered by an actor.
**/
class Trigger extends Entity {
	private var actorsWithin:Array<Actor>;

	public var xMax(get, never):Int;
	public var yMax(get, never):Int;

	function get_xMax() {
		return x + col.width;
	}

	function get_yMax() {
		return y + col.height;
	}

	public dynamic function onActorEnter(a:Actor):Void {}

	public dynamic function onActorExit(a:Actor):Void {}

	public function new(level:Level, x:Float, y:Float, width:Int, height:Int) {
		super(level, x, y);

		col = new Collider(this, width, height, 0, 0);
		actorsWithin = new Array<Actor>();
	}

	public static function levelTrigger(level:Level, x:Int, y:Int, w:Int, h:Int, tileSize:Int) {
		return new Trigger(level, x * tileSize, y * tileSize, w * tileSize, h * tileSize);
	}

	public override function update(dt:Float) {
		var actors = col.getOverlapingActors();

		var actorsBefore = actorsWithin.length;
		var newActors = 0;

		for (a in actors) {
			if (actorsWithin.indexOf(a) == -1) {
				if (onActorEnter != null) {
					onActorEnter(a);
				}

				actorsWithin.push(a);
				newActors++;
			}
		}

		if (actors.length != actorsBefore + newActors) {
			var actorsLeft = new Array<Actor>();
			for (i in 0...actorsBefore) {
				if (actorsWithin[i].isDestroyed || !col.intersects(actorsWithin[i].col)) {
					actorsLeft.push(actorsWithin[i]);
				}
			}

			for (a in actorsLeft) {
				if (onActorExit != null) {
					onActorExit(a);
				}

				actorsWithin.remove(a);
			}
		}
	}
}

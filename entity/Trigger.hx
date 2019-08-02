package entity;

import collision.Collider;
import level.Level;
import entity.Actor;

/**
	`Triggers` act when entered by an actor.
**/
class Trigger extends Entity {
	private var actorsWithin:Array<Actor>;

	public var onActorEnter:Actor->Void;
	public var onActorExit:Actor->Void;

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
			trace("there exists an actor...");
			if (actorsWithin.indexOf(a) != -1) {
				if (onActorEnter != null) {
					onActorEnter(a);
				}

				actorsWithin.push(a);
				newActors++;

				trace("Enter");
			}
		}

		// ! I was drunk here so if triggers cause issues check this
		if (actorsBefore != actorsWithin.length + newActors) {
			trace("At least one left...");
			var actorsLeft = new Array<Actor>();
			for (i in 0...actorsBefore) {
				if (!col.intersects(actorsWithin[i].col)) {
					actorsLeft.push(actorsWithin[i]);
				}
			}

			for (a in actorsLeft) {
				if (onActorExit != null) {
					onActorExit(a);
				}

				actorsWithin.remove(a);
				trace("Exit");
			}
		}
	}
}

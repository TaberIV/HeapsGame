package entity;

import collision.Collider;
import level.Level;
import entity.Actor;

/**
	`Triggers` act when entered by an actor.
**/
class Trigger extends Entity {
	public var onActorEnter:Actor->Void;

	public function new(level:Level, x:Float, y:Float, width:Int, height:Int) {
		super(level, x, y);

		col = new Collider(this, width, height, 0, 0);
	}

	public static function levelTrigger(level:Level, x:Int, y:Int, w:Int, h:Int, tileSize:Int) {
		return new Trigger(level, x * tileSize, y * tileSize, w * tileSize, h * tileSize);
	}

	public override function update(dt:Float) {
		var actors = col.getOverlapingActors();

		for (a in actors) {
			onActorEnter(a);
		}
	}
}

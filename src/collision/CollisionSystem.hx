package collision;

import entity.actor.Actor;
import entity.solid.Solid;

/**
	CollisionSystem handles collisions in a level.
 */
class CollisionSystem {
	private var actors:Array<Actor>;
	private var solids:Array<Solid>;

	public function new() {
		actors = new Array<Actor>();
		solids = new Array<Solid>();
	}

	public function addActor(a:Actor):Void {
		actors.push(a);
	}

	public function removeActor(a:Actor):Bool {
		return actors.remove(a);
	}

	public function addSolid(s:Solid):Void {
		solids.push(s);
	}

	public function removeSolid(s:Solid):Bool {
		return solids.remove(s);
	}

	public function getOverlappingActors(c:Collider):Array<Actor> {
		var oActors = new Array<Actor>();
		for (a in actors) {
			if (c != a.col && a.col.intersects(c)) {
				oActors.push(a);
			}
		}

		return oActors;
	}

	public function getRidingActors(s:Solid):Array<Actor> {
		var rActors = new Array<Actor>();
		for (a in actors) {
			if (a.isRiding(s)) {
				rActors.push(a);
			}
		}

		return rActors;
	}

	public function collidesSolid(s:Collider):Bool {
		for (solid in solids) {
			if (solid.col.active && s.intersects(solid.col)) {
				return true;
			}
		}

		return false;
	}

	public function forEachActor(func:Actor->Void) {
		for (a in actors) {
			func(a);
		}
	}
}

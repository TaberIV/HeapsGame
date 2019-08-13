package collision;

import entity.JumpThroughSolid;
import level.Level;
import entity.Actor;
import entity.Solid;

/**
	CollisionSystem handles collisions in a level.
 */
class CollisionSystem {
	private var level:Level;

	public var actors(default, null):Array<Actor>;
	public var solids(default, null):Array<Solid>;
	public var jumpThroughs(default, null):Array<JumpThroughSolid>;

	public function new(level:Level) {
		this.level = level;

		actors = new Array<Actor>();
		solids = new Array<Solid>();
		jumpThroughs = new Array<JumpThroughSolid>();
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

	public function addJumpThrough(j:JumpThroughSolid) {
		jumpThroughs.push(j);
	}

	public function removeJumpThrough(j:JumpThroughSolid):Bool {
		return jumpThroughs.remove(j);
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

	public function pointsCollide(xMin:Int, yMin:Int, xMax:Int, yMax:Int) {
		for (solid in solids) {
			if (solid.col.active && Collider.pointsIntersects(xMin, yMin, xMax, yMax, solid.col)) {
				return solid;
			}
		}

		return null;
	}

	public function jumpThroughAt(xMin:Int, xMax:Int, yMax:Int) {
		for (j in jumpThroughs) {
			if (j.col.active && Collider.pointsIntersects(xMin, yMax, xMax, yMax, j.col)) {
				return j;
			}
		}

		return null;
	}
}

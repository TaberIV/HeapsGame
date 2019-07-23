package collision;

import level.Level;
import entity.Actor;
import entity.Solid;

/**
	CollisionSystem handles collisions in a level.
 */
class CollisionSystem {
	private var level:Level;

	public var actors:Array<Actor>;
	public var solids:Array<Solid>;

	public function new(level:Level) {
		this.level = level;

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

	public function buildLevel(colInfo:Array<String>, w:Int, h:Int, tileSize:Int) {
		for (i in 0...colInfo.length) {
			switch (colInfo[i]) {
				case "full":
					Solid.levelSolid(level, i % w, Std.int(i / w), 1, 1, tileSize);
			}
		}
	}

	public function pointsCollide(xMin:Int, yMin:Int, xMax:Int, yMax:Int) {
		for (solid in solids) {
			if (solid.col.active && Collider.pointsIntersects(xMin, yMin, xMax, yMax, solid.col)) {
				return solid;
			}
		}

		return null;
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
}

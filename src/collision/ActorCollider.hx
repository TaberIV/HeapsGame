package collision;

import entity.actor.Actor;
import entity.solid.Solid;

class ActorCollider extends Collider {
	private var actor:Actor;

	public override function new(ent:Actor, width:Int, height:Int, ?centered:Bool = true) {
		super(ent, width, height, centered);

		actor = ent;
		colSys.addActor(actor);
	}

	public function getSolidAt(x:Int, y:Int):Solid {
		var xMin = x - xOrigin;
		var yMin = y - yOrigin;

		var xMax = xMin + width;
		var yMax = yMin + height;

		return colSys.pointsCollide(xMin, yMin, xMax, yMax);
	}

	public function collideAt(x:Int, y:Int):Bool {
		return getSolidAt(x, y) != null;
	}

	public override function destroy() {
		colSys.removeActor(actor);
	}
}

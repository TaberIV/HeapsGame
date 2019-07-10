package collision;

import entity.solid.Solid;
import entity.actor.Actor;

class SolidCollider extends Collider {
	private var solid:Solid;

	public var active(default, set):Bool;

	private function set_active(newActive:Bool):Bool {
		if (newActive != active) {
			active = newActive;
			active ? colSys.addSolid(solid) : colSys.removeSolid(solid);
		}

		return newActive;
	}

	public function new(ent:Solid, x:Int, y:Int, width:Int, height:Int, ?centered:Bool = false) {
		super(ent, x, y, width, height, centered);

		solid = ent;
		colSys.addSolid(solid);
	}

	public function getRidingActors():Array<Actor> {
		return colSys.getRidingActors(solid);
	}

	public override function destroy() {
		colSys.removeSolid(solid);
		super.destroy();
	}
}

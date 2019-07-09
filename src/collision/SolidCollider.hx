package collision;

import entity.solid.Solid;
import entity.actor.Actor;

class SolidCollider extends Collider {
	private var solid:Solid;

	public function new(ent:Solid, x:Int, y:Int, width:Int, height:Int, ?centered:Bool = false) {
		super(ent, x, y, width, height, centered);

		solid = ent;
		colSys.addSolid(solid);
	}

	public function getRidingActors():Array<Actor> {
		return colSys.getRidingActors(cast(ent));
	}

	public override function destroy() {
		colSys.removeSolid(cast(ent));
		super.destroy();
	}
}

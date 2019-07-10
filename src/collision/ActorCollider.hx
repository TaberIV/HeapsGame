package collision;

import entity.actor.Actor;

class ActorCollider extends Collider {
	private var actor:Actor;

	public override function new(ent:Actor, x:Int, y:Int, width:Int, height:Int, ?centered:Bool = true) {
		super(ent, x, y, width, height, centered);

		actor = ent;
	}

	public override function destroy() {
		colSys.removeActor(actor);
	}
}

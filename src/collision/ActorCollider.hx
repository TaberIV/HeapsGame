package collision;

import entity.actor.Actor;

class ActorCollider extends Collider {
	private var actor:Actor;

	public override function new(ent:Actor, width:Int, height:Int, ?centered:Bool = true) {
		super(ent, width, height, centered);

		actor = ent;
		colSys.addActor(actor);
	}

	public override function destroy() {
		colSys.removeActor(actor);
	}
}

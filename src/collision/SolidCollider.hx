package collision;

import entity.solid.Solid;

class SolidCollider extends Collider {
	private var solid:Solid;

	public function new(ent:Solid, width:Int, height:Int, ?centered:Bool = false) {
		super(ent, width, height, centered);

		solid = ent;
		colSys.addSolid(solid);
	}

	public override function destroy() {
		colSys.removeSolid(solid);
		super.destroy();
	}
}

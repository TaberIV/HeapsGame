package collision;

class CollisionSystem {
	// private var actors:Array<Collider>;
	private var solids:Array<Collider>;

	public function new() {
		solids = new Array<Collider>();
	}

	public function addSolid(c:Collider) {
		solids.push(c);
	}

	public function collides(c:Collider):Bool {
		for (solid in solids) {
			if (c.intersects(solid)) {
				return true;
			}
		}

		return false;
	}
}

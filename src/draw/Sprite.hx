package draw;

import h2d.Object;
import h2d.RenderContext;
import entity.Entity;

/**
	`Sprite` is a wrapper class for `h2d.Object`.
**/
class Sprite extends Object {
	var ent:Entity;

	public function new(ent:Entity) {
		super(ent.level);
		this.ent = ent;
	}

	override private function draw(ctx:RenderContext) {
		if (x != ent.x || y != ent.y) {
			x = ent.x;
			y = ent.y;
		}

		super.draw(ctx);
	}

	public function destroy() {
		ent = null;
		remove();
	}
}

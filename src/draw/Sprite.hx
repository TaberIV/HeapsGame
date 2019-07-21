package draw;

import h2d.Object;
import entity.Entity;

/**
	`Sprite` is a wrapper class for `h2d.Object`.
**/
class Sprite extends Object {
	private var ent:Entity;

	public function new(ent:Entity) {
		super();
		this.ent = ent;
		ent.level.addSprite(this);
	}

	private override function draw(ctx:h2d.RenderContext) {
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

package draw;

/**
	`Sprite` is a wrapper class for `h2d.Object`.
**/
class Sprite extends h2d.Object {
	var ent:entity.Entity;

	public function new(ent:entity.Entity) {
		super(ent.level);
		this.ent = ent;
	}

	override private function draw(ctx:h2d.RenderContext) {
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

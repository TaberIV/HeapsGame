package draw;

import h2d.Anim;
import h2d.Tile;
import entity.Entity;

class AnimatedSprite<T> extends Sprite {
	private var anim:Anim;
	private var animMap:Map<T, Array<Tile>>;
	private var state:T;

	public function new(ent:Entity, animMap:Map<T, Array<Tile>>) {
		super(ent);

		anim = new Anim(null, 15, this);
		this.animMap = animMap;

		var tile1 = animMap.keyValueIterator().next().value[0];
		this.width = tile1.iwidth;
		this.height = tile1.iheight;
	}

	public function setAnim(state:T) {
		if (state == this.state) {
			return;
		}

		anim.play(animMap.get(state), 0);
		this.state = state;
	}

	public static function getFrames(img:hxd.res.Image, size:Int, ?xOrigin:Int, ?yOrigin:Int) {
		xOrigin = xOrigin == null ? size >> 1 : xOrigin;
		yOrigin = yOrigin == null ? size >> 1 : yOrigin;

		return img.toTile().gridFlatten(size, -xOrigin, -yOrigin);
	}
}

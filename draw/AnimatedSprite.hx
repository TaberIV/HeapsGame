package draw;

import h2d.Anim;
import h2d.Tile;
import entity.Entity;

class AnimatedSprite extends Sprite {
	private var anim:Anim;
	private var animMap:Map<String, Array<Tile>>;
	private var state:String;

	public function new(ent:Entity, size:Int, map:Map<String, hxd.res.Image>) {
		super(ent);

		width = size;
		height = size;

		anim = new Anim(null, 15, this);
		animMap = new Map<String, Array<Tile>>();

		for (s in map.keys()) {
			animMap.set(s, getFrames(map.get(s), size));
		}
	}

	public function setAnim(state:String) {
		if (state == this.state) {
			return;
		}

		anim.play(animMap.get(state), 0);
		this.state = state;
	}

	private static function getFrames(img:hxd.res.Image, size:Int) {
		return img.toTile().gridFlatten(size).map(centerTile);
	}

	private static function centerTile(t) {
		return t.center();
	}
}

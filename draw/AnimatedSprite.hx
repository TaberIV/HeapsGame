package draw;

import h2d.Anim;
import h2d.Tile;
import hxd.res.Image;
import entity.Entity;

class AnimatedSprite extends Sprite {
	private var anim:Anim;
	private var animMap:Map<String, Array<Tile>>;
	private var state:String;

	public function new(ent:Entity) {
		super(ent);

		anim = new Anim(null, 15, this);
		this.animMap = new Map();

		this.width = -1;
		this.height = -1;
	}

	public function loadFrames(state:String, frames:Array<Tile>) {
		animMap.set(state, frames);

		if (this.width == -1 || this.height == -1) {
			this.width = frames[0].iwidth;
			this.height = frames[0].iheight;
		}
	}

	public function loadAnim(state:String, img:Image, size:Int, ?xOrigin:Int, ?yOrigin:Int) {
		loadFrames(state, getFrames(img, size, xOrigin, yOrigin));
	}

	public function loadAnims(map:Map<String, Image>, size:Int, ?xOrigin:Int, ?yOrigin:Int) {
		for (kv in map.keyValueIterator()) {
			loadAnim(kv.key, kv.value, size, xOrigin, yOrigin);
		}
	}

	public function setAnim(state:String) {
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

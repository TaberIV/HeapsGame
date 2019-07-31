package draw;

import h2d.Anim;
import h2d.Tile;
import entity.Entity;

class AnimatedSprite<T> extends Sprite {
	private var anim:Anim;
	private var animMap:Map<T, Array<Tile>>;
	private var state:T;

	public function new(ent:Entity, animMap:Map<T, Array<Tile>>, ?width:Int, ?height:Int) {
		super(ent);

		anim = new Anim(null, 15, this);
		this.animMap = animMap;

		this.width = width;
		this.height = height == null ? width : height;
	}

	public function setAnim(state:T) {
		if (state == this.state) {
			return;
		}

		anim.play(animMap.get(state), 0);
		this.state = state;
	}

	public static function getFrames(img:hxd.res.Image, size:Int):Array<Tile> {
		return img.toTile().gridFlatten(size).map(Sprite.centerTile);
	}
}

package entity;

import level.Level;
import collision.Collider;

class JumpThroughSolid extends Solid {
	public static function levelJumpThrough(level:Level, x:Int, y:Int, w:Int, h:Int) {
		var j = new JumpThroughSolid(level, x, y);
		j.col = new Collider(j, w, 1, 0, 0);

		return j;
	}
}

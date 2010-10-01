package org.appworks.utils
{
	public class BinaryLogic
	{
		public function BinaryLogic()
		{
		}
		
		/**
		 * Returns true if all flagBitmask are contained in bitmask<br>
		 * example:<br>
		 * <code>
		 * flags: 0001, 1000, 0100<br>
		 * status: 1101<br>
		 * returns: true
		 * </code>
		 * 
		 * @param bitmask
		 * @param flagBitmask
		 * @return
		 */
		public static function containsAll(bitmask:int, ... flagBitmask):Boolean {
			for each(var i:int in flagBitmask) {
				if ((bitmask & i) == 0) return false;
			}
			return true;
		}
		
		/**
		 * Returns true if bitmask contains non of the flagBitmask<br>
		 * example:<br>
		 * <code>
		 * bitmask: 1001<br>
		 * flagBitmask: 0100, 0010<br>
		 * returns: true
		 * </code>
		 * 
		 * @param bitmask
		 * @param flagBitmask
		 * @return
		 */
		public static function containsNone(bitmask:int, ... flagBitmask):Boolean {
			for each(var i:int in flagBitmask) {
				if ((bitmask & i) != 0) return false;
			}
			return true;
		}
		
		/**
		 * Returns true if bitmask contains at least one of the flagBitmask
		 * 
		 * @param bitmask
		 * @param flagBitmask
		 * @see #containsAll(int, int...)
		 * @return
		 */
		public static function containsSome(bitmask:int, ... flagBitmask):Boolean {
			for each(var i:int in flagBitmask) {
				if ((bitmask & i) != 0) return true;
			}
			return false;
		}

	}
}
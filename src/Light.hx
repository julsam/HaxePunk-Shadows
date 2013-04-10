package;

/**
 * ...
 * @author Noel Berry
 */

/**
 * This class is basically just to hold the different sizes and scales
 * of all the lights. Every light added through the lighting will be rendered
 * to the screen as a light. 
 */
class Light
{
	public var x:Int;
	public var y:Int;
	public var scale:Float;
	public var alpha:Float;
	public var removed:Bool;
	
	public function new(x:Int, y:Int, scale:Float = 1, alpha:Float = 1) 
	{
		this.x = x;
		this.y = y;
		this.scale = scale;
		this.alpha = alpha;
		removed = false;
	}
}
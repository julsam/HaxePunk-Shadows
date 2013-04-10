package;

import com.haxepunk.Entity;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.Scene;
import nme.Assets;
/**
 * ...
 * @author Noel Berry
 */
class Room extends Scene
{
		
	public var lighting:Lighting;
	public var lightMouse:Light;
		
	public function new() 
	{
		super();
		//create the lighting
		add(lighting = new Lighting());
		
		//add the lights to the screen
		lighting.add(new Light(20, 20, 1, 1));
		lighting.add(lightMouse = new Light(0, 0, 1, 1));
		
		//also, just for the fun of it, lets through in a bunch of random alpha and scale
		for (i in 0...20)
		{
			lighting.add(new Light(Std.int(Math.random() * HXP.width), Std.int(Math.random() * HXP.height), Math.random(), Math.random()));
		}
		
		//add a new background
#if !flash
		var atlas = TextureAtlas.loadTexturePacker("atlas/assets.xml");
#end
		add(new Entity(0, 0, new Backdrop(#if flash "gfx/background.png" #else atlas.getRegion("background") #end)));
	}
	
	override public function update():Void 
	{
		super.update();
		
		//make the light mouse follow the mouse
		//this is just to give an example as to how you could
		//move a light around.
		lightMouse.x = Input.mouseX;
		lightMouse.y = Input.mouseY;
		
		//if you ever wanted to remove a light source, you could do:
		//lighting.remove(lightMouse);
		//for example
	}
	
}
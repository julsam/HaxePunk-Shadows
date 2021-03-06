package;

import com.haxepunk.graphics.atlas.TextureAtlas;
import flash.display.BitmapData;
import flash.display.BlendMode;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

/**
 * ...
 * @author Noel Berry
 */
class Lighting extends Entity
{
	public var canvas:BitmapData;
	public var colorTransform:ColorTransform;
	
	public var lights:Array<Light>;
	public var light:Image;
	public var atlas:TextureAtlas;
	
	public var renderTo:Point;
	
	public function new() 
	{
		super();
		
		colorTransform = new ColorTransform(1, 1, 1, 1);
		lights = new Array<Light>();
		renderTo = new Point(0, 0);
				
#if !flash
		atlas = TextureAtlas.loadTexturePacker("atlas/assets.xml");
#end
		light = new Image(#if flash "gfx/light.png" #else atlas.getRegion("light") #end);
		
		//make us above everything
		layer = 0;
		
		//create the canvas
		canvas = new BitmapData(HXP.width, HXP.height, false, 0xFFFFFF);
		
		//set the light render position to the center
		light.centerOO();
	}
	
	public function add(l:Light):Void
	{
		//add a new light to be displayed
		lights.push(l);
	}
	
	public function remove(l:Light):Void
	{
		//find the one we should remove
		for (i in 0...lights.length)
		{
			//is this the one we should remove?
			if (l == lights[i])
			{
				//it is, so set the removed value to true
				lights[i].removed = true;
				
				//then take it out of the vector (array)
				lights.splice(i, 1);
			}
		}
	}
	
	override public function render():Void 
	{
		super.render();
		
		//redraw the canvas
		canvas.fillRect(canvas.rect, 0xFFFFFF);
		
		//go through each light and render it to the canvas
		for (i in 0...lights.length)
		{
			//if this is removed, skip it
			if (lights[i].removed) { continue; }
			
			//set the light image scale and alpha properties
			light.scale = lights[i].scale;
			light.alpha = lights[i].alpha;
			
			//render the light to the canvas
			renderTo.x = lights[i].x;
			renderTo.y = lights[i].y;
			light.render(canvas, renderTo, HXP.camera);
		}
		
		// render the canvas to the screen, with
		HXP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT);
	}
}
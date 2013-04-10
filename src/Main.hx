package ;

#if flash
import org.flashdevelop.utils.FlashConnect;
#end
import nme.events.KeyboardEvent;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import nme.display.FPS;
import nme.Lib;

/**
 * ...
 * @author julsam
 */

class Main extends Engine
{
	public function new()
	{
#if flash
		FlashConnect.redirect();
#end
		
		super();
	}

	override public function init()
	{
#if android
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, androidOnKeyUp);
#end

#if debug
		HXP.console.enable();
#else
		var fps:FPS = new FPS(10, 10, 0);
		var format = fps.defaultTextFormat;
		format.size = 20;
		fps.defaultTextFormat = format;
		Lib.current.stage.addChild(fps);
#end
		
		HXP.scene = new Room();
	}
	
	private function androidOnKeyUp(e:KeyboardEvent):Void
	{
#if android
		if (e.keyCode == 27) {
			// When you call "stopPropagation" or "stopImmediatePropagation" it will cancel the default behavior 
			// for the button. Use this to disable minimizing entirely, or here, exiting the application instead.
			e.stopImmediatePropagation();
			exit();
		}
#end
	}
	
	public function exit():Void
	{
#if (android || windows || linux)
		Lib.exit();
#end
	}

	public static function main() { new Main(); }

}
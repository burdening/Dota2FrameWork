package {
	import flash.display.MovieClip;

	//import some stuff from the valve lib
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	import ValveLib.Events.InputBoxEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;
	
	public class CustomUI extends MovieClip{
		
		//these three variables are required by the engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		//constructor, you usually will use onLoaded() instead

		public function CustomUI() : void {
			trace("start this ui");
		}

		
		//this function is called when the UI is loaded
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			trace("start onloaded");
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			var daoshu:MovieClip;
			daoshu=this.addChild(countdown);
			daoshu.x=this.width/2;
			daoshu.y=this.height/2;
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!!!!!!!!");

		}
		
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {

		}
	}
}
package {
	import flash.display.MovieClip;

	//import some stuff from the valve lib
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	import ValveLib.Events.InputBoxEvent;
	import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.events.Event;
	
	public class CustomUI extends MovieClip{
		
		//these three variables are required by the engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		//constructor, you usually will use onLoaded() instead
		var a1:Boolean=false;  //s
		var a2:Boolean=false;  //x
		var a3:Boolean=false;  //z
		var a4:Boolean=false;  //y
		
		var b1:Boolean=false;
		var b2:Boolean=false;
		var b3:Boolean=false;
		var b4:Boolean=false;
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
			
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!!!!!!!!");
			this.www.visible=false;
			this.aaa.visible=false;
			this.sss.visible=false;
			this.ddd.visible=false;
			globals.GameInterface.AddKeyInputConsumer();
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
		}
		    
	   function keyDown(e:KeyboardEvent):void {
		  trace("down") 
		   
	     switch (e.charCode) {
			   case 119:                                 //监听按下事件
			     if (a1==false) {
			       this.www.visible=true;                  //w按钮变色
				   this.gameAPI.SendServerCommand("UpWalking");  //发送控制台命令 让单位往上走
				   a1=true;}
				 break;
			   case 97:
			   	 if (a2==false) {
			       this.aaa.visible=true;
				   this.gameAPI.SendServerCommand("LeftWalking");
				   a2=true;} 
				 break;
			   case 115:
			   	 if (a3==false) {
			       this.sss.visible=true;
				   this.gameAPI.SendServerCommand("DownWalking");
				   a3=true;}
				 break;
			   case 100:
			   	 if (a4==false) {
			       this.ddd.visible=true;
				   this.gameAPI.SendServerCommand("RightWalking");
				   a4=true;}
				 break;
			   case 105:			     
			     if (b1==false) {
			       this.gameAPI.SendServerCommand("TopShoot");
				   b1=true;}
		         break;  
			   case 107:
			     if (b2==false) {
			       this.gameAPI.SendServerCommand("DownShoot");
			       b2=true;}	
				 break;  
			   case 108:
			     if (b3==false) {
			       this.gameAPI.SendServerCommand("RightShoot");
				   b3=true;}
				 break;  
		       case 106:
			     if (b4==false) {
			       this.gameAPI.SendServerCommand("LeftShoot");
				   b4=true;}
			     break;				 
			   
		   }
		 //this.gameAPI.SendServerCommand( "player_key_down " + e.keyCode.toString());  
        }
			
	   function keyUp(e:KeyboardEvent):void {
		  trace("up") 
		   
	     switch (e.charCode) {
			   case 119:  //w
			     a1=false;
			     this.www.visible=false;
				 this.gameAPI.SendServerCommand("UpWalkingDone");
				 break;
			   case 97:
			     a2=false;
			     this.aaa.visible=false;
				 this.gameAPI.SendServerCommand("LeftWalkingDone");
				 break;
			   case 115:
			     a3=false;
			     this.sss.visible=false;
				 this.gameAPI.SendServerCommand("DownWalkingDone");
				 break;
			   case 100:
			     a4=false;
			     this.ddd.visible=false;
				 this.gameAPI.SendServerCommand("RightWalkingDone");
				 break;
			   case 105:
			     b1=false;
			     this.gameAPI.SendServerCommand("TopShootDone");
			     break;
			   case 107:
			     b2=false;
			     this.gameAPI.SendServerCommand("DownShootDone");
		         break;
			   case 108:
			     b3=false;
			     this.gameAPI.SendServerCommand("RightShootDone");
			     break;
		       case 106:
			     b4=false;
			     this.gameAPI.SendServerCommand("LeftShootDone");
			     break;					 
			   
		   }
		   //this.gameAPI.SendServerCommand( "player_key_up " + e.keyCode.toString());
        }
						
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {

		}
	}
}
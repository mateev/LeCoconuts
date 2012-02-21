package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Grant Clarke
	 */
	public class Player extends Sprite 
	{
		private var playerDied:Event;
		
		private var leftDown:Boolean = false;
		private var rightDown:Boolean = false;
		
		private var xSpeed:int = 4;
		
		private var score:int;
		
		private var lives:int;
		
		public function Player() 
		{
			score = 0;
			lives = 10;
			
			graphics.lineStyle(1);
			graphics.beginFill(0xff0000);
			graphics.drawRect(0, 0, 96, 32);
			graphics.endFill();
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, doKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, doKeyUp);
			
			stage.addEventListener("BLOCK_DIED", onBlockKilled);
			
			y = stage.stageHeight - 40;
			x = (stage.stageWidth - 96) * 0.5;
			
			playerDied = new Event("PLAYER_DIED");
			
			reset();
		}
		
		private function onBlockKilled(event:Event):void
		{
			lives--;
		}
		
		private function doKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
				leftDown = true;
			if (event.keyCode == Keyboard.RIGHT)
				rightDown = true;
		}
		
		private function doKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
				leftDown = false;
			if (event.keyCode == Keyboard.RIGHT)
				rightDown = false;
		}
		
		public function update():void
		{
			if (leftDown)
				x -= xSpeed;
			else if (rightDown)
				x += xSpeed;
			
			if (Lives == 0)
			{
				stage.dispatchEvent(playerDied);
			}
		}
		
		public function reset():void
		{
			score = 0;
			lives = 10;
		}
		
		public function updateScore():void
		{
			score++;
		}
		
		public function get Lives():int
		{
			return lives;
		}
		
		public function get Score():int
		{
			return score;
		}
	}

}
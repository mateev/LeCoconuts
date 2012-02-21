package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Grant Clarke
	 */
	public class Block extends Sprite 
	{		
		[Embed(source="../Coconut.jpg")]
		private var coconutImage:Class;
		
		private var ySpeed:int = 3;
		
		private var blockKilledEvent:Event;
		
		public function Block() 
		{
			var image:Bitmap = new coconutImage();
			image.scaleX = image.scaleY = image.scaleZ = 0.1;
			addChild(image); 
			/*
			graphics.lineStyle(1);
			graphics.beginFill(0x0000ff);
			graphics.drawRect(0, 0, 32, 32);
			graphics.endFill();
			*/

			blockKilledEvent = new Event("BLOCK_DIED");
		}

		public function reset():void
		{
			x = Main.randomise(0, stage.stageWidth);
			y = 0;
			
			ySpeed = Main.randomise(3, 10);
		}
		
		public function update():void
		{			
			this.y += ySpeed;
			
			if (y > stage.stageHeight)
			{
				reset();
				stage.dispatchEvent(blockKilledEvent);
			}
		}
	}

}
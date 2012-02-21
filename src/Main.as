package 
{
	import adobe.utils.CustomActions;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.engine.TextBlock;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Grant Clarke
	 */
	public class Main extends Sprite 
	{
		public static const GameOverMessage:String = "Game Over";
		private var GameOverText:TextField;
		private var GameOverButton:Sprite;
		
		private var gameOver:Boolean;
		
		private const NUM_BLOCKS_TO_CREATE:int = 10;

		private var livesCount:TextField;
		private var scoreBoard:TextField;
		
		private var player:Player;
		private var blockArray:Array; 

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
	
			gameOver = false;
			GameOverText = new TextField();
			GameOverText.x = stage.stageWidth / 2;
			GameOverText.y = stage.stageHeight / 2;
			GameOverText.text = GameOverMessage;
			GameOverText.visible = false;			
			addChild(GameOverText);

			
			GameOverButton = new Sprite();
			GameOverButton.graphics.beginFill(0x0000ff);
			GameOverButton.graphics.drawRect(0, 0, 96, 32);
			GameOverButton.graphics.endFill();
			GameOverButton.x = GameOverText.x;
			GameOverButton.y = GameOverText.y + 15;
			addChild(GameOverButton);
			GameOverButton.addEventListener(MouseEvent.CLICK, onButtonMouseClick);
			
			scoreBoard = new TextField();
			addChild(scoreBoard);
			
			livesCount = new TextField();
			livesCount.y = scoreBoard.y + 15;
			addChild(livesCount);
			
			player = new Player();
			addChild(player);
			
			initialiseBlocks();
			
			addEventListener(Event.ENTER_FRAME, update);

			stage.addEventListener("PLAYER_DIED", onPlayerDie);			
			
		}
		
		private function onButtonMouseClick(event:MouseEvent):void
		{
			player.reset();
			gameOver = false;
			GameOverText.visible = false;
		}
		
		private function onPlayerDie(event:Event):void
		{
			gameOver = true;
			GameOverText.visible = true;
		}
		
		private function update(e:Event) : void
		{
			var indexesToRemove:Array = null;
			
			if (gameOver)
				return;
			
			// update the player
			player.update();

			// update all the blocks
			for each(var block:Block in blockArray)
			{
				block.update();
				
				if (player.hitTestObject(block))
				{
					if (indexesToRemove == null)
						indexesToRemove = new Array();
					
					indexesToRemove.push(blockArray.indexOf(block));						
					player.updateScore();
				}
			}
			
			trace("test");
			
			while (indexesToRemove!=null && indexesToRemove.length != 0)
			{
				blockArray.splice(indexesToRemove.pop(), 1);
			}
			
			scoreBoard.text = "Score: " + player.Score.toString();
			livesCount.text = "Lives: " + player.Lives.toString();
		}
		
		private function initialiseBlocks():void
		{
			blockArray = new Array();
			for (var i:int = 0; i < NUM_BLOCKS_TO_CREATE; i++ )
			{
				blockArray.push(spawnBlock());
			}
		}
		
		private function spawnBlock():Block
		{
			var block:Block = new Block;
			block.x = randomise(0, stage.stageWidth);
			
			addChild(block);
			return block;
		}
		
		public static function randomise(min:Number, max:Number):Number
		{
			return (Math.random() * (max - min)) + min;
		}
				
	}
	
}
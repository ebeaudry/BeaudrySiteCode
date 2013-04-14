package controller
{
	import mx.collections.ArrayCollection;
	
	public final class ImagesController
	{
		private static var _instance:ImagesController = new ImagesController();
		
		public static function get instance():ImagesController
		{
			return _instance;
		}
		
		private var _pictureList:ArrayCollection = new ArrayCollection();
				
		private var _currentPicture:int;
		
		[Bindable]
		public function get pictureList():ArrayCollection
		{
			return _pictureList;
		}
		
		[Bindable]
		public function get currentPicture():int
		{
			return _currentPicture;
		}
		
		
		public function set pictureList(value:ArrayCollection):void
		{
			_pictureList = value;
		}
		
		public function set currentPicture(value:int):void
		{
			_currentPicture = value;
		}
		
		public function ImagesController()
		{
		}

	}
}
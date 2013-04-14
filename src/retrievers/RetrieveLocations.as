package retrievers
{
	import beans.ExcursionBean;
	import beans.LocationBean;
	import beans.LocationsBean;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public class RetrieveLocations extends EventDispatcher
	{
		private var _locationsBean:LocationsBean;
		private var _retrieveLocationsService:HTTPService = new HTTPService();
				
		private const HANDLE_FINISH:String = "HANDLE_FINISH";
		
		public function RetrieveLocations(locationBean:LocationsBean, result:Function=null):void
		{
			_locationsBean = locationBean;
			_retrieveLocationsService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			_retrieveLocationsService.url="http://www.edbeaudry.com/RetrieveAllLocations.php";
			this.addEventListener(HANDLE_FINISH, result);
			_retrieveLocationsService.addEventListener(ResultEvent.RESULT, this.handleResult);
			_retrieveLocationsService.addEventListener(FaultEvent.FAULT, this.handleFault);
		}
		
		private function handleResult(event:ResultEvent):void
		{
			var xmlNode:XML = event.result as XML;
			_locationsBean.locations = new ArrayCollection();
			for each( var node:XML in xmlNode.Location)
			{
				var location:LocationBean = new LocationBean();				
				location.locationId = node.LocationID;
				location.place = node.Place;
				location.lat = Number(node.Lat);
				location.lng = Number(node.Lng);
				location.excursions = new ArrayCollection();
				for each( var excursionXML:XML in node..Excursion )
				{
					var excursion:ExcursionBean = new ExcursionBean();
					excursion.website = excursionXML.Website;
					excursion.when = excursionXML.When;
					excursion.photoSet = excursionXML.PhotoSet;
					location.excursions.addItem(excursion);
				}
				_locationsBean.locations.addItem(location);
			}
			this.dispatchEvent(new Event(HANDLE_FINISH));
		}
		private function handleFault(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString, "Faulty Maps");
		}
		
		public function retrieveAllLocations():void
		{
			_retrieveLocationsService.send();
		}
					
	}
}
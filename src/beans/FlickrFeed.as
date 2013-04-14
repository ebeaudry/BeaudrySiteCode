package beans
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class FlickrFeed
	{
		public var title:String;
		public var entries:ArrayCollection = new ArrayCollection();
				
		public function FlickrFeed(flickrObject:Object)
		{
			if(flickrObject != null && flickrObject.stat != "fail")
			{
		//		this.title = flickrObject.title != null ? flickrObject.title : "";
				for each(var entry:Object in flickrObject.photoset.photo)//.entry)
				{
					var pic:FlickrPicture = new FlickrPicture();
					pic.id = entry.id;
					pic.link = entry.url_m;
					pic.width = entry.width_m;
					pic.height = entry.height_m;
					
					pic.smallLink = entry.url_s;
					pic.smallHeight = entry.height_s;
					pic.smallWidth = entry.width_s;
					
					pic.thumbnailLink = entry.url_t;					 
					pic.thumbnailWidth = entry.width_t;					
					pic.thumbnailHeight = entry.height_t;
				/*	for each(var link:Object in entry.link)
					{
						if(link.rel == "enclosure")
						{
							pic.link = link.href;
						}
					}*/
	//				pic.link = entry.link(@rel == "enclosure").@href;
				//	pic.title = entry.title;
				//	pic.content = entry.content;
			//		pic.thumbnailLink = pic.content.substring(pic.content.search("img src="), );
					entries.addItem(pic);					
				}
			}
		}
	}
}
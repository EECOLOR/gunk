package ee.gunk.extensions.spark
{
	import mx.core.IFactory;
	import mx.core.IUIComponent;
	
	import spark.components.supportClasses.SkinnableComponent;
	
	/**
	 * Utility class that can be used as base class for skinnable components. Adds a method 
	 * <code>setSkin</code> that can be used to inject skins
	 * <p />
	 * In sub components you can specify a method like this:
	 * 
	 * <listing>
	 *  [Inject]
	 *  [MyComponent]
	 *  public function set componentSkin(skin:Skin)
	 *  {
	 *  	setSkin(skin);
	 *  }
	 * </listing>
	 * 
	 * In your module you could then bind the skin to a specific instance:
	 * 
	 * <listing>
	 *  bind(Skin).annotatedWith(MyComponent).to(MyComponentSkin);
	 * </listing>
	 */
	public class SkinnableComponent extends spark.components.supportClasses.SkinnableComponent implements IFactory, IInjectable
	{
		public var _skin:IUIComponent;
		
		public function SkinnableComponent()
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function newInstance():*
		{
			return _skin;
		}
		
		/**
		 * Sets the skin using the skinFactory style
		 */
		protected function setSkin(skin:IUIComponent):void
		{
			_skin = skin;
			setStyle("skinFactory", this);
			attachSkin();
		}
	}
}
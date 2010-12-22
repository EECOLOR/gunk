package ee.gunk.extensions.spark
{
	import ee.gunk.Gunk;
	import ee.gunk.IInjector;
	import ee.gunk.IModule;
	import ee.gunk.util.IMap;
	import ee.gunk.util.WeakDictionaryMap;
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.FlexEvent;
	
	import spark.events.ElementExistenceEvent;

	[DefaultProperty("modules")]
	/**
	 * This class can be used as a tag in your Spark application. It will register itself 
	 * as listener for the <code>ADDED</code> event. If the target of that event implements 
	 * <code>IInjectable</code> it will be injected using the <code>IInjector.injectDependecies</code>
	 * method.
	 * <p />
	 * Injected dependencies are cached in a weak key dictionary to prevent injections from 
	 * occuring twice.
	 * <p/>
	 * Usage:
	 * <listing>
	 *  &lt;spark:Gunk&gt;
	 * 	 &lt;ee:ApplicationModule /&gt;
	 *  &lt;/spark:Gunk&gt;
	 * </listing>
	 * 
	 * @see flash.events.Event#ADDED
	 * @see ee.gunk.extensions.spark.IInjectable
	 * @see ee.gunk.IInjector#injectDependecies()
	 */
	public class Gunk
	{
		private var _injector:IInjector;
		private var _injectedInstances:IMap;
		
		public function Gunk()
		{
			_injectedInstances = new WeakDictionaryMap();
			FlexGlobals.topLevelApplication.addEventListener(Event.ADDED, _addedHandler);
		}
		
		private function _addedHandler(e:Event):void
		{
			var target:Object = e.target;
			
			if (target is IInjectable && !_injectedInstances.containsKey(target))
			{
				_injector.injectDependencies(target);
				_injectedInstances.put(e, null);
			}
		}
		
		[ArrayElementType("ee.gunk.IModule")]
		/**
		 * Default property, accepts instances of IModule
		 * 
		 * @see ee.gunk.IModule
		 */
		public function set modules(value:Array):void
		{
			_injector = ee.gunk.Gunk.createInjector.apply(null, value);
		}
	}
}
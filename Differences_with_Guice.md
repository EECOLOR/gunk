**Table of contents**


# Naming conventions #

This is an ActionScript library and the Flash player itself prefixes interfaces with an 'I'. This is the reason the names of interfaces all start with an 'I'.

# ActionScript limitations #

ActionScript has (compared to Java) a few limitations, most of them regarding annotations and generics.

## Annotations ##

Annotations in ActionScript are quite different from Java. In ActionScript they are nothing more than a piece of XML that is kept at runtime. In order to have a tiny bit of typing available when dealing with annotations Gunk requires annotations to be real objects of type `IAnnotation` (see the ASDoc for more details).

This means that the `[Type]` or `[Named]` annotation are represented by classes with the names Type and Named.

```
[Name("defaultValue", key1 = "value1", key2 = "value2")]
```

Is converted to this structure:

```
object (type derived from Name)
 |__ defaultValue: "defaultValue"
 |__ values (type IMap)
       |__ key1: "value1"
       |__ key2: "value2"
```

## Argument annotations ##

The concept of argument annotations does not exist in ActionScript. Gunk therefore introduces an arguments annotation. An examples:

This example:
```
[Arguments(0="[Named('name')]")]
public function methodName(argument1:Object):void
{
  ...
}
```
will be treated as:
```
public function methodName([Named("name")] argument1:Object):void
{
  ...
}
```

## Constructor annotations ##

For some odd reason these are not retained by `describeType()`. Gunk therefor introduces a constructor annotation. The contents of the constructor annotation will be treated as if they were placed at the constructor. Some examples:

This example:
```
[Constructor("[Inject]")]
class MyClass
{
  ...
}
```
will be treated as:
```
class MyClass
{
  [Inject]
  public function MyClass()
  {
  }
}
```

This example:
```
[Constructor("[Inject]", 0="[Named('name')]")]
class MyClass
{
  public function MyClass(argument1:Object)
  {
  }
}
```
will be treated as:
```
class MyClass
{
  [Inject]
  public function MyClass([Named("name")] argument1:Object)
  {
  }
}
```

## Generics ##

Gunk is a project that would flourish with proper generics. It might push me to the Haxe camp (if there comes a nice editor for Haxe).

## Method overloading ##

In Java you can have methods with the same name as the method is uniquely identified by it's arguments in combination with it's name. As a result Gunk sometimes has a method with a different name in order to be type safe. In other area's typing is more loose and the method accepts more then one type. The method then determines the cause of action based on the type of argument.

## Reserved words ##

In Guice you can use the `in(scope)` method to create a scoped binding. `in` is a reserved keyword in ActionScript so the method is called `inScope`.

# Provider injection #

The lack of proper generics in ActionScript forces Gunk to introduce a type annotation. A few examples:

```
[Inject]
[Type("package.Classname")]
public var provider:IProvider;
```

```
[Constructor("[Inject]", 0="[Type('package.Classname')]")]
public class MyClass
{
  public function MyClass(provider:IProvider)
  {
  }
}
```

# Unimplemented #

If you want any of these implemented, make your case in an issue.

## Eager singletons ##

Guice likes eager singletons, Gunk does not currently support it.

## Stage ##

To keep the first version simple, the concept of a Stage has not been implemented.

## Binding for the Logger ##

ActionScript does not have a `Logger` class like Java does.

## Constructor bindings ##

They are new in 3 and I missed them when creating the code.

## Custom scope annotations ##

Simply missed these when creating Gunk

## Chained linked bindings ##

Gunk does not support chained linked bindings:
```
public class BillingModule extends AbstractModule 
{
  override protected function configure():void
  {
    bind(ITransactionLog).to(DatabaseTransactionLog);
    bind(DatabaseTransactionLog).to(MySqlDatabaseTransactionLog);
  }
}
```

## Singleton annotation on provides methods ##

Simply missed these when creating Gunk

## Circular dependencies for constructors ##

In theory this could be added, it's not easy and would require the use of [AS3Commons Bytecode](http://www.as3commons.org/as3-commons-bytecode/introduction.html)
# Bindings #

The injector's job is to assemble graphs of objects. You request an instance of a given type, and it figures out what to build, resolves dependencies, and wires everything together. To specify how dependencies are resolved, configure your injector with bindings.

## Creating Bindings ##

To create bindings, extend `AbstractModule` and override its `configure` method. In the method body, call `bind()` to specify each binding. Once you've created your modules, pass them as arguments to `Gunk.createInjector()` to build an injector.

Use modules to create [linked bindings](Linked_bindings.md), [instance bindings](Instance_bindings.md), [Provides methods](Provides_methods.md), [provider bindings](Provider_bindings.md) and [untargetted bindings](Untargetted_bindings.md).

## More Bindings ##

In addition to the bindings you specify, the injector includes built-in bindings. When a dependency is requested but not found it attempts to create a just-in-time binding. The injector also includes bindings for the providers of its other bindings.
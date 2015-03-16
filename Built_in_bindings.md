# Built-in Bindings #

Alongside explicit and just-in-time bindings additional bindings are automatically included in the injector. Only the injector can create these bindings and attempting to bind them yourself is an error.

## The Injector ##

In framework code, sometimes you don't know the type you need until runtime. In this rare case you should inject the injector. Code that injects the injector does not self-document its dependencies, so this approach should be done sparingly.

## Providers ##

For every type Gunk knows about, it can also inject a Provider of that type. Injecting Providers describes this in detail.
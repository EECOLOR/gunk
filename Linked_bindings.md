# Linked Bindings #

Linked bindings map a type to its implementation. This example maps the interface `ITransactionLog` to the implementation `DatabaseTransationLog`:
```
public class BillingModule extends AbstractModule {
  override protected function configure():void
  {
    bind(ITransactionLog).to(DatabaseTransactionLog);
  }
}
```

Now, when you call `injector.getInstance(ITransactionLog)`, or when the injector encounters a dependency on `ITransactionLog`, it will use a `DatabaseTransactionLog`. Link from a type to any of its subtypes, such as an implementing class or an extending class. You can even link the concrete `DatabaseTransactionLog` class to a subclass:

```
    bind(DatabaseTransactionLog).to(MySqlDatabaseTransactionLog);
```
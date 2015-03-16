# Provider Bindings #

When your Provides methods start to grow complex, you may consider moving them to a class of their own. The provider class implements Gunk's `IProvider` interface, which is a simple, general interface for supplying values:

```
public interface IProvider
{
  function get():Object;
}
```

Our provider implementation class has dependencies of its own, which it receives via its Inject-annotated constructor. It implements the `IProvider` interface.

```
[Constructor("[Inject]")]
public class DatabaseTransactionLogProvider implements IProvider
{
  private var _connection:Connection;

  public function DatabaseTransactionLogProvider(connection:Connection)
  {
    _connection = connection;
  }

  public function get():ITransactionLog
  {
    var transactionLog:DatabaseTransactionLog = new DatabaseTransactionLog();
    transactionLog.setConnection(connection);
    return transactionLog;
  }
}
```

Finally we bind to the provider using the `.toProvider` clause:

```
public class BillingModule extends AbstractModule 
{
  override protected function configure():void
  {
    bind(ITransactionLog)
        .toProvider(DatabaseTransactionLogProvider);
  }
}
```

If your providers are complex, be sure to test them!

## Throwing Exceptions ##

Gunk does not like exceptions to be thrown from Providers.
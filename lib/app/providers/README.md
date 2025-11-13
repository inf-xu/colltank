# Global Providers

- `global_providers.dart`
  - `appDatabaseProvider`：统一管理 AppDatabase 生命周期。
  - Repository Providers：`collectionsRepositoryProvider` 等，封装 DAO 实例。
  - Usecase Providers：`createCollectionUsecaseProvider` 等，供 UI / Notifier 随处注入。

> UI 只需 `ref.watch(...)` 即可获得依赖，方便组合与测试替换。

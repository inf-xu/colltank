# 收集罐 Flutter 目录结构提案

## 设计原则
- **用户体验**：首页滚轮卡片、3×3 画框、瀑布流与拖拽交互属于高频操作，目录需让 UI 层与状态解耦，便于快速迭代交互与动效。
- **性能**：原图裁剪、缩略图生成、文件复制放入 `core/workers` 后台 isolate；Riverpod Provider 做颗粒度控 rebuild；Drift 按类别懒监听，减少 I/O。
- **工程维护**：以 Feature（功能域）+ Layer（数据/领域/UI）组合；公共基础能力固化在 `core` 与 `shared`，并通过 `build_runner` 统一生成 Riverpod、Freezed、Drift 代码。

## 顶层目录
```text
.
├── android/                                # Flutter 默认原生工程，放特定平台配置，目前吸纳更亩只有Andriod平台
├── assets/                                 # 静态资源（画框、Icon、Lottie、示例数据）
│   ├── frame/                               # 画框 PNG，命名 photo_frame_xx.png
│   ├── icons/
│   ├── mock/                                # 演示数据与调试图片
│   └── shaders/                             # 特效或模糊 Shader
├── document/                                # 需求、调研与本文档
├── lib/                                     # Dart 主工程（详见下文）
├── test/                                    # 单元与 Widget 测试
├── integration_test/                        # 端到端流程，如类别创建→导出
├── tool/                                    # 脚本（如 codegen.dart、lint.sh）
├── pubspec.yaml / pubspec.lock              # 依赖与资源声明
├── analysis_options.yaml                    # Lint 规则，约束 Riverpod/Freezed 用法
└── build/                                   # build_runner 生成物（由 gitignore 忽略）
```
- `document/thirdparty.md`、`feature.md` 承载产品与选型；此次方案写入 `document/directory.md` 方便版本化。
- `tool/codegen.dart` 可封装 `flutter pub run build_runner build --delete-conflicting-outputs`，降低同学操作成本。

## lib 目录分层
```
lib/
├── app/
├── core/
├── shared/
└── features/
```

### 1. `lib/app` —— 启动与全局路由
```text
lib/app/
├── app.dart                      # App 根组件，挂载 Riverpod、Theme、Locale
├── bootstrap.dart                # 统一初始化（Drift、日志、依赖注入）
├── router/
│   ├── app_router.dart           # go_router 配置，集中定义 ShellRoute
│   ├── routes.dart               # 枚举/常量，提供 typed 路由
│   └── observers.dart            # GoRouterObserver、NavigatorObserver
├── providers/
│   └── global_providers.dart     # 全局 Riverpod Provider（如设置、文件策略）
└── navigator_key.dart            # 全局导航 key，兼容分享/弹窗
```
- GoRouter 结合 `ShellRoute` 构建底部导航；抽屉控制在 `features/collections`，但路由守卫在此集中维护。
- `bootstrap.dart` 负责装载 Drift 数据库、读取本地配置，再注入到全局 Provider。

### 2. `lib/core` —— 基础设施（跨模块共享）
```text
lib/core/
├── config/                       # 常量、环境、feature flag
├── database/
│   ├── drift_database.dart       # DriftDatabase + Connection
│   ├── tables/                   # *.drift 或 *.dart 定义表结构
│   └── generated/                # build_runner 产物（.g.dart/.m.dart）
├── filesystem/
│   ├── directory_guard.dart      # 目录访问授权 & 权限缓存
│   └── file_policy.dart          # “复制/移动”策略枚举
├── workers/
│   ├── image_copy_worker.dart    # isolate：文件复制/裁剪/缩略图
│   └── export_canvas_worker.dart # isolate：RepaintBoundary → PNG 合成
├── services/
│   ├── analytics_service.dart    # 统计/埋点
│   ├── sharing_service.dart      # 本地分享、导出路径记录
│   └── notification_service.dart # 可选：提醒补图
├── theme/
│   ├── color_schemes.dart
│   └── typography.dart
├── utils/                        # 时间、格式化、debounce
└── logger/                       # 日志封装（如 talker/logger），配合 RiverpodObserver
```
- Drift、Isolate、文件系统、日志等保证性能与隐私策略统一实现。
- `workers/` 让所有重 IO/CPU 操作脱离主 Isolate，UI 仅监听 `AsyncValue`。

### 3. `lib/shared` —— 通用 UI 与扩展
```text
lib/shared/
├── widgets/
│   ├── app_scaffold.dart         # 通用 Scaffold，内建抽屉/导航栏样式
│   ├── adaptive_dialog.dart
│   └── riverpod_consumer.dart    # 二次封装 ConsumerWidget
├── extensions/                   # BuildContext、DateTime 扩展
├── mixins/                       # Scroll/Animation 复用逻辑
├── animations/                   # 自定义转场、Hero 适配
└── providers/                    # 复用型 Provider（如 Theme、Locale、文件策略）
```
- 避免重复造轮子，所有 Feature 共享视觉与交互组件，保障统一体验。
- `shared/providers` 可放置 `settingsProvider` 等跨页状态。

### 4. `lib/features` —— 功能域分治
```text
lib/features/
├── collections/                  # 首页 + 类别 + 详细页
│   ├── data/
│   │   ├── dtos/                 # Freezed 数据模型、json_serializable
│   │   ├── sources/
│   │   │   ├── drift/            # Drift DAO + Query（LazyQuery）
│   │   │   └── filesystem/       # 本地图片读写适配器
│   │   └── repositories/         # Repository 接口实现（Riverpod auto-dispose）
│   ├── domain/
│   │   ├── entities/             # 不可变实体（Collection、Item、FrameSetting）
│   │   └── usecases/             # 应用服务：新增类别、导出拼贴等
│   └── presentation/
│       ├── pages/
│       │   ├── home_page.dart    # 滚轮卡片、抽屉入口
│       │   ├── detail_page.dart  # 画框 + 功能按钮 + 瀑布流
│       │   └── item_editor_page.dart
│       ├── widgets/
│       │   ├── carousel_card/    # 类别卡片与热力图 UI
│       │   ├── frame_canvas/     # 3×3 画布 + 拖拽高亮
│       │   └── waterfall_grid/   # GridView + 缓存
│       ├── controllers/          # Riverpod Notifier/AsyncNotifier（状态切片）
│       └── viewmodels/           # Freezed UI 状态，便于测试
├── calendar/                     # 日历页面（table_calendar + fl_heatmap）
│   ├── data/
│   ├── domain/
│   └── presentation/
│       ├── pages/calendar_page.dart
│       └── widgets/heatmap_panel.dart
└── profile/                      # 我的页面（设置/统计）
    ├── data/
    ├── domain/
    └── presentation/
        ├── pages/profile_page.dart
        └── widgets/storage_info_card.dart
```
- 每个 Feature 目录结构保持一致，方便引入新的功能（如 AI 分类）时复制模板即可。
- Riverpod `@riverpod` 代码与 Freezed `*.freezed.dart` 产物自动落在相同目录，便于追踪。
- 拖拽交互/画框导出等复杂逻辑集中在 `presentation/widgets/frame_canvas` 内，通过 `controllers` 读取 Usecase，降低 Widget 依赖。

### 5. `lib/generated`
- build_runner 输出的 `*.g.dart`、`*.freezed.dart`、`*.gr.dart` 等统一放入 `lib/` 同级目录，由 `.gitignore` 忽略，保持源码清爽。

### 6. `lib/l10n`
- Flutter Intl 或官方 `arb` 文案，确保“类别”“画框”等术语统一；Riverpod Provider 读取当前 Locale，驱动多语言 UI。

## 资源与配置
- `assets/frame/`：内置画框 PNG，命名遵循 `photo_frame_{style}.png`，与 `FrameSetting` 枚举对应。
- `assets/mock/`：演示图片，供开发/测试；正式版可利用 `Flavor` 排除。
- `assets/icons/`：自定义 Icon 或 Lottie，配合 `cupertino_icons`。
- `document/`：需求、第三方库分析、API 契约；让产品/设计/开发共享语境。

## 测试与脚本
- `test/`：按 `core/shared/features` 镜像布置，Widget Test 重点覆盖画框拖拽、Riverpod 状态切换。
- `integration_test/`：覆盖“添加类别→上传图片→导出拼贴”主流程，确保文件策略与权限交互正确。
- `tool/`
  - `codegen.dart`：封装 `flutter pub run build_runner build --delete-conflicting-outputs`。
  - `lint.sh`：串联 `dart format`、`dart analyze`、`flutter test`，方便 CI。

通过以上目录，将 Riverpod、GoRouter、Drift、Freezed、table_calendar、fl_chart、fl_heatmap 等三方库各司其职；UI/数据/隔离线程互不耦合，既保障首页沉浸体验，又易于扩展新的收藏玩法。

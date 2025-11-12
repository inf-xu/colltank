# 数据模型与 Drift 表结构

## 设计目标
- **支撑多页面体验**：首页滚轮卡片、日历、我的页面均依赖统一的收藏数据，需保证查询维度（类别、日期、热力图、统计）可快速获取。
- **匹配本地存储策略**：所有图片仅保存在用户选定目录，数据库只保存相对路径、缩略图路径与文件元信息，便于迁移。
- **服务画框交互**：3×3 画布、拖拽替换、样式切换依赖高亮槽位表与画框模板表，需保证更新粒度足够细。
- **沉淀统计能力**：类别卡片、本年热力图、我的页面统计与空间占用依赖日维度指标与存储快照，需引入增量聚合表。

## 数据域概览
| 数据域 | 说明 | 核心表 |
| --- | --- | --- |
| 收集罐与导航 | 类别信息、卡片排序、画框样式绑定 | `collections`, `frame_styles` |
| 收藏物品 | 物品图片、属性与文件元数据 | `collectibles` |
| 画框展示 | 3×3 槽位映射、导出日志 | `highlight_slots`, `export_logs` |
| 指标统计 | 日维度热力图、空间占用 | `collection_daily_metrics`, `storage_snapshots` |
| 全局偏好 | 根目录、复制/移动策略、导出记录 | `app_preferences` |

## 实体与表结构

### 1. collections（收集罐类别）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增主键，对应文件目录与 go_router 参数。|
| name | Text | 类别名称，唯一索引；用于首页卡片、抽屉列表。|
| description | Text? | 类别描述，可选 Markdown。|
| sort_index | Int | 滚轮卡片 & 抽屉拖拽排序，数值越大越靠前。|
| frame_style_id | Int | 当前画框样式，外键 -> frame_styles.id。|
| cover_preview_path | Text? | 最新画框拼贴的缓存路径，用作卡片封面/抽屉缩略图。|
| cover_updated_at | DateTime? | 缩略图更新时间，便于决定是否重绘。|
| accent_color | Text | #AARRGGBB，卡片背景/热力图渐变主色。|
| created_at | DateTime | 创建时间。|
| updated_at | DateTime | 最近编辑或拖拽时间，用于“最近使用”排序。|

约束与索引：
- `UNIQUE(name)`，防止重名。
- `INDEX idx_collections_sort (sort_index DESC, updated_at DESC)`，支撑首页/抽屉排序。

### 2. frame_styles（画框模板）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 模板标识，可与 assets 对应（如 photo_frame_01）。|
| name | Text | 样式名称。|
| asset_path | Text | 画框 PNG 路径，例如 `assets/frame/photo_frame_01.png`。|
| overlay_mask_path | Text? | 可选遮罩/描边资源，用于合成时叠加。|
| grid_line_color | Text | 3×3 分隔线颜色。|
| background_color | Text | 画布底色。|
| metadata_json | Text | JSON，存储九宫格内边距、阴影等参数。|
| supported_layout | Text | JSON 数组，默认 `["3x3"]`，为后续布局扩展做准备。|
| is_builtin | Bool | true 表示内置模板，false 表示用户下载。|

### 3. collectibles（收藏物品图片）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增。|
| collection_id | Int | 外键 -> collections.id。|
| relative_path | Text | 相对根目录路径，如 `1/25/photo.jpg`。|
| thumbnail_path | Text? | 本地 1:1 缩略图路径，瀑布流使用。|
| file_hash | Text? | 可选 MD5，用于去重。|
| file_size_bytes | Int | 文件大小，用于空间统计。|
| display_name | Text | 物品名称。|
| story | Text? | 物语文本。|
| mood_code_point | Int | IconData.codePoint。|
| mood_font_family | Text | IconData.fontFamily。|
| mood_package | Text? | IconData.fontPackage，默认 `cupertino_icons`。|
| mood_color | Text | #AARRGGBB，用于日历/详情展示。|
| captured_at | DateTime | 收藏或拍摄时间。|
| captured_date | DateTime | 仅日期部分，便于 table_calendar / 热力图查询。|
| allow_highlight | Bool | 决定是否可进入画框。|
| sort_weight | Int | 瀑布流排序字段，默认时间戳；可手动调整。|
| is_archived | Bool | 标记为已隐藏但保留数据。|
| created_at | DateTime | 导入时间。|
| updated_at | DateTime | 最近编辑时间。|

约束：
- 若改为 `id.后缀名` 命名策略，需保证 `relative_path` 依然表示完整相对路径（如 `collectionId/collectibleId.jpg`）；若无法满足，应新增专用字段维护映射关系，避免路径解析歧义。

索引：
- `INDEX idx_collectibles_collection_sort (collection_id, sort_weight DESC, captured_at DESC)`。
- `INDEX idx_collectibles_captured_date (captured_date)`，支撑日历热力图。

### 4. highlight_slots（画框槽位映射）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增。|
| collection_id | Int | 对应 collections.id。|
| slot_index | Int | 0~8，按九宫格从左上到右下。|
| collectible_id | Int? | Nullable，表示当前槽位的物品。|
| is_locked | Bool | 若锁定则拖拽不覆盖，用于保留关键图片。|
| updated_at | DateTime | 最近一次拖拽/替换时间。|

约束：`UNIQUE(collection_id, slot_index)`；`FOREIGN KEY(collectible_id)` -> collectibles.id `ON DELETE SET NULL`。

### 5. collection_daily_metrics（类别与全局热力图指标）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增。|
| collection_id | Int? | Nullable，NULL 代表全局统计；否则对应具体类别。|
| stat_date | DateTime | 日粒度日期。|
| item_count | Int | 当日新增物品数量。|
| first_collectible_id | Int? | 当日第一条记录，便于跳转。|
| last_collectible_id | Int? | 当日最新记录。|
| last_synced_at | DateTime | 指标最近刷新时间。|

约束：`UNIQUE(collection_id, stat_date)`（Drift 中可使用 `IntColumn().nullable()` + 自定义 unique）。
- 首页卡片热力图：查询 `collection_id = 某类别 AND stat_date 在当年`。
- 我的页面热力图：查询 `collection_id IS NULL`。

### 6. export_logs（画框导出记录）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增。|
| collection_id | Int | 关联类别，便于统计导出频次。|
| export_path | Text | 最终文件的绝对路径。|
| file_name | Text | 文件名，包含时间戳，方便展示历史。|
| resolution_px | Text | 例如 `"2048x2048"`，记录导出尺寸。|
| file_size_bytes | Int | 导出文件大小。|
| created_at | DateTime | 导出时间。|

索引：`INDEX idx_export_logs_collection (collection_id, created_at DESC)`。
- 可用于“最近一次导出”的读取，也可在“我的”页面统计导出次数。

### 7. storage_snapshots（空间占用快照）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 自增。|
| collection_id | Int? | NULL 代表全局；否则为具体类别。|
| total_bytes | Int | 物品原图大小合计。|
| thumbnail_bytes | Int | 缩略图/缓存大小。|
| items_count | Int | 快照时的物品数量。|
| computed_at | DateTime | 快照生成时间。|

用途：
- “我的”页面展示空间占用趋势；
- Drawer 可快速展示类别容量。

### 8. app_preferences（全局偏好）
| 列名 | 类型 | 说明 |
| --- | --- | --- |
| id (PK) | Int | 固定 1。|
| root_directory | Text | 用户授权的根目录绝对路径。|
| import_mode | Text | `copy` 或 `move`，决定导入策略。|
| last_export_dir | Text? | 最近一次导出目录。|
| last_directory_check_at | DateTime? | 最近权限/目录有效性校验。|
| total_storage_bytes | Int? | 最近一次全局扫描得到的占用。|
| analytics_opt_in | Bool | 是否启用匿名统计（可选）。|

## 衍生视图与同步策略
- **home_card_view**（Drift View）：聚合 `collections`、`collection_daily_metrics`（当年）、`collectibles` 数量，输出卡片所需数据（名称、描述、数量、热力图数组、封面路径）。
- **calendar_entries_view**：`SELECT collection_id, captured_date, COUNT(*) AS daily_count, GROUP_CONCAT(id) AS collectible_ids FROM collectibles GROUP BY ...`，供 `table_calendar` 快速渲染。
- **瀑布流查询**：`collectibles` + 可选 `highlight_slots`（LEFT JOIN）以标记当前是否在画框中。
- **指标刷新**：
  1. 新增/删除收藏物品后，使用事务更新 `collection_daily_metrics`（类别 + 全局各一行）。
  2. 后台 isolate 定时汇总 `storage_snapshots`，并将结果写入 `app_preferences.total_storage_bytes`，供“我的”页面展示。

## Riverpod × Drift 落地建议
- 为每张表创建 `Dao` + `riverpod_annotation` 的 `Notifier`/`AsyncNotifier`：
  - `CollectionsDao`：提供 `watchWheelCards()`、`reorderCollections()`；
  - `CollectiblesDao`：提供分页瀑布流、拖拽更新、批量删除；
  - `HighlightSlotsDao`：封装 `assignSlot(slotIndex, collectibleId)` 事务。
- 使用 `Provider.family` 搭配 `watchCategoryDetail(id)`，将 `collections`、`highlight_slots`、`collectibles` 差分订阅组合成 UI 所需状态。
- 指标相关 Provider：
  - `homeHeatmapProvider(categoryId)` → 监听 `collection_daily_metrics`；
  - `globalHeatmapProvider`、`storageSnapshotProvider` 服务“我的”页面统计面板。
- 导出流程通过 `export_logs` 记录历史，并同步更新 `app_preferences.last_export_dir`，便于下次默认保存位置。

通过以上表结构与视图，应用可以覆盖“首页滚轮 + 抽屉管理”“画框拖拽 + 导出”“日历/我的页面热力图与统计”三大场景，同时保持与本地文件系统的一致性。 

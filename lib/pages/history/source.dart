import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv_dart_api/model/illust.dart';
import 'package:pixiv_func_mobile/app/platform/api/platform_api.dart';
import 'package:pixiv_func_mobile/data_content/data_source_base.dart';
import 'package:pixiv_func_mobile/services/history_service.dart';
import 'package:pixiv_func_mobile/utils/log.dart';

class HistoryListSource extends DataSourceBase<Illust> {
  static const _limit = 30;
  int offset = 0;

  int total = 0;

  @override
  bool get hasMore => offset < total || !initData;

  final HistoryService historyService = Get.find<HistoryService>();

  Future<void> removeItem(int illustId) async {
    await historyService.delete(illustId).then((column) {
      if (column > 0) {
        removeWhere((illust) => illustId == illust.id);
        --total;
        if (0 == total) {
          indicatorStatus = IndicatorStatus.empty;
        }
        setState();
      } else {
        PlatformApi.toast('失败');
      }
    }).catchError((e) {
      Log.e('删除历史记录$illustId失败 SQL异常');
    });
  }

  Future<void> clearItem() async {
    await historyService.clear();

    total = 0;
    clear();
    indicatorStatus = IndicatorStatus.empty;
    setState();
  }

  @override
  Future<List<Illust>> init(CancelToken cancelToken) async {
    total = await historyService.count();

    final result = await historyService.query(offset, _limit);
    offset += result.length;
    return result;
  }

  @override
  Future<List<Illust>> next(CancelToken cancelToken) async {
    final result = await historyService.query(offset, _limit);
    offset += result.length;
    return result;
  }

  @override
  String tag() => '$runtimeType';
}

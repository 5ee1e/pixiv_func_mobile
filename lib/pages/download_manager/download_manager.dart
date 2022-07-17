import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixiv_func_mobile/app/downloader/download_manager_controller.dart';
import 'package:pixiv_func_mobile/app/downloader/downloader.dart';
import 'package:pixiv_func_mobile/models/download_task.dart';
import 'package:pixiv_func_mobile/pages/illust/illust.dart';
import 'package:pixiv_func_mobile/widgets/scaffold/scaffold.dart';
import 'package:pixiv_func_mobile/widgets/text/text.dart';

class DownloadManagerPage extends StatelessWidget {
  const DownloadManagerPage({Key? key}) : super(key: key);

  Widget _buildItem(BuildContext context, DownloadTask task) {
    final Widget trailing;

    switch (task.state) {
      case DownloadState.idle:
        trailing = Container();
        break;
      case DownloadState.downloading:
        trailing = const RefreshProgressIndicator();
        break;
      case DownloadState.failed:
        trailing = IconButton(
          splashRadius: 20,
          onPressed: () => Downloader.start(illust: task.illust, url: task.originalUrl, id: task.id, index: task.index),
          icon: const Icon(Icons.refresh_outlined),
        );
        break;
      case DownloadState.complete:
        trailing = const Icon(Icons.file_download_done);
        break;
    }

    return Card(
      child: ListTile(
        onTap: () => Get.to(IllustPage(illust: task.illust)),
        title: TextWidget(task.illust.title, overflow: TextOverflow.ellipsis),
        subtitle: DownloadState.failed != task.state ? LinearProgressIndicator(value: task.progress) : const TextWidget('下载失败'),
        trailing: SizedBox(
          width: 48,
          child: trailing,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: '下载任务',
      child: GetBuilder<DownloadManagerController>(
        builder: (controller) {
          return ListView(
            children: [for (final task in controller.tasks) _buildItem(context, task)],
          );
        },
      ),
    );
  }
}

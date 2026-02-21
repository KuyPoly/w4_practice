import 'package:flutter/material.dart';
import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  final DownloadController controller;
  final Ressource ressource;

  const DownloadTile({
    super.key,
    required this.controller,
    required this.ressource,
  });

  int get percentage => (controller.progress * 100).toInt();
  int get progress => ((ressource.size * percentage) / 100).toInt();
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ListTile(
            tileColor: Colors.white,
            title: Text(ressource.name),
            subtitle: Text(
              "$percentage % ${statusText(controller.status)} - $progress of ${ressource.size}",
            ),
            trailing: icon(controller),
          ),
        );
      },
    );
  }
}

Widget icon(DownloadController controller) {
  switch (controller.status) {
    case DownloadStatus.notDownloaded:
      return IconButton(
        onPressed: controller.startDownload,
        icon: Icon(Icons.download),
      );
    case DownloadStatus.downloading:
      return Icon(Icons.downloading_sharp);
    case DownloadStatus.downloaded:
      return Icon(Icons.folder);
  }
}

String statusText(DownloadStatus status) {
  switch (status) {
    case DownloadStatus.notDownloaded:
      return "Not downloaded";
    case DownloadStatus.downloading:
      return "Downloading";
    case DownloadStatus.downloaded:
      return "Downloaded";
  }
}

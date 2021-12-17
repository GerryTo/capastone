import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone/constants/status.enum.dart';
import 'package:capstone/modules/feeds/model/feed.dart';
import 'package:capstone/modules/search/viewmodel/search_viewmodel.dart';
import 'package:capstone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, viewModel, _) {
      final projects = viewModel.projects;

      if (viewModel.status == Status.loading) {
        return const CircularProgressIndicator();
      }

      if (viewModel.status == Status.noData) {
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Opacity(
                  opacity: 0.4,
                  child: SvgPicture.asset(
                    'assets/noData.svg',
                    width: 300,
                    height: 300,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const Text(
                'Maaf, tidak ada yang sesuai\n dengan kamu cari',
                style: TextStyle(
                    fontSize: 16, color: Colors.grey, fontFamily: 'ReadexPro'),
                textAlign: TextAlign.center,
              ),
              //
            ],
          ),
        );
      }

      if (viewModel.status == Status.fail) {
        return Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Opacity(
                  opacity: 0.4,
                  child: SvgPicture.asset(
                    'assets/denied.svg',
                    width: 300,
                    height: 300,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              const Text(
                'Terjadi masalah, coba memuat kembali',
                style: TextStyle(
                    fontSize: 16, color: Colors.grey, fontFamily: 'ReadexPro'),
                textAlign: TextAlign.center,
              ),
              //
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return Card(
            child: SearchResultItem(project: projects[index]),
          );
        },
      );
    });
  }
}

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Feed project;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SearchResultItemPhoto(imageUrl: project.images?.first),
      onTap: () => Routes.router.navigateTo(
        context,
        Routes.detailFeed,
        routeSettings: RouteSettings(arguments: project.ref),
      ),
      title: Text(project.title ?? 'no title'),
      subtitle: Text(
        _cutText(project.description ?? ''),
      ),
    );
  }

  String _cutText(String text) {
    if (text.length > 75) {
      return text.substring(0, 75);
    }
    return text;
  }
}

class SearchResultItemPhoto extends StatelessWidget {
  const SearchResultItemPhoto({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const SizedBox.shrink();
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: 64,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_clean_architecture/di/injection.dart';

import 'package:flutter_clean_architecture/presentation/features/photo/photo_cubit.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final _photoBloc = injector.get<PhotoCubit>();

  @override
  void initState() {
    super.initState();
    _photoBloc.getPhoto();
  }

  @override
  void dispose() {
    super.dispose();
    _photoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoCubit>(
      create: (_) => _photoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Clean Architecture"),
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder<PhotoState?>(
            stream: _photoBloc.results$,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final result = snapshot.data;
                return RefreshIndicator(
                  onRefresh: () async {
                    _photoBloc.getPhoto();
                  },
                  child: _renderStatePage(result),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  Widget _renderStatePage(PhotoState? state) {
    if (state is PhotoLoaded) {
      return WidgetCustomerSuccess(state.data);
    } else if (state is PhotoError) {
      return const Text('PhotoError');
    } else if (state is PhotoLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }
}

class WidgetCustomerSuccess extends StatelessWidget {
  final dynamic data;

  const WidgetCustomerSuccess(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    print('WidgetCustomerSuccess: $data - ${data.hits}');
    return ListView.builder(
      itemCount: data.hits.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${data.hits[index].previewURL}',
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 50,
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  Flexible(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.hits[index].user}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700, // light
                              fontStyle: FontStyle.normal, // italic
                            ),
                          ),
                          Text(
                            'Thẻ: ${data.hits[index].tags}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Lượt thích: ${data.hits[index].likes}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Bình luận: ${data.hits[index].comments}',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

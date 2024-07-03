import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_clean_architecture/di/injection.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_bloc.dart';
import 'package:flutter_clean_architecture/presentation/features/photo/photo_state.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final _photoBloc = injector.get<PhotoBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _photoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Clean Architecture"),
            backgroundColor: Colors.white,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              _photoBloc.onRefresh.add(null);
            },
            child: Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: 50,
                        child: TextFormField(
                          onChanged: _photoBloc.search.add,
                          maxLength: 50,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 8.0),
                            counter: SizedBox.shrink(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Tìm kiếm',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        )),
                    Expanded(
                        child: StreamBuilder<PhotoState?>(
                            stream: _photoBloc.results$,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final result = snapshot.data;
                                return _renderStatePage(result);
                              }
                              return const SizedBox.shrink();
                            })),
                  ],
                )),
          ));
  }

  Widget _renderStatePage(PhotoState? state) {
    if (state is PhotoLoaded) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo is ScrollStartNotification) {
          } else if (scrollInfo is ScrollUpdateNotification) {
          } else if (scrollInfo is ScrollEndNotification) {
            if (state.hasReachedMax &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _photoBloc.onLoadMore.add(null);
            }
          }
          return false;
        },
        child: WidgetCustomerSuccess(state.data),
      );
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
    if (data?.length == 0) {
      return const Center(
        child: Text('No photo received'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(
          parent: Platform.isIOS
              ? const BouncingScrollPhysics()
              : const ClampingScrollPhysics()),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: '${data[index].previewURL}',
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
                            '${data[index].user}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700, // light
                              fontStyle: FontStyle.normal, // italic
                            ),
                          ),
                          Text(
                            'Thẻ: ${data[index].tags}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Lượt thích: ${data[index].likes}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Bình luận: ${data[index].comments}',
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

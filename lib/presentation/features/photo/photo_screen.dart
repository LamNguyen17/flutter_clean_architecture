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
    // context.read<PhotoCubit>().onFetched();
    _photoBloc.onFetched();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Flutter Clean Architecture"),
    //     backgroundColor: Colors.white,
    //   ),
    //   body: const Text(
    //     'You have pushed the button this many times:',
    //   ),
    // );

    return BlocProvider<PhotoCubit>(
      // create: (_) => context.read<PhotoCubit>(),
      create: (_) => _photoBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Clean Architecture"),
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (BuildContext context, state) {
            if (state is PhotoLoading) {
              return const CircularProgressIndicator();
            } else if (state is PhotoSuccess) {
              return WidgetCustomerSuccess(state.data);
            }
            return const Text('PhotoError');
          },
        ),
      ),
    );
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

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     Text(
                  //       '${data.hits[index].user}',
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       softWrap: false,
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.w700, // light
                  //         fontStyle: FontStyle.normal, // italic
                  //       ),
                  //     ),
                  //     Text('Thẻ: ${data.hits[index].tags}',
                  //       overflow: TextOverflow.ellipsis,
                  //       maxLines: 1,
                  //       softWrap: false,),
                  //     Text('Lượt thích: ${data.hits[index].likes}',
                  //       overflow: TextOverflow.ellipsis,),
                  //     Text('Bình luận: ${data.hits[index].comments}',
                  //       overflow: TextOverflow.ellipsis,),
                  //   ],
                  // ),
                ],
              ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
              //     CachedNetworkImage(
              //       imageUrl: '${data.hits[index].previewURL}',
              //       imageBuilder: (context, image) => CircleAvatar(
              //         backgroundImage: image,
              //         radius: 50,
              //       ),
              //       placeholder: (context, url) =>
              //           const CircularProgressIndicator(),
              //       errorWidget: (context, url, error) =>
              //           const Icon(Icons.error),
              //     ),
              //     Text(
              //       '${data.hits[index].user}',
              //       style: const TextStyle(
              //         fontWeight: FontWeight.w700, // light
              //         fontStyle: FontStyle.normal, // italic
              //       ),
              //     ),
              //     Text('Thẻ: ${data.hits[index].tags}'),
              //     Text('Lượt thích: ${data.hits[index].likes}'),
              //     Text('Bình luận: ${data.hits[index].comments}'),
              //   ],
              // ),
            ),
          ),
        );
      },
    );
  }
}

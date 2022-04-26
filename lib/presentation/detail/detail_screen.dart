import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lemon_tree/presentation/detail/detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lemon_tree/presentation/constants/ui_constants.dart';
import 'package:dart_date/dart_date.dart';

import '../constants/colors.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String getTimeDifference(DateTime date1, DateTime date2) {
    if (date1.differenceInDays(date2) > 0) {
      return '${date1.differenceInDays(date2)}일 전';
    } else if (date1.differenceInHours(date2) > 0) {
      return '${date1.differenceInHours(date2)}시간 전';
    } else {
      return '조금 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailViewModel>();
    final state = viewModel.state;
    final memory = state.memory;

    return Scaffold(
      backgroundColor: mainGreen,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '상세보기',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: state.isLoading || memory == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                /**
                 * 상단 바
                 * 작성자, 작성일
                 */
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('작성자: ${memory.writerName}',
                          style: defStyle.copyWith(fontSize: 16)),
                      Text(
                          '작성일: ${getTimeDifference(DateTime.now(), memory.createdAt)}',
                          style: defStyle.copyWith(fontSize: 16)),
                    ],
                  ),
                ),

                /**
                 * 레몬트리 이미지
                 */
                Container(
                  width: double.infinity,
                  height: 50.h,
                  color: Colors.white30,
                  alignment: Alignment.center,
                  child: memory.url == ''
                      ? Image.asset('asset/image/lemon.png')
                      : CachedNetworkImage(
                          imageUrl: memory.url,
                        ),
                ),

                /**
                 * 하단 바
                 * 수종, 테마
                 */
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {},
                      //       icon: Icon(
                      //         Icons.favorite_border,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     SizedBox(width: 8),
                      //     Text(
                      //       '좋아요 5개',
                      //       style: defStyle,
                      //     ),
                      //   ],
                      // ),
                      Text('수종: ${memory.woodName}',
                          style: defStyle.copyWith(fontSize: 16)),
                      Text('테마: ${memory.theme}',
                          style: defStyle.copyWith(fontSize: 16)),
                    ],
                  ),
                ),
                const Divider(color: Colors.white, height: 0),

                /**
                 * 컨텐츠 상자
                 */
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    memory.content,
                    style: defStyle,
                  ),
                ),
              ],
            ),
    );
  }
}

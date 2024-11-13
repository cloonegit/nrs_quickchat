import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:NRS_Quickchat/global_function/app_debug.dart';
import 'package:NRS_Quickchat/widget/custom_appbar.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class LiveChat extends StatefulWidget {
  String? name;
  LiveChat({super.key, this.name});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  TextEditingController chatController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool isPhotoView = false;
  String? photoUrl;
  List<Map<String, dynamic>> messages = [
    {
      'text': 'Hi there!',
      'sender': 'other',
      'datetime': DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      'text':
          'Dear Valued Customer, thank you for chatting with us, due to overwhelming chat, your chat will response within 30 minutes. If your chat is not getting response, please call us +6016 299 1398 from 9.30AM to 5.30PM Monday to Friday.',
      'sender': 'user',
      'datetime': DateTime.now().subtract(Duration(hours: 1)),
    },
    {
      'text':
          'Dear Valued Customer, thank you for contacting US through QuickChat, we are operating from 10 AM until 8PM Mondlay to Sunday. We will reply to you as soon as possible in operating hour.',
      'sender': 'user',
      'datetime': DateTime.now(),
      'isAutoReply': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    chatController.addListener(_updateOpacity);
  }

  @override
  void dispose() {
    chatController.removeListener(_updateOpacity);
    chatController.dispose();
    super.dispose();
  }

  void _updateOpacity() {
    setState(() {});
  }

  void _sendMessage() {
    if (chatController.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": chatController.text,
          "sender": "user",
          "datetime": DateTime.now()
        });
      });
      chatController.clear();
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm').format(timestamp);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        setState(() {
          messages.add({
            'text': image.path,
            'sender': 'user',
            'isImage': true,
            "datetime": DateTime.now()
          });
        });
      }
    } catch (e) {
      AppDebug().printDebug(msg: 'error in catch pick image:$e');
    }
  }

  Widget _buildBottomSheetContent() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/images/camera.png'),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        const Text(
                          'Camera',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    )),
                SizedBox(
                  width: Adaptive.w(11),
                ),
                GestureDetector(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/gallery.png'),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        const Text(
                          'Gallery',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    )),
                SizedBox(
                  width: Adaptive.w(11),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/images/cancel.png'),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        const Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void openImageGallery(BuildContext context, List imageUrls,
  //     {int initialIndex = 0}) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         child: Stack(
  //           children: [
  //             Container(
  //               height: Adaptive.h(80),
  //               width: double.infinity,
  //               child: PhotoViewGallery.builder(
  //                 backgroundDecoration: BoxDecoration(color: Colors.white),
  //                 itemCount: imageUrls.length,
  //                 pageController: PageController(initialPage: initialIndex),
  //                 builder: (context, index) {
  //                   return PhotoViewGalleryPageOptions(
  //                     imageProvider: FileImage(File(imageUrls[index])),
  //                     minScale: PhotoViewComputedScale.contained,
  //                     maxScale: PhotoViewComputedScale.covered,
  //                   );
  //                 },
  //                 scrollPhysics: BouncingScrollPhysics(),
  //                 loadingBuilder: (context, event) => Center(
  //                   child: CircularProgressIndicator(
  //                     value: event == null
  //                         ? null
  //                         : event.cumulativeBytesLoaded /
  //                             (event.expectedTotalBytes ?? 1),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               top: 10,
  //               right: 10,
  //               child: IconButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 icon: Icon(Icons.close, size: 30, color: Colors.black),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _openImagePreview(BuildContext context, String imageUrl) {
  //   showDialog(
  //     barrierColor: Colors.white,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         // width: double.infinity,
  //         // height: double.infinity,
  //         child: Dialog(
  //           insetPadding: EdgeInsets.only(left: 5),
  //           child: Stack(
  //             children: [
  //               PhotoView(
  //                 // customSize: Size.fromWidth(double.infinity),
  //                 backgroundDecoration: BoxDecoration(color: Colors.white),
  //                 imageProvider: FileImage(File(imageUrl)),
  //                 minScale: PhotoViewComputedScale.contained,
  //                 maxScale: PhotoViewComputedScale.covered,
  //               ),
  //               Positioned(
  //                   top: 0,
  //                   right: 10,
  //                   child: IconButton(
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                       icon: const Icon(Icons.close,
  //                           size: 30, color: Colors.black)))
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  List<Map<String, dynamic>> onRefresh() {
    AppDebug().printDebug(msg: 'Refresh data successfully');
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isPhotoView ? false : true,
      onPopInvokedWithResult: (didPop, dynamic) async {
        if (mounted) {
          setState(() {
            isPhotoView = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        // resizeToAvoidBottomInset: true,
        appBar: CustomAppbar(
          automaticallyImplyLeading: isPhotoView ? false : true,
          title: '${widget.name}',
          icon: isPhotoView ? Icon(Icons.close) : Icon(Icons.refresh_rounded),
          onPressed: () {
            if (isPhotoView) {
              if (mounted) {
                setState(() {
                  isPhotoView = false;
                });
              }
            } else {
              onRefresh();
            }
          },
        ),
        body: SafeArea(
            child: Column(
          children: [
            isPhotoView
                ? Expanded(
                    child: PhotoView(
                      // customSize: Size.fromWidth(double.infinity),
                      backgroundDecoration: BoxDecoration(color: Colors.white),
                      imageProvider: FileImage(File(photoUrl ?? '')),
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      itemBuilder: (context, index) {
                        final message = messages[messages.length - 1 - index];
                        final isSentMessage = message['sender'] == 'user';
                        final timestamp = message['datetime'];
                        final formattedTimestamp = formatTimestamp(timestamp);
                        return Align(
                          alignment: isSentMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            children: [
                              if (message['isAutoReply'] == true)
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0, top: 2),
                                    child: Text(
                                      'AutoReply (-) $formattedTimestamp',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      offset: Offset(0, 2),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    )
                                  ],
                                  color: isSentMessage
                                      ? Color(0xFF1565C0)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: isSentMessage
                                        ? Radius.circular(12)
                                        : Radius.zero,
                                    bottomRight: isSentMessage
                                        ? Radius.zero
                                        : Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: isSentMessage
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    message['isImage'] == true
                                        ? GestureDetector(
                                            onTap: () {
                                              if (mounted) {
                                                setState(() {
                                                  isPhotoView = true;
                                                  photoUrl = message['text'];
                                                });
                                              }

                                              // photoView(context, message['text']);

                                              // _openImagePreview(
                                              //     context, message['text']);
                                            },
                                            child: Image.file(
                                              File(message['text']),
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Text(
                                            message['text'] ?? '',
                                            style: TextStyle(
                                              color: isSentMessage
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                    SizedBox(height: 5),
                                    Text(
                                      _formatTime(message['datetime'] ?? ''),
                                      style: TextStyle(
                                        color: isSentMessage
                                            ? Colors.white70
                                            : Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
          ],
        )),

        bottomNavigationBar: Visibility(
          visible: !isPhotoView,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              color: Colors.white,
              height: Adaptive.h(12),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: Adaptive.w(2)),
                      child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          height: Adaptive.h(7),
                          width: chatController.text.isNotEmpty
                              ? Adaptive.w(80)
                              : Adaptive.w(95),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                style: const TextStyle(fontFamily: 'Poppins'),
                                controller: chatController,
                                cursorColor: Colors.red,
                                maxLines: null,
                                enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: Adaptive.w(3),
                                        right: Adaptive.w(18)),
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                    hintText: 'Type your message here',
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppDebug().printDebug(msg: 'open camera');
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _pickImage(ImageSource.camera);
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(right: Adaptive.w(11)),
                                    child: Container(
                                        // color: Colors.red,
                                        width: Adaptive.w(8),
                                        height: Adaptive.w(15),
                                        child: Image.asset(
                                          'assets/images/camera_grey.png',
                                          scale: 1,
                                          filterQuality: FilterQuality.high,
                                        )
                                        // const Icon(Icons.camera_alt)

                                        )),
                              ),
                              GestureDetector(
                                onTap: () {
                                  AppDebug().printDebug(msg: 'attach tap');
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        _buildBottomSheetContent(),
                                  );
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Container(
                                        // color: Colors.amber,
                                        width: Adaptive.w(10),
                                        height: Adaptive.w(15),
                                        child: Image.asset(
                                          'assets/images/paperclip.png',
                                          scale: 1,
                                          filterQuality: FilterQuality.high,
                                        )

                                        // Icon(Icons.attach_file)

                                        )),
                              ),
                            ],
                          )),
                    ),
                  ),
                  if (chatController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        if (chatController.text.isNotEmpty) {
                          AppDebug().printDebug(msg: 'send');
                          _sendMessage();
                        } else {
                          AppDebug().printDebug(msg: 'NOT send');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(
                          'assets/images/send.png',
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          height: 70,
                          width: 60,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

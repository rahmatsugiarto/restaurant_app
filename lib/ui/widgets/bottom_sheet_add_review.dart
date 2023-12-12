import 'package:flutter/material.dart';
import 'package:restaurant_app/common/res/styles.dart';

class BottomSheetAddReview {
  static show({
    required BuildContext context,
    required TextEditingController textController,
    required Function onSendReview,
    required Function onClose,
  }) async {
    bool isTextFormFieldNotEmpty = true;
    bool isSent = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 24,
                          width: 24,
                        ),
                        Text(
                          "Add Review",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: primaryColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            color: Colors.transparent,
                            child: const Center(
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: TextFormField(
                            controller: textController,
                            minLines: 1,
                            maxLines: 4,
                            autofocus: true,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Review',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey.shade500),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (textController.text.trim().isEmpty) {
                                  isTextFormFieldNotEmpty = true;
                                } else {
                                  isTextFormFieldNotEmpty = false;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isTextFormFieldNotEmpty) {
                            Navigator.pop(context);
                            onSendReview();
                            isSent = true;
                          }
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            color: isTextFormFieldNotEmpty
                                ? Colors.grey.shade300
                                : primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70),
                            ),
                          ),
                          child: const Icon(
                            Icons.send,
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      if (isSent) {
        onClose();
      }
      textController.clear();
    });
  }
}

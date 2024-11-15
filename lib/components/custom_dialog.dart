import 'package:flutter/material.dart';

class CustomDialog {
  static Future showConfirmation({
    required BuildContext context,
    required String title,
    required String desc,
    String? confirmBtnText,
    String? cancelBtnText,
    required Function onConfirm,
    required Function onCancel,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        Size deviceSize = MediaQuery.of(context).size;
        return Dialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: deviceSize.height * 0.032),
                Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 202, 151, 75),
                    fontSize: deviceSize.width * 0.05,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                  ),
                ),
                SizedBox(height: deviceSize.width * 0.02),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: deviceSize.width * 0.028,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: deviceSize.height * 0.02),
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Color.fromARGB(255, 202, 151, 75),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                              await onCancel();
                            },
                            child: Text(
                              cancelBtnText ?? 'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 0.5,
                        color: Color.fromARGB(255, 202, 151, 75),
                      ),
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () async {
                            await onConfirm();
                          },
                          child: Text(
                            confirmBtnText ?? 'Ok',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 202, 151, 75),
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .fontFamily,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static Future showError({
    required BuildContext context,
    required String title,
    required String desc,
    bool showCofrim = false,
    Function? onConfirm,
    Function? onCancel,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        Size deviceSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: deviceSize.height * 0.032),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.w600,
                  fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
                ),
              ),
              SizedBox(height: deviceSize.width * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  desc,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: deviceSize.width * 0.028,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.02),
              const Divider(
                color: Color.fromARGB(255, 202, 151, 75),
                thickness: 0.6,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    onCancel ?? Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily:
                          Theme.of(context).textTheme.bodyLarge!.fontFamily,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future showSuccess({
    required BuildContext context,
    required String title,
    required String desc,
    Function? onConfirm,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        Size deviceSize = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: deviceSize.height * 0.032),
              Text(
                title,
                style: TextStyle(
                  color: Color.fromARGB(
                      255, 76, 175, 80), // Green color for success
                  fontSize: deviceSize.width * 0.04,
                  fontWeight: FontWeight.w600,
                  fontFamily: Theme.of(context).textTheme.bodyLarge!.fontFamily,
                ),
              ),
              SizedBox(height: deviceSize.width * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  desc,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: deviceSize.width * 0.028,
                    fontFamily:
                        Theme.of(context).textTheme.bodyLarge!.fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: deviceSize.height * 0.02),
              const Divider(
                color: Color.fromARGB(255, 202, 151, 75),
                thickness: 0.6,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                    style: TextStyle(
                      color: Color.fromARGB(255, 76, 175, 80),
                      fontFamily:
                          Theme.of(context).textTheme.bodyLarge!.fontFamily,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

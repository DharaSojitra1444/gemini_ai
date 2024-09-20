import 'package:fluttertoast/fluttertoast.dart';
import '../constants/app_colors.dart';

showSuccessToast({toastMessage, backgroundColor, fontSize}) async {
  await Fluttertoast.showToast(
    msg: toastMessage ?? "",
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? AppColors.greenColor,
    textColor: AppColors.whiteColor,
    fontSize: fontSize ?? 14,
  );
}

showErrorToast({toastMessage, backgroundColor, fontSize}) async {
  await Fluttertoast.showToast(
    msg: toastMessage ?? "",
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor ?? AppColors.redColor,
    textColor: AppColors.whiteColor,
    fontSize: fontSize ?? 14,
  );
}

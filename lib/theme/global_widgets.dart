import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/app_utils.dart';

// PrimaryButtonMedium = Button with primary color medium size
// PrimaryButtonLarge = Button with primary color Large size
// SecondaryButtonMedium = Button with Secondary color medium size
// SecondaryButtonLarge = Button with Secondary color Large size
// OutlineButtonMedium, OutlineButtonLarge = Button with purple outline
// TextFormFeildThemed = TextFormFeild in App style
// TextAreaThemed = Multiline TextFormFeild in App style
// ThemedSwitch, ThemedSwitchController = Switch toggle
// How to use ThemedSwitch?
// final thc = Get.put(ThemedSwitchController());
// Column( children: [ThemedSwitch(),
// Obx(() => Text(thc.isOn.value.toString()))]) in Scaffold body (This line shows the value)


class VerticalSpace extends StatelessWidget {
  /// Creates a vertical space.
  ///
  /// The [s] parameter specifies the scale of the gap.
  ///
  /// Scale is a multiple of 4
  /// The default value of [s] is 1.0 which is also equivalent to 4 pixels.
  const VerticalSpace({
    this.s = 1.0,
    Key? key,
  }) : super(key: key);

  /// The scale of the gap.
  final double s;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: s * 4);
  }
}

class HorizontalSpace extends StatelessWidget {
  /// Creates a horizontal space.
  ///
  /// The [s] parameter specifies the scale of the gap.
  ///
  /// Scale is a multiple of 4
  /// The default value of [s] is 1.0 which is also equivalent to 4 pixels.
  const HorizontalSpace({
    this.s = 1.0,
    Key? key,
  }) : super(key: key);

  /// The width of the space.
  final double s;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: s * 4);
  }
}


class PrimaryButtonMedium extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? size;
  final Size? maxSize;
  final Color? color;
  final double borderRadius;
  const PrimaryButtonMedium(
      {super.key,
      required this.child,
      required this.onPressed,
      this.size,
      this.maxSize,
      this.color,
      this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          backgroundColor: color,
          fixedSize: size,
          maximumSize: maxSize,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
          disabledBackgroundColor: Colors.grey,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 16, fontWeight: FontWeight.bold)),
      child: child,
    );
  }
}

class PrimaryButtonLarge extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Size? size;
  final Size? maxSize;
  const PrimaryButtonLarge(
      {super.key,
      required this.child,
      required this.onPressed,
      this.size,
      this.maxSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: size,
          maximumSize: maxSize,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          minimumSize: Size.zero,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 24, fontWeight: FontWeight.w700)),
      child: child,
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ImageWithErrorHandling extends StatelessWidget {
  final String? imageUrl;
  const ImageWithErrorHandling({super.key, required this.imageUrl});

  ImageProvider<Object> image() => Image.network(imageUrl ?? placeholderImage,
          errorBuilder: (context, error, stackTrace) => Image.network(
                placeholderImage,
                fit: BoxFit.cover,
              ),
          fit: BoxFit.cover)
      .image;

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl ?? placeholderImage,
        errorBuilder: (context, error, stackTrace) => Image.network(
              placeholderImage,
              fit: BoxFit.cover,
            ),
        fit: BoxFit.cover);
  }
}

class OutlineButtonMedium extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Size? size;
  final Size? maxSize;
  final TextStyle? textStyle;
  final double borderRadius;
  const OutlineButtonMedium(
      {super.key,
      required this.child,
      required this.onPressed,
      this.size,
      this.maxSize,
      this.textStyle,
      this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
          fixedSize: size,
          maximumSize: maxSize,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          textStyle: textStyle ??
              const TextStyle(
                  fontFamily: "Gotham",
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
      child: child,
    );
  }
}

class ThemedSwitch extends StatelessWidget {
  final ValueChanged<bool>? onChanged;
  final bool value;
  const ThemedSwitch({super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: onChanged,
        value: value);
  }
}

class ThemedSwitchController extends GetxController {
  final isOn = false.obs;

  toggleSwitch(bool value) {
    isOn(isOn.value == false ? true : false);
  }
}

class TextFormFeildThemed extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TextFormFeildThemed(
      {super.key,
      required this.hintText,
      this.controller,
      this.obscureText,
      this.autocorrect,
      this.enableSuggestions,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.errorText,
      this.suffixIcon,
      this.keyboardType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          errorText: errorText,
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: "Gotham",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600]),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
      obscureText: obscureText ?? false,
      validator: validator,
      onSaved: onSaved,
      maxLines: 1,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class TextAreaThemed extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? autocorrect;
  final bool? enableSuggestions;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TextAreaThemed(
      {super.key,
      required this.hintText,
      this.minLines,
      this.controller,
      this.obscureText,
      this.autocorrect,
      this.enableSuggestions,
      this.validator,
      this.onSaved,
      this.onChanged,
      this.maxLines,
      this.keyboardType,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
      obscureText: obscureText ?? false,
      validator: validator,
      onSaved: onSaved,
      minLines: minLines ?? 4,
      maxLines: maxLines,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class OutlineButtonLarge extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Size? size;
  final Size? maxSize;
  const OutlineButtonLarge(
      {super.key,
      required this.child,
      required this.onPressed,
      this.size,
      this.maxSize});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        minimumSize: Size.zero,
        fixedSize: size,
        maximumSize: maxSize,
        side: BorderSide(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
        textStyle: const TextStyle(
            fontFamily: "Gotham", fontSize: 24, fontWeight: FontWeight.w500),
      ),
      child: child,
    );
  }
}

class SecondaryButtonMedium extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Size? size;
  final Size? maxSize;
  const SecondaryButtonMedium(
      {super.key,
      required this.child,
      required this.onPressed,
      this.size,
      this.maxSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
          fixedSize: size,
          maximumSize: maxSize,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 16, fontWeight: FontWeight.bold)),
      child: child,
    );
  }
}

class SecondaryButtonLarge extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const SecondaryButtonLarge(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          minimumSize: Size.zero,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 24, fontWeight: FontWeight.w700)),
      child: child,
    );
  }
}

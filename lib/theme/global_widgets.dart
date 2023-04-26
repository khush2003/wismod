import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// PrimaryButtonMedium = Button with primary color medium size
// PrimaryButtonLarge = Button with primary color Large size
// SecondaryButtonMedium = Button with Secondary color medium size
// SecondaryButtonLarge = Button with Secondary color Large size
// OutlineButtonMedium, OutlineButtonLarge = Button with purple outline
// TextFormFeildThemed = TextFormFeild in App style
// TextAreaThemed = Multiline TextFormFeild in App style
// ThemedSwitch, ThemedSwitchController = Switch toggle
// How to use ThemedSwitch?
// final thc = Get.put(ThemedSwitchController()); outside build function but inside Class, best to write after super({key}); statement
// Column( children: [ThemedSwitch(),
// Obx(() => Text(thc.isOn.value.toString()))]) in Scaffold body (This line shows the value)

class PrimaryButtonMedium extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const PrimaryButtonMedium(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 16, fontWeight: FontWeight.bold)),
      child: child,
    );
  }
}

class PrimaryButtonLarge extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const PrimaryButtonLarge(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          minimumSize: Size.zero,
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 24, fontWeight: FontWeight.w700)),
      child: child,
    );
  }
}

class OutlineButtonMedium extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const OutlineButtonMedium(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
          side: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
          textStyle: const TextStyle(
              fontFamily: "Gotham", fontSize: 16, fontWeight: FontWeight.w500)),
      child: child,
    );
  }
}

// TODO: DropdownMenuThemed

class ThemedSwitch extends StatelessWidget {
  ThemedSwitch({super.key});
  final themedSwtichController = Get.put(ThemedSwitchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CupertinoSwitch(
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (bool value) {
          themedSwtichController.toggleSwitch();
        },
        value: themedSwtichController.isOn.value));
  }
}

class ThemedSwitchController extends GetxController {
  final isOn = false.obs;

  toggleSwitch() {
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

  const TextFormFeildThemed(
      {super.key,
      required this.hintText,
      this.controller,
      this.obscureText,
      this.autocorrect,
      this.enableSuggestions,
      this.validator,
      this.onSaved,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
      enabled: null,
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
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      key: key,
      autocorrect: autocorrect ?? true,
      enableSuggestions: enableSuggestions ?? true,
      decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
      enabled: null,
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
  const OutlineButtonLarge(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        minimumSize: Size.zero,
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
  const SecondaryButtonMedium(
      {super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          minimumSize: Size.zero,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/utils/hexcolor.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputFormatter? mask;
  final String hintText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextFormField({
    super.key,
    this.mask,
    this.suffixIcon,
    this.obscureText = false,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      inputFormatters: mask != null ? [mask!] : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.normal,
          color: HexColor("#6C7072"),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: HexColor("#F2F4F5"),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: HexColor("#FF5C5C"),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: HexColor("#FF5C5C"),
          ),
        ),
      ),
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: HexColor("#161C2B"),
      ),
    );
  }
}

class EmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const EmailFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validator: validator,
      controller: controller,
      hintText: 'Email',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/mail.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class PasswordFormField extends StatelessWidget {
  final RxBool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final bool initialObscureText;

  PasswordFormField({
    super.key,
    required this.controller,
    required this.validator,
    this.hintText = 'Senha',
    this.initialObscureText = true,
  }) : obscureText = initialObscureText.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText.value,
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            width: 16,
            height: 16,
            'assets/icons/lock.svg',
            colorFilter: ColorFilter.mode(
              HexColor("#6C7072"),
              BlendMode.srcIn,
            ),
          ),
        ),
        suffixIcon: obscureText.value
            ? IconButton(
                onPressed: () => obscureText.value = !obscureText.value,
                icon: Icon(
                  Icons.visibility_off,
                  color: HexColor("#6C7072"),
                ),
              )
            : IconButton(
                onPressed: () => obscureText.value = !obscureText.value,
                icon: Icon(
                  Icons.visibility,
                  color: HexColor("#6C7072"),
                ),
              ),
      ),
    );
  }
}

class UserFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const UserFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: 'Usuário',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/user.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class NameFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const NameFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: 'Nome',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/user.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class PhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final mask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  PhoneFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: 'Telefone',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/phone.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class DateFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String hintText;
  final mask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  DateFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: hintText,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/calendar.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class ClassFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const ClassFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: 'Nome da turma',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 18,
          height: 16,
          'assets/icons/library.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class SubjectFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;

  const SubjectFormField({
    super.key,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      validator: validator,
      hintText: 'Disciplina',
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(
          width: 16,
          height: 16,
          'assets/icons/briefcase.svg',
          colorFilter: ColorFilter.mode(
            HexColor("#6C7072"),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class MaskFormatter {
  static final cepMaskFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'\d')},
  );
}

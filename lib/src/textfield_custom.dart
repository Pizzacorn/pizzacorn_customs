import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatefulWidget {
  // Control
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;

  // Texto y validación
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText; // Permite forzar un error externo si quieres
  final FormFieldValidator<String>? validator;

  // Callbacks
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<PointerDownEvent>? onTapOutside;

  // Teclado
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  // Apariencia / layout
  final bool obscureText; // Para password
  final bool showPasswordToggle; // Si quieres botón de mostrar/ocultar
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;

  // Decoración InputDecoration
  final bool filled;
  final Color? fillColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  // Prefix / Suffix
  final String? prefixText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  // Estilos opcionales
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;

  const TextFieldCustom({
    super.key,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onTapOutside,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.inputFormatters,
    this.autofillHints,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.textAlignVertical = TextAlignVertical.center,
    this.filled = true,
    this.fillColor,
    this.borderRadius = 12,
    this.contentPadding,
    this.prefixText,
    this.suffixText,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final baseTextStyle = widget.textStyle ?? theme.textTheme.bodyMedium;
    final hintStyle = widget.hintStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface.withOpacity(0.6),
        );
    final labelStyle = widget.labelStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface.withOpacity(0.7),
        );
    final helperStyle = widget.helperStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: scheme.onSurface.withOpacity(0.6),
        );
    final errorStyle = widget.errorStyle ??
        theme.textTheme.bodySmall?.copyWith(color: scheme.error);

    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
      borderSide: BorderSide(color: scheme.outline.withOpacity(0.3)),
    );

    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.showPasswordToggle) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscure = !_obscure),
        tooltip: _obscure ? 'Mostrar' : 'Ocultar',
      );
    }

    return TextFormField(
      enableInteractiveSelection: true,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      autofillHints: widget.autofillHints,
      obscureText: _obscure,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      style: baseTextStyle,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onTapOutside: widget.onTapOutside,
      autovalidateMode: (widget.errorText != null)
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        // Si no pasas validator pero forzas error externo:
        if (widget.errorText != null && widget.errorText!.isNotEmpty) {
          return widget.errorText;
        }
        return null;
      },
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: widget.labelText,
        labelStyle: labelStyle,
        floatingLabelStyle: labelStyle?.copyWith(fontWeight: FontWeight.w600),
        hintText: widget.hintText,
        hintStyle: hintStyle,
        helperText: widget.helperText,
        helperStyle: helperStyle,
        errorStyle: errorStyle,
        prefixText: widget.prefixText,
        suffixText: widget.suffixText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: effectiveSuffixIcon,
        isDense: true,
        filled: widget.filled,
        fillColor: widget.fillColor ??
            scheme.surfaceVariant.withOpacity(widget.filled ? 1 : 0),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: outline,
        enabledBorder: outline,
        focusedBorder: outline.copyWith(
          borderSide: BorderSide(color: scheme.primary),
        ),
        errorBorder: outline.copyWith(
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: outline.copyWith(
          borderSide: BorderSide(color: scheme.error),
        ),
        disabledBorder: outline,
      ),
    );
  }
}

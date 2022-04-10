// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../themes/screen_utility.dart';
//
// class EditText extends StatefulWidget {
//   final String? Function(String?)? validator;
//   final bool readOnly;
//   final void Function(String?)? onSave;
//   final void Function()? onTap;
//   final bool enabled;
//   final BorderSide? borderSide;
//   final void Function(String)? onChange;
//   final String? labelText;
//   final String? hintText;
//   final FocusNode? focusNode;
//   final bool isFocus;
//   final bool isPassword;
//   final TextInputType? type;
//   final bool isPhoneNumber;
//   final void  Function(String)? onFieldSubmit;
//   final TextInputAction? action;
//   final bool shouldDisappear;
//   final TextAlign? align;
//   final Widget? suffix;
//   final List<TextInputFormatter>? inputFormatters;
//   final Widget? prefix;
//   final double? labelFontSize;
//   final double? hintFontSize;
//   final int? maxLength;
//   final Color? labelColor;
//   final Color? hintColor;
//   final double? radius;
//   final bool upperTitle;
//   final Color? fillColor;
//   final double? fontSize;
//   final FontWeight? fontWeight;
//   final bool filled;
//   final TextEditingController? controller;
//   final int? maxLines;
//   final int? minLines;
//   final List<String>? autofillHints;
//
//   EditText({
//     this.validator,
//     this.readOnly = false,
//     this.onSave,
//     this.onChange,
//     this.borderSide,
//     this.autofillHints,
//     this.labelText,
//     this.hintText,
//     this.enabled = true,
//     this.inputFormatters,
//     this.onTap,
//     this.maxLength,
//     this.isFocus = false,
//     this.focusNode,
//     this.isPassword = false,
//     this.isPhoneNumber = false,
//     this.shouldDisappear = false,
//     this.upperTitle = false,
//     this.labelFontSize,
//     this.labelColor,
//     this.controller,
//     this.filled = false,
//     this.type,
//     this.align,
//     this.onFieldSubmit,
//     this.action,
//     this.suffix,
//     this.hintColor,
//     this.hintFontSize,
//     this.prefix,
//     this.radius,
//     this.fillColor,
//     this.fontSize,
//     this.fontWeight,
//     this.maxLines,
//     this.minLines,
//   });
//
//   @override
//   State<EditText> createState() => _EditTextState();
// }
//
// class _EditTextState extends State<EditText> {
//   bool _isObscure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         widget.upperTitle
//             ? widget.shouldDisappear
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(
//                       widget.labelText!,
//                       textAlign: TextAlign.start,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   )
//                 : const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(
//                       '',
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   )
//             : Container(),
//         TextFormField(
//           autofillHints: widget.autofillHints,
//           readOnly: widget.readOnly,
//           enabled: widget.enabled,
//           onTap: widget.onTap!,
//           inputFormatters: widget.inputFormatters,
//           maxLines: widget.maxLines ?? 1,
//           minLines: widget.minLines ?? 1,
//           // controller: widget.controller,
//           textAlign: widget.align != null ? widget.align! : TextAlign.start,
//           onChanged: widget.onChange,
//           onFieldSubmitted: widget.onFieldSubmit,
//           textInputAction: widget.action,
//           style: TextStyle(
//             fontSize: widget.fontSize,
//             fontWeight: widget.fontWeight,
//             height: 1.0,
//           ),
//           obscureText: widget.isPassword ? _isObscure : false,
//           // focusNode: widget.focusNode,
//           textDirection: TextDirection.rtl,
//           maxLength: widget.isPhoneNumber
//               ? 11
//               : widget.maxLength,
//           keyboardType: widget.type ?? TextInputType.text,
//           textAlignVertical: TextAlignVertical.center,
//           decoration: InputDecoration(
//             suffixIcon: widget.isPassword
//                 ? IconButton(
//                     onPressed: () {
//                       setState(() {
//                         _isObscure = !_isObscure;
//                       });
//                     },
//                     icon: _isObscure
//                         ? const Icon(
//                             Icons.visibility,
//                             color: Colors.grey,
//                           )
//                         : const Icon(Icons.visibility_off, color: Colors.grey),
//                   )
//                 : widget.suffix,
//             prefixIcon: widget.prefix,
//             counterText: '',
//             fillColor:
//                 widget.fillColor ?? weevoGreyColor,
//             filled: widget.filled
//                 ? true
//                 : widget.isFocus
//                     ? false
//                     : true,
//             hintText: widget.hintText,
//             labelText: widget.shouldDisappear ? '' : widget.labelText,
//             labelStyle: TextStyle(
//               color:
//                   widget.labelColor ?? Colors.black,
//               fontSize: widget.labelFontSize ?? 14.0,
//             ),
//             hintStyle: TextStyle(
//               color: widget.hintColor ?? Colors.black,
//               fontSize: widget.hintFontSize ?? 14.0,
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: widget.isFocus
//                   ? BorderSide(
//                       color: weevoDarkGreyColor,
//                       width: 2.0,
//                     )
//                   : widget.borderSide ?? BorderSide.none,
//               borderRadius: widget.radius != null
//                   ? BorderRadius.circular(
//                       widget.radius!,
//                     )
//                   : BorderRadius.circular(
//                       20.0,
//                     ),
//             ),
//             border: OutlineInputBorder(
//               borderSide: widget.isFocus
//                   ? BorderSide(
//                       color: weevoDarkGreyColor,
//                       width: 2.0,
//                     )
//                   : widget.borderSide ?? BorderSide.none,
//               borderRadius: widget.radius != null
//                   ? BorderRadius.circular(
//                       widget.radius!,
//                     )
//                   : BorderRadius.circular(
//                       20.0,
//                     ),
//             ),
//           ),
//           validator: widget.validator,
//           onSaved: widget.onSave,
//         ),
//       ],
//     );
//   }
// }

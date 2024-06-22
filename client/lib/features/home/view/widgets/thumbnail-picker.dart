import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/theme/border-style.dart';
import 'package:nightAngle/core/theme/text-style.dart';
import 'package:nightAngle/core/widgets/button.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

class ThumbnailPicker extends StatelessWidget {
  final FormGroup form;
  final String formControlName;
  const ThumbnailPicker({
    super.key,
    required this.form,
    required this.formControlName,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveImagePicker(
      formControlName: 'thumbnail',
      modes: const [
        ImagePickerMode.galleryImage,
      ],
      decoration: BorderStyles.emptyBorder,
      validationMessages: {
        'required': (err) => Texts.thumbnailRequired,
        'minLength': (err) => Texts.thumbnailRequired,
      },
      preprocessError: (e) async {
        if (e is PlatformException) {
          LoggerHelper.debug(e.code);
          switch (e.code) {
            case 'photo_access_denied':
              await photoDenied(context);
              break;
          }
        }
      },
      selectedFileViewBuilder: (file) {
        return Column(
          children: [
            Image.file(
              File(file.file!.path),
              height: 150,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: Sizes.spaceBtwItems),

            // edit
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Button(
                  variant: ButtonVariant.ghost,
                  onPressed: () {
                    form.control('thumbnail').value = null;
                  },
                  size: ButtonSize.icon,
                  icon: const Icon(
                    IconlyBold.delete,
                    size: Sizes.iconDefault,
                  ),
                ),
                Button(
                  variant: ButtonVariant.ghost,
                  onPressed: () async {
                    final filePickerRes = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (filePickerRes != null) {
                      form.control('thumbnail').value = [
                        SelectedFile.image(
                          file: filePickerRes.files.first.xFile,
                          url: filePickerRes.files.first.path,
                        )
                      ];
                    }
                  },
                  size: ButtonSize.icon,
                  icon: const Icon(
                    IconlyBold.edit,
                    size: Sizes.iconDefault,
                  ),
                ),
              ],
            )
          ],
        );
      },
      imageContainerDecoration: BoxDecoration(
        border: Border.all(
          color: Pallete.borderColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(Sizes.inputFieldRadius),
      ),
      inputBuilder: (onPressed) => GestureDetector(
        onTap: onPressed,
        child: DottedBorder(
          color: Pallete.borderColor,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          strokeCap: StrokeCap.round,
          dashPattern: const [10, 10],
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 130,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_open,
                  size: Sizes.iconLg,
                  color: Pallete.primary,
                ),
                Text(
                  Texts.uploadThumbnail,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

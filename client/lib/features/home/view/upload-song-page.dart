import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/widgets/button.dart';
import 'package:nightAngle/features/home/view/widgets/thumbnail-picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final form = FormGroup({
    'artist': FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(3)]),
    'song name': FormControl<String>(
        value: '', validators: [Validators.required, Validators.minLength(3)]),
    'thumbnail': FormControl<List<SelectedFile>>(value: [
      SelectedFile.image(
        file: XFile(
            '/Volumes/Project-2/programming/App dev/NightAngle/client/assets/app-icon.png'),
        url: '',
      )
    ], validators: [
      Validators.required
    ]),
    'song': FormControl<MultiFile<Never>>(validators: [Validators.required]),
    'color': FormControl<Color>(
        value: Pallete.primary, validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Song'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.containerSpace),
            child: Column(
              children: [
                // ------------------------------------------------------------ Reactive Form------------------------------------------------------------

                ReactiveForm(
                  formGroup: form,
                  child: Column(
                    children: [
                      // ---------------------------------------thumbnail---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),
                      ThumbnailPicker(
                        form: form,
                        formControlName: 'thumbnail',
                      ),

                      // ---------------------------------------song---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),
                      Container(
                        constraints:
                            const BoxConstraints(minHeight: 0, maxHeight: 300),
                        child: ReactiveFilePicker(
                            formControlName: 'song',
                            lockParentWindow: true,
                            allowMultiple: false,
                            allowedExtensions: const [
                              'wav',
                              'aiff',
                              'alac',
                              'flac',
                              'mp3',
                              'aac',
                              'wma',
                              'ogg'
                            ],
                            filePickerBuilder: (pickImage, files, onChange) {
                              return Column(
                                children: [
                                  Button(
                                    onPressed: pickImage,
                                    text: 'Pick Song',
                                    icon: const Icon(Icons.music_note),
                                  ),
                                ],
                              );
                            }),
                      ),
                      // ---------------------------------------Artist---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),
                      ReactiveTextField(
                        formControlName: 'artist',
                        decoration: const InputDecoration(
                          hintText: 'Artist',
                        ),
                      ),

                      // ---------------------------------------song name---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),
                      ReactiveTextField(
                        formControlName: 'song name',
                        decoration: const InputDecoration(
                          hintText: 'Pick Song',
                        ),
                      ),
                      // ---------------------------------------Color Picker---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),
                      ColorPicker(
                        onColorChanged: (color) {
                          form.control('color').value = color;
                        },
                        // Use the color from the form
                        color: form.control('color').value,
                        pickersEnabled: const {ColorPickerType.wheel: true},
                      ),

                      // ---------------------------------------Upload Button---------------------------
                      const SizedBox(height: Sizes.spaceBtwItems),

                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          variant: ButtonVariant.secondary,
                          onPressed: () {
                            LoggerHelper.debug(form.value.toString());
                          },
                          text: 'Upload',
                          icon: const Icon(
                            Icons.upload,
                            color: Pallete.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

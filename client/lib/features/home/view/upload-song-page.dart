import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/theme/border-style.dart';
import 'package:nightAngle/core/widgets/button.dart';
import 'package:nightAngle/features/home/view/widgets/audio-wave.dart';
import 'package:nightAngle/features/home/view/widgets/thumbnail-picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

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
    'song': FormControl<MultiFile<String>>(
        value: const MultiFile<String>(
          platformFiles: [],
        ),
        validators: [Validators.required]),
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
                      ReactiveFilePicker<String>(
                        decoration: BorderStyles.emptyBorder,
                        formControlName: 'song',
                        allowMultiple: false,
                        filePickerBuilder: (pickAudio, files, onChange) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ---------------------------------------preview---------------------------

                              files.platformFiles.isNotEmpty
                                  ? AudioWave(
                                      path: files.platformFiles.first.path
                                          .toString(),
                                    )
                                  : const SizedBox(),

                              // select and remove button
                              Row(
                                children: [
                                  // ---------------------------------------Select Button---------------------------
                                  Button(
                                    variant: ButtonVariant.secondary,
                                    onPressed: pickAudio,
                                    label: const Text('Select Song'),
                                    icon: const Icon(
                                      Icons.music_note,
                                      color: Pallete.black,
                                    ),
                                  ),
                                  const SizedBox(width: Sizes.spaceBtwItems),
                                  // ---------------------------------------Remove Button---------------------------
                                ],
                              ),
                            ],
                          );
                        },
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
                          onPressed: () async {
                            final files =
                                form.control('song').value as MultiFile<String>;
                            LoggerHelper.debug(
                                files.platformFiles.first.path.toString());
                            final metadata = await MetadataRetriever.fromFile(
                              File(files.platformFiles.first.path.toString()),
                            );

                            LoggerHelper.info(metadata.toString());
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

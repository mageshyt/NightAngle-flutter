import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:reactive_file_picker/reactive_file_picker.dart';

import 'package:nightAngle/core/core.dart';
import 'package:nightAngle/core/theme/border-style.dart';

import 'package:nightAngle/features/home/view/widgets/upload-page/audio-wave.dart';
import 'package:nightAngle/features/home/view/widgets/upload-page/thumbnail-picker.dart';
import 'package:nightAngle/features/home/viewmodel/home_viewmodel.dart';

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
    'thumbnail': FormControl<List<SelectedFile>>(
        value: [], validators: [Validators.required, Validators.minLength(1)]),
    'song': FormControl<MultiFile<String>>(
        value: const MultiFile<String>(
          platformFiles: [],
        ),
        validators: [
          Validators.required,
        ]),
    'color': FormControl<Color?>(
      value: Pallete.primary,
      validators: [Validators.required],
    ),
  });

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(homeViewModelProvider.select((val) => val?.isLoading ?? false));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Song'),
          actions: [
            IconButton(
              icon: const Icon(IconlyLight.upload),
              onPressed: () async {
                if (form.control('song').value.platformFiles.isEmpty) {
                  form.setErrors({
                    'song': {"required": true},
                  }, markAsDirty: true);
                  LoggerHelper.debug(
                      form.errors.containsKey('song').toString());
                }

                if (!form.valid) {
                  form.markAllAsTouched();
                  // return;/
                }
                await ref.read(homeViewModelProvider.notifier).uploadSong(
                      selectedAudio: File(
                        form
                            .control('song')
                            .value
                            .platformFiles[0]
                            .path
                            .toString(),
                      ),
                      selectedThumbnail: File(
                          form.control('thumbnail').value.first.file!.path),
                      songName: form.control('song name').value,
                      artist: form.control('artist').value,
                      hexCode: (form.control('color').value),
                      context: context,
                    );

                // remove the errors

                // push to home page

                GoRouter.of(context).pushNamed(RoutesName.home);
              },
            )
          ],
        ),
        body:
            // ---------------------------------------Loading Indicator---------------------------
            isLoading
                ? const Center(
                    child: Loader(),
                  )
                : SingleChildScrollView(
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
                                  validationMessages: {
                                    'required': (context) =>
                                        'Please select a song',
                                    'minLength': (context) =>
                                        'Please select a song',
                                  },
                                  decoration: BorderStyles.emptyBorder,
                                  formControlName: 'song',
                                  allowMultiple: false,
                                  allowCompression: true,
                                  filePickerBuilder:
                                      (pickAudio, files, onChange) {
                                    final bool hasFile =
                                        files.platformFiles.isNotEmpty;
                                    return Column(
                                      crossAxisAlignment: hasFile
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        // ---------------------------------------preview---------------------------

                                        hasFile
                                            ? AudioWave(
                                                path: files
                                                    .platformFiles.first.path
                                                    .toString(),
                                              )
                                            : const SizedBox(),

                                        // select and remove button
                                        hasFile
                                            ? Button(
                                                variant:
                                                    ButtonVariant.destructive,
                                                onPressed: () {
                                                  onChange(
                                                      const MultiFile<String>(
                                                    platformFiles: [],
                                                  ));
                                                },
                                                size: ButtonSize.icon,
                                                icon: const Icon(
                                                  IconlyBold.delete,
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  Button(
                                                    variant:
                                                        ButtonVariant.secondary,
                                                    onPressed: pickAudio,
                                                    label: const Text(
                                                        'Select Song'),
                                                    icon: const Icon(
                                                      Icons.music_note,
                                                      color: Pallete.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          Sizes.spaceBtwItems),
                                                  // ---------------------------------------Error Message---------------------------
                                                  form.errors
                                                          .containsKey('song')
                                                      ? Text(
                                                          'Please select a song',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.red[200],
                                                          ),
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        // ---------------------------------------Remove Button---------------------------
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
                                    hintText: 'Song Name',
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
                                  pickersEnabled: const {
                                    ColorPickerType.wheel: true
                                  },
                                ),

                                // ---------------------------------------Upload Button---------------------------
                                const SizedBox(height: Sizes.spaceBtwItems),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}

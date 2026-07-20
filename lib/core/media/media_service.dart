import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

/// A picked file: its on-disk [path] and display [name].
typedef PickedFile = ({String path, String name});

/// Thin wrapper over `image_picker` / `file_picker`. Injected via `sl` so
/// widgets never construct a picker directly. Returns `null` when the user
/// cancels; callers decide what to do with the path.
class MediaService {
  MediaService([ImagePicker? imagePicker])
    : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  /// Pick a single image from the camera or gallery; downscaled to keep memory
  /// and (future) upload size reasonable.
  Future<String?> pickImage(ImageSource source) async {
    final file = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 85,
    );
    return file?.path;
  }

  /// Pick a single PDF document (lab results).
  Future<PickedFile?> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    final file = result?.files.singleOrNull;
    final path = file?.path;
    if (file == null || path == null) return null;
    return (path: path, name: file.name);
  }
}

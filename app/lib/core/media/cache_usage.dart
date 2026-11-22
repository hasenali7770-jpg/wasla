/// Disk usage of a media folder.
class CacheUsage {
  const CacheUsage(this.files, this.bytes);
  final int files;
  final int bytes;
  static const empty = CacheUsage(0, 0);
}

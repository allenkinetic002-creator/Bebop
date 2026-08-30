class SizeOption {
  final String id;
  final String name;
  final String volume;
  final String imageUrl;
  bool isSelected;
  bool isAdded;

  SizeOption({
    required this.id,
    required this.name,
    required this.volume,
    required this.imageUrl,
    this.isSelected = false,
    this.isAdded = false,
  });
}

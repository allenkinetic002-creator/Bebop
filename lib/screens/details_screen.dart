import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/size_option.dart';
import '../widgets/wavy_header.dart';
import '../widgets/size_option_card.dart';
import 'joy_boon_screen.dart';

class DetailsScreen extends StatefulWidget {
  final String drinkName;
  final String drinkImageUrl;
  final int initialCartCount;

  const DetailsScreen({
    super.key,
    this.drinkName = 'Caramel Frappuccino',
    this.drinkImageUrl =
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&auto=format&fit=crop&q=80',
    this.initialCartCount = 0,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late int _cartCount;
  int _orderQty = 1;

  final List<SizeOption> _sizeOptions = [
    SizeOption(
      id: 'size_1',
      name: 'Tall',
      volume: '12 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
      isSelected: true,
      isAdded: true,
    ),
    SizeOption(
      id: 'size_2',
      name: 'Grande',
      volume: '16 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_3',
      name: 'Venti',
      volume: '24 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_4',
      name: 'Custom',
      volume: '+ \$1.00',
      imageUrl:
          'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_5',
      name: 'Trenta',
      volume: '31 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_6',
      name: 'Venti Iced',
      volume: '24 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_7',
      name: 'Tall Iced',
      volume: '12 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&auto=format&fit=crop&q=80',
    ),
    SizeOption(
      id: 'size_8',
      name: 'Short',
      volume: '8 fl oz',
      imageUrl:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=200&auto=format&fit=crop&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _cartCount = widget.initialCartCount > 0 ? widget.initialCartCount : 1;
  }

  void _navigateToJoyBoon() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const JoyBoonScreen(initialCount: 12),
      ),
    );
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF013D29),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Organic Wavy Header (Cart click loops to JoyBoonScreen)
          WavyHeader(
            cartCount: _cartCount,
            onNotificationTap: () => _showToast('No new notifications'),
            onCartTap: () => _navigateToJoyBoon(),
          ),

          // 2. Scrollable Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Top Bar: Back Button & "Details" Title
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFF013D29),
                              size: 28,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Details',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF013D29),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Hero Section
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF013D29),
                                width: 3.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF013D29).withOpacity(0.12),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                widget.drinkImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            widget.drinkName,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF013D29),
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Best Seller',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4D7364),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // "Size Options" Section Header
                    Text(
                      'Size Options',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4D7364),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 8 Size Options Grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _sizeOptions.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: constraints.maxWidth > 800
                                ? 8
                                : constraints.maxWidth > 500
                                    ? 4
                                    : 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.76,
                          ),
                          itemBuilder: (context, index) {
                            final option = _sizeOptions[index];
                            return SizeOptionCard(
                              option: option,
                              onCardTap: () {
                                setState(() {
                                  for (var o in _sizeOptions) {
                                    o.isSelected = false;
                                  }
                                  option.isSelected = true;
                                });
                                _showToast('Selected: ${option.name}');
                              },
                              onAddTap: () {
                                setState(() {
                                  option.isAdded = !option.isAdded;
                                  if (option.isAdded) {
                                    _cartCount++;
                                  } else {
                                    _cartCount =
                                        _cartCount > 0 ? _cartCount - 1 : 0;
                                  }
                                });
                                _showToast(
                                  option.isAdded
                                      ? 'Added ${option.name} size'
                                      : 'Removed ${option.name} size',
                                );
                              },
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Bottom Controls
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_orderQty > 1) {
                                      setState(() {
                                        _orderQty--;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF013D29),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  child: Text(
                                    '$_orderQty',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF013D29),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _orderQty++;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF013D29),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),

                          GestureDetector(
                            onTap: () =>
                                _showToast('Opening Coffee Concierge...'),
                            child: Container(
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              decoration: BoxDecoration(
                                color: const Color(0xFF013D29),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF013D29)
                                        .withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.chat_bubble_outline_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Message',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmoothScreen extends StatefulWidget {
  final int initialCount;

  const SmoothScreen({
    super.key,
    this.initialCount = 1,
  });

  @override
  State<SmoothScreen> createState() => _SmoothScreenState();
}

class _SmoothScreenState extends State<SmoothScreen> {
  late int _smoothQty;

  final List<SmoothCategory> _categories = [
    SmoothCategory(
      id: 'c1',
      name: 'HOT COFFEE',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c2',
      name: 'DRINKS',
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c3',
      name: 'HOT TEAS',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c4',
      name: 'BAKERY',
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c5',
      name: 'ICED ESPRESSO',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c6',
      name: 'COLD BREW',
      imageUrl:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c7',
      name: 'PASTA',
      imageUrl:
          'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=250&auto=format&fit=crop&q=80',
    ),
    SmoothCategory(
      id: 'c8',
      name: 'DESSERTS',
      imageUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=250&auto=format&fit=crop&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _smoothQty = widget.initialCount;
  }

  void _loopBackToHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
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
          // 1. Top Green Wave Header
          Container(
            color: const Color(0xFF013D29),
            padding: const EdgeInsets.only(
                top: 40, left: 24, right: 24, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const ClipOval(
                    child: Image(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&auto=format&fit=crop&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () => _showToast('No new notifications'),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _loopBackToHome(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/hand.png',
                          width: 26,
                          height: 26,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.touch_app, color: Colors.white, size: 26),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. Hero Title Band
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Smooth Out\nYour Everyday',
                style: GoogleFonts.poppins(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF013D29),
                  height: 1.15,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ),

          // 3. Giant Rising Green Dome
          Expanded(
            child: Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: _SmoothDomePainter(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Categories Grid
                        Wrap(
                          spacing: 16,
                          runSpacing: 14,
                          alignment: WrapAlignment.center,
                          children: _categories.map((cat) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 62,
                                  height: 62,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.network(cat.imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  cat.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      cat.isAdded = !cat.isAdded;
                                    });
                                    _showToast(cat.isAdded
                                        ? 'Added ${cat.name}'
                                        : 'Removed ${cat.name}');
                                  },
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: cat.isAdded
                                          ? Colors.white
                                          : Colors.black.withOpacity(0.35),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                    child: Icon(
                                      cat.isAdded ? Icons.check : Icons.add,
                                      color: cat.isAdded
                                          ? const Color(0xFF013D29)
                                          : Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Central Hero Avatar (Caramel Frappuccino only)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 3.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: const ClipOval(
                                child: Image(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=350&auto=format&fit=crop&q=80',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Caramel\nFrappuccino',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.15,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Bottom Action Bar: Pill Stepper on left, Message on right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(22),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_smoothQty > 1) {
                                        setState(() {
                                          _smoothQty--;
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      color: Color(0xFF013D29),
                                      size: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      '$_smoothQty',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF013D29),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _smoothQty++;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      color: Color(0xFF013D29),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _showToast('Opening Smooth Concierge...'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 26, vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF002D1E).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_outline_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Message',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmoothCategory {
  final String id;
  final String name;
  final String imageUrl;
  bool isAdded;

  SmoothCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isAdded = false,
  });
}

class _SmoothDomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF013D29)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.16);
    path.quadraticBezierTo(
      size.width * 0.5,
      -size.height * 0.04,
      size.width,
      size.height * 0.16,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

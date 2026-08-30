import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pasta_screen.dart';

class JoyBoonScreen extends StatefulWidget {
  final int initialCount;

  const JoyBoonScreen({
    super.key,
    this.initialCount = 12,
  });

  @override
  State<JoyBoonScreen> createState() => _JoyBoonScreenState();
}

class _JoyBoonScreenState extends State<JoyBoonScreen> {
  late int _orderCount;

  final List<JoyPerson> _people = [
    JoyPerson(
      id: 'p1',
      name: 'Anna Bella',
      imageUrl:
          'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=300&auto=format&fit=crop&q=80',
    ),
    JoyPerson(
      id: 'p2',
      name: 'David Kings',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
    ),
    JoyPerson(
      id: 'p3',
      name: 'Chinaza Joy',
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&auto=format&fit=crop&q=80',
    ),
    JoyPerson(
      id: 'p4',
      name: 'Samuel Tech',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&auto=format&fit=crop&q=80',
      isOnDarkWave: true,
    ),
    JoyPerson(
      id: 'p5',
      name: 'Esther Grace',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=300&auto=format&fit=crop&q=80',
      isOnDarkWave: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _orderCount = widget.initialCount;
  }

  void _navigateToPastaScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PastaScreen(initialCount: 1),
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
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar: Hamburger, "Joy Boon" Title, Cart Icon (loops to Screen 4), Avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: Color(0xFF013D29),
                      size: 32,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Joy Boon',
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF013D29),
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      // Trashboat Notification Icon
                      GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No new notifications')),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/trashboat.png',
                            width: 50,
                            height: 50,
                            color: const Color(0xFF013D29),
                            colorBlendMode: BlendMode.srcIn,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.notifications_none_rounded,
                                    color: Color(0xFF013D29), size: 36),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Hand Button -> Loops to Screen 4 (Delicious Pasta)
                      GestureDetector(
                        onTap: () => _navigateToPastaScreen(),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/hand.png',
                            width: 34,
                            height: 34,
                            color: const Color(0xFF013D29),
                            colorBlendMode: BlendMode.srcIn,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.touch_app,
                                    color: Color(0xFF013D29), size: 30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF013D29),
                            width: 2,
                          ),
                        ),
                        child: const ClipOval(
                          child: Image(
                            image: NetworkImage(
                              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&auto=format&fit=crop&q=80',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Main Canvas with Organic Dual Wave & People
            Expanded(
              child: Stack(
                children: [
                  // Dual Wave Painter Background
                  CustomPaint(
                    size: Size.infinite,
                    painter: _JoyBoonWavePainter(),
                  ),

                  // Top Wave Icons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
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
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.groups_outlined,
                          color: Colors.white,
                          size: 38,
                        ),
                      ],
                    ),
                  ),

                  // Profile People Layout
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Wrap(
                            spacing: 32,
                            runSpacing: 24,
                            alignment: WrapAlignment.center,
                            children: _people.map((person) {
                              return _JoyPersonWidget(
                                person: person,
                                onAddTap: () {
                                  setState(() {
                                    person.isAdded = !person.isAdded;
                                  });
                                  _showToast(
                                    person.isAdded
                                        ? 'Added ${person.name} to order!'
                                        : 'Removed ${person.name}',
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),

                  // Left "Select Pasta >" Button
                  Positioned(
                    left: 28,
                    bottom: 36,
                    child: GestureDetector(
                      onTap: () => _navigateToPastaScreen(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCEEE2),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF013D29).withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Select Pasta',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF013D29),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF013D29),
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Right Phone Stepper Widget (- 12 +)
                  Positioned(
                    right: 28,
                    bottom: 36,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFF013D29),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.phone_android_rounded,
                            color: Color(0xFF013D29),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              if (_orderCount > 1) {
                                setState(() {
                                  _orderCount--;
                                });
                              }
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDCEEE2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Color(0xFF013D29),
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$_orderCount',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF013D29),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _orderCount++;
                              });
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFDCEEE2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFF013D29),
                                  size: 16,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

class JoyPerson {
  final String id;
  final String name;
  final String imageUrl;
  final bool isOnDarkWave;
  bool isAdded;

  JoyPerson({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isOnDarkWave = false,
    this.isAdded = false,
  });
}

class _JoyPersonWidget extends StatelessWidget {
  final JoyPerson person;
  final VoidCallback onAddTap;

  const _JoyPersonWidget({
    required this.person,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF013D29),
              width: 3.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              person.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFDCEEE2),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
              ),
            ],
          ),
          child: Text(
            person.name,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF013D29),
            ),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: person.isAdded ? const Color(0xFF013D29) : Colors.white,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: const Color(0xFF013D29),
                width: 1.5,
              ),
            ),
            child: Icon(
              person.isAdded ? Icons.check : Icons.add,
              color: person.isAdded ? Colors.white : const Color(0xFF013D29),
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _JoyBoonWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF013D29)
      ..style = PaintingStyle.fill;

    final topPath = Path();
    topPath.moveTo(0, 0);
    topPath.lineTo(size.width, 0);
    topPath.lineTo(size.width, size.height * 0.12);
    topPath.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.22,
      size.width * 0.35,
      size.height * 0.14,
    );
    topPath.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.18,
      0,
      size.height * 0.15,
    );
    topPath.close();
    canvas.drawPath(topPath, paint);

    final bottomPath = Path();
    bottomPath.moveTo(size.width * 0.25, size.height);
    bottomPath.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.65,
      size.width * 0.70,
      size.height * 0.50,
    );
    bottomPath.quadraticBezierTo(
      size.width * 0.88,
      size.height * 0.40,
      size.width,
      size.height * 0.60,
    );
    bottomPath.lineTo(size.width, size.height);
    bottomPath.close();
    canvas.drawPath(bottomPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

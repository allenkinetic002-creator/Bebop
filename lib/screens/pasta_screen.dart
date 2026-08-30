import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'smooth_screen.dart';

class PastaScreen extends StatefulWidget {
  final int initialCount;

  const PastaScreen({
    super.key,
    this.initialCount = 1,
  });

  @override
  State<PastaScreen> createState() => _PastaScreenState();
}

class _PastaScreenState extends State<PastaScreen> {
  late int _pastaCount;

  final List<PastaPerson> _people = [
    PastaPerson(
      id: 'p1',
      name: 'Anna Bella',
      imageUrl:
          'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=300&auto=format&fit=crop&q=80',
    ),
    PastaPerson(
      id: 'p2',
      name: 'David Kings',
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
    ),
    PastaPerson(
      id: 'p3',
      name: 'Chinaza Joy',
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&auto=format&fit=crop&q=80',
      isOnWhite: true,
    ),
    PastaPerson(
      id: 'p4',
      name: 'Samuel Tech',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&auto=format&fit=crop&q=80',
    ),
    PastaPerson(
      id: 'p5',
      name: 'Esther Grace',
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=300&auto=format&fit=crop&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pastaCount = widget.initialCount;
  }

  void _navigateToSmoothScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SmoothScreen(initialCount: 1),
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
            // 1. Top Bar: Hamburger, "Delicious Pasta" Title, Cup Icon, Host Profile
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
                    'Delicious Pasta',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF013D29),
                      letterSpacing: -0.5,
                    ),
                  ),
                  Row(
                    children: [
                      // Coffee Cup Icon -> LOOPS TO SCREEN 5 (SmoothScreen)
                      IconButton(
                        icon: const Icon(
                          Icons.local_cafe_outlined,
                          color: Color(0xFFE8A238),
                          size: 28,
                        ),
                        onPressed: () => _navigateToSmoothScreen(),
                      ),
                      const SizedBox(width: 6),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
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
                                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&auto=format&fit=crop&q=80',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00875A),
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Smooth Out',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF013D29),
                              height: 1.1,
                            ),
                          ),
                          Text(
                            'Your Everyday',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4A5568),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Main Canvas with Organic Green Pod Background
            Expanded(
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: _PastaGreenPodPainter(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Wrap(
                            spacing: 32,
                            runSpacing: 22,
                            alignment: WrapAlignment.center,
                            children: _people.map((person) {
                              return _PastaPersonWidget(
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

                  // Center "Select Pasta >" Button -> Navigates to Screen 5
                  Center(
                    child: GestureDetector(
                      onTap: () => _navigateToSmoothScreen(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Select Pasta',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF013D29),
                              ),
                            ),
                            const SizedBox(width: 8),
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

                  // Bottom Action Bar
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_pastaCount > 1) {
                                  setState(() {
                                    _pastaCount--;
                                  });
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF013D29),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.remove,
                                    color: Color(0xFF013D29),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF013D29),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$_pastaCount',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF013D29),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pastaCount++;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xFF013D29),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Color(0xFF013D29),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        GestureDetector(
                          onTap: () =>
                              _showToast('Opening Pasta Concierge...'),
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 26),
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

class PastaPerson {
  final String id;
  final String name;
  final String imageUrl;
  final bool isOnWhite;
  bool isAdded;

  PastaPerson({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isOnWhite = false,
    this.isAdded = false,
  });
}

class _PastaPersonWidget extends StatelessWidget {
  final PastaPerson person;
  final VoidCallback onAddTap;

  const _PastaPersonWidget({
    required this.person,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88,
          height: 88,
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: person.isOnWhite
                ? Border.all(color: const Color(0xFF013D29), width: 1)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
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

class _PastaGreenPodPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF013D29)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.58, 0);
    path.cubicTo(
      size.width * 0.72,
      size.height * 0.25,
      size.width * 0.70,
      size.height * 0.70,
      size.width * 0.48,
      size.height,
    );
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

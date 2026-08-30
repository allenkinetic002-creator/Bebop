import 'package:flutter/material.dart';

class WavyHeader extends StatelessWidget {
  final String userAvatarUrl;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCartTap;
  final int cartCount;

  const WavyHeader({
    super.key,
    this.userAvatarUrl =
        'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&auto=format&fit=crop&q=80',
    this.onNotificationTap,
    this.onCartTap,
    this.cartCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        // Wavy dark green background
        ClipPath(
          clipper: _WavyHeaderClipper(),
          child: Container(
            height: 120 + topPadding,
            color: const Color(0xFF013D29),
          ),
        ),

        // Header content
        Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: topPadding > 0 ? topPadding + 6 : 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Avatar with clean white border
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    userAvatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFD4A574),
                        alignment: Alignment.center,
                        child: const Icon(Icons.person,
                            color: Colors.white, size: 28),
                      );
                    },
                  ),
                ),
              ),

              // Right Actions: Notification Bell + Hand Navigation Icon
              Row(
                children: [
                  _HeaderIconButton(
                    icon: Icons.notifications_none_rounded,
                    onTap: onNotificationTap ?? () {},
                  ),
                  const SizedBox(width: 14),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: onCartTap ?? () {},
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/hand.png',
                            width: 24,
                            height: 24,
                            fit: BoxFit.contain,
                            color: Colors.white,
                            colorBlendMode: BlendMode.srcIn,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.touch_app,
                                    color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          top: -3,
                          right: -3,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFD4A574),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$cartCount',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class _WavyHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 24);

    path.quadraticBezierTo(
      size.width * 0.35,
      size.height + 14,
      size.width * 0.65,
      size.height - 20,
    );

    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 45,
      size.width,
      size.height - 25,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomClipper<Path> oldClipper) => false;
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBarWidget extends StatelessWidget {
  final VoidCallback? onMessageTap;
  final VoidCallback? onRefreshTap;
  final int tabletQty;
  final ValueChanged<int>? onQtyChanged;

  const BottomBarWidget({
    super.key,
    this.onMessageTap,
    this.onRefreshTap,
    this.tabletQty = 1,
    this.onQtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF013D29),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 14,
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom + 6
            : 18,
      ),
      child: Row(
        children: [
          // 1. "Message" pill button
          Expanded(
            child: GestureDetector(
              onTap: onMessageTap,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Message',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Tablet Stepper (- 1 +) Pill Container
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tablet Icon
                const Icon(
                  Icons.tablet_mac_rounded,
                  color: Color(0xFFD4E5DC),
                  size: 22,
                ),
                const SizedBox(width: 8),

                // Controls: Minus, Count, Plus
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Minus Button
                      GestureDetector(
                        onTap: () {
                          if (tabletQty > 1) {
                            onQtyChanged?.call(tabletQty - 1);
                          }
                        },
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.18),
                          ),
                          child: const Center(
                            child: Icon(Icons.remove, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '$tabletQty',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Plus Button
                      GestureDetector(
                        onTap: () {
                          onQtyChanged?.call(tabletQty + 1);
                        },
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.18),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // 3. Refresh Button
          GestureDetector(
            onTap: onRefreshTap,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFD4E5DC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.refresh_rounded,
                color: Color(0xFF013D29),
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

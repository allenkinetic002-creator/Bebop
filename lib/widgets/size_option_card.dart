import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/size_option.dart';

class SizeOptionCard extends StatelessWidget {
  final SizeOption option;
  final VoidCallback? onCardTap;
  final VoidCallback? onAddTap;

  const SizeOptionCard({
    super.key,
    required this.option,
    this.onCardTap,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: option.isSelected ? const Color(0xFFF2F8F4) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: option.isSelected
                ? const Color(0xFF013D29)
                : const Color(0xFFE2EDE6),
            width: option.isSelected ? 2.0 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular Avatar
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF013D29),
                  width: 2.2,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  option.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF013D29).withOpacity(0.2),
                    child: const Icon(Icons.coffee, color: Color(0xFF013D29)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Size Name
            Text(
              option.name,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF013D29),
              ),
            ),
            const SizedBox(height: 2),

            // Volume / Price
            Text(
              option.volume,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF698B7C),
              ),
            ),
            const SizedBox(height: 10),

            // Add button
            GestureDetector(
              onTap: onAddTap,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF013D29),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  option.isAdded ? Icons.check : Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

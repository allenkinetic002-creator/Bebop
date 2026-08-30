import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/coffee_item.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/featured_card.dart';
import '../widgets/new_menu_section.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/wavy_header.dart';
import 'details_screen.dart';
import 'joy_boon_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentMenuPage = 0;
  String _searchQuery = '';
  int _tabletQty = 1;

  // Main User Header Avatar
  final String userAvatarUrl =
      'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=200&auto=format&fit=crop&q=80';

  // Featured Cards with Diverse Profiles
  final List<CoffeeItem> _featuredItems = [
    CoffeeItem(
      id: 'feat_1',
      name: 'caramel frappuccino',
      price: 30.00,
      imageUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFD4A574),
      initials: 'CF',
    ),
    CoffeeItem(
      id: 'feat_2',
      name: 'strawberry latte',
      price: 25.50,
      imageUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFE8A598),
      initials: 'ST',
    ),
    CoffeeItem(
      id: 'feat_3',
      name: 'caramel macchiato',
      price: 28.00,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFC49A6C),
      initials: 'CM',
    ),
    CoffeeItem(
      id: 'feat_4',
      name: 'hazelnut cold brew',
      price: 26.50,
      imageUrl:
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFF8B6347),
      initials: 'HC',
    ),
  ];

  // 7 New Menu Items with Diverse Profiles
  final List<CoffeeItem> _menuItems = [
    CoffeeItem(
      id: 'menu_1',
      name: 'mocha',
      price: 22.00,
      imageUrl:
          'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFF8B6347),
      initials: 'MO',
    ),
    CoffeeItem(
      id: 'menu_2',
      name: 'vanilla latte',
      price: 24.00,
      imageUrl:
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFD4B896),
      initials: 'VL',
    ),
    CoffeeItem(
      id: 'menu_3',
      name: 'espresso',
      price: 18.00,
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFF6B4226),
      initials: 'ES',
    ),
    CoffeeItem(
      id: 'menu_4',
      name: 'hazelnut',
      price: 23.50,
      imageUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFC49A6C),
      initials: 'HZ',
    ),
    CoffeeItem(
      id: 'menu_5',
      name: 'matcha',
      price: 26.00,
      imageUrl:
          'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFF7BA05B),
      initials: 'MA',
    ),
    CoffeeItem(
      id: 'menu_6',
      name: 'chai spice',
      price: 24.50,
      imageUrl:
          'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFFB8860B),
      initials: 'CS',
    ),
    CoffeeItem(
      id: 'menu_7',
      name: 'affogato',
      price: 29.00,
      imageUrl:
          'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=250&auto=format&fit=crop&q=80',
      avatarColor: const Color(0xFF5D4037),
      initials: 'AF',
    ),
  ];

  int get _cartCount {
    return _featuredItems.where((i) => i.isInCart).length +
        _menuItems.where((i) => i.isInCart).length;
  }

  void _navigateToJoyBoon() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const JoyBoonScreen(initialCount: 12),
      ),
    );
  }

  void _navigateToDetails([String? name, String? imageUrl]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailsScreen(
          drinkName: name ?? 'Caramel Frappuccino',
          drinkImageUrl: imageUrl ??
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&auto=format&fit=crop&q=80',
          initialCartCount: _cartCount,
        ),
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
    final filteredFeatured = _searchQuery.isEmpty
        ? _featuredItems
        : _featuredItems
            .where((item) =>
                item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Organic Wavy Header (Cart icon tap navigates to JoyBoonScreen)
          WavyHeader(
            userAvatarUrl: userAvatarUrl,
            cartCount: _cartCount,
            onNotificationTap: () => _showToast('No new notifications'),
            onCartTap: () => _navigateToJoyBoon(),
          ),

          // 2. Scrollable Body Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBarWidget(
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Featured Items Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          children: (filteredFeatured.isNotEmpty
                                  ? filteredFeatured
                                  : _featuredItems)
                              .map(
                                (item) => SizedBox(
                                  width: constraints.maxWidth > 650
                                      ? (constraints.maxWidth - 14) / 2
                                      : constraints.maxWidth,
                                  child: GestureDetector(
                                    onTap: () => _navigateToDetails(
                                        item.name, item.imageUrl),
                                    child: FeaturedCard(
                                      item: item,
                                      onAddTap: () {
                                        _showToast(
                                          item.isInCart
                                              ? 'Added ${item.name} to order!'
                                              : 'Removed ${item.name}',
                                        );
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "New Menu" Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Menu',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF013D29),
                            letterSpacing: -0.2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _showToast('Showing all menu items'),
                          child: Row(
                            children: [
                              Text(
                                'View All',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: const Color(0xFF013D29),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 2),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFF013D29),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 4),

                  // "New Menu" Dark Green Arc Section
                  NewMenuSection(
                    items: _menuItems,
                    currentPage: _currentMenuPage,
                    onPageChanged: (page) {
                      setState(() {
                        _currentMenuPage = page;
                      });
                    },
                    onItemTap: (item) {
                      _navigateToDetails(item.name, item.imageUrl);
                    },
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom Action Bar
          BottomBarWidget(
            tabletQty: _tabletQty,
            onQtyChanged: (newQty) {
              setState(() {
                _tabletQty = newQty;
              });
              _showToast('Batch quantity set to: $_tabletQty');
            },
            onMessageTap: () => _showToast('Opening coffee concierge chat...'),
            onRefreshTap: () {
              setState(() {
                for (var item in _featuredItems) {
                  item.isInCart = false;
                }
                for (var item in _menuItems) {
                  item.isInCart = false;
                }
                _tabletQty = 1;
              });
              _showToast('Menu refreshed!');
            },
          ),
        ],
      ),
    );
  }
}

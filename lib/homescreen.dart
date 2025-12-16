import 'package:flutter/material.dart';
import 'search_page.dart';
import 'profile_page.dart';

// --- Data Models (Mô phỏng dữ liệu từ App.tsx) ---
class Category {
  final int id;
  final String name;
  final String image;
  final int itemCount;

  Category(this.id, this.name, this.image, this.itemCount);
}

class Product {
  final int id;
  final String name;
  final double price;
  final double? originalPrice;
  final String image;
  final bool isNew;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.originalPrice,
    this.isNew = false,
  });
}

// --- Main Screen ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dữ liệu mẫu (Copy từ App.tsx)
  final List<Category> categories = [
    Category(1, 'New In', 'https://images.unsplash.com/photo-1614209429278-6d7c259bfb55?w=1080&q=80', 124),
    Category(2, 'Hoodie', 'https://images.unsplash.com/photo-1632682582909-2b3a2581eef7?w=1080&q=80', 89),
    Category(3, 'Dress', 'https://images.unsplash.com/photo-1760083545495-b297b1690672?w=1080&q=80', 156),
    Category(4, 'Jacket', 'https://images.unsplash.com/photo-1632934330201-a641618914d3?w=1080&q=80', 67),
    Category(5, 'Shoes', 'https://images.unsplash.com/photo-1760302318631-a8d342cd4951?w=1080&q=80', 98),
  ];

  final List<Product> featuredProducts = [
    Product(id: 1, name: 'Minimal White Tee', price: 29, image: 'https://images.unsplash.com/photo-1614209429278-6d7c259bfb55?w=1080&q=80', isNew: true),
    Product(id: 2, name: 'Street Hoodie Black', price: 45, originalPrice: 65, image: 'https://images.unsplash.com/photo-1632682582909-2b3a2581eef7?w=1080&q=80'),
    Product(id: 3, name: 'Elegant Summer Dress', price: 79, image: 'https://images.unsplash.com/photo-1760083545495-b297b1690672?w=1080&q=80', isNew: true),
    Product(id: 4, name: 'Casual Denim Jacket', price: 89, image: 'https://images.unsplash.com/photo-1632934330201-a641618914d3?w=1080&q=80'),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header (Sticky effect simulation) ---
            _buildHeader(),

            // --- Main Content (Scrollable) ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Banner
                    _buildHeroBanner(),

                    // Categories
                    const SizedBox(height: 32),
                    _buildSectionHeader('Danh Mục', 'Xem tất cả'),
                    _buildCategoryList(),

                    // Flash Sale Banner
                    const SizedBox(height: 32),
                    _buildFlashSaleBanner(),

                    // Featured Products
                    const SizedBox(height: 32),
                    _buildSectionHeader('Sản Phẩm Nổi Bật', 'Xem tất cả'),
                    _buildProductGrid(),

                    // Brand Story
                    const SizedBox(height: 32),
                    _buildBrandStory(),

                    // Bottom Padding for safe scrolling above nav bar
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- Components Widgets ---

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const Text(
                'BLANK CANVAS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              Row(
                children: [
                  _buildIconWithBadge(Icons.notifications_outlined, isDot: true),
                  const SizedBox(width: 12),
                  _buildIconWithBadge(Icons.shopping_bag_outlined, badgeContent: '3'),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm...',
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
              filled: true,
              fillColor: const Color(0xFFF9FAFB), // gray-50
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithBadge(IconData icon, {bool isDot = false, String? badgeContent}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, size: 24),
        if (isDot)
          Positioned(
            top: 0,
            right: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (badgeContent != null)
          Positioned(
            top: -2,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  badgeContent,
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 280,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageWithFallback(
              src: 'https://images.unsplash.com/photo-1558452919-08ae4aea8e29?w=1080&q=80',
              fit: BoxFit.cover,
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
            // Text Content
            Positioned(
              bottom: 24,
              left: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NEW SEASON',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Bộ Sưu Tập\nMùa Đông 2025',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600, height: 1.2),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Khám Phá Ngay', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Text(actionText, style: TextStyle(fontSize: 14, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 140, // Height for Category Card
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => CategoryCardItem(category: categories[index]),
      ),
    );
  }

  Widget _buildFlashSaleBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFF43F5E), Colors.orange], // rose-500 to orange-500
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('⚡ FLASH SALE', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              const Text('Giảm đến 50%', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Kết thúc trong 12:45:30', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFF43F5E),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Mua Ngay', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: featuredProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65, // Adjust to match ProductCard layout
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, index) {
          return ProductCardItem(product: featuredProducts[index]);
        },
      ),
    );
  }

  Widget _buildBrandStory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB), // gray-50
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text('🎨 BLANK CANVAS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Nơi phong cách của bạn được vẽ nên. Khám phá bộ sưu tập thời trang hiện đại, chất lượng cao với giá tốt nhất.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 1) {
            // Nút Tìm kiếm (index 1) -> Mở SearchPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          } else if (index == 3) {
            // Nút Tài khoản (index 3) -> Mở ProfilePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else {
            // Các nút còn lại (Trang chủ, Yêu thích)
            setState(() => _selectedIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm kiếm'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Yêu thích'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Tài khoản'),
        ],
      ),
    );
  }
}

// --- Component: Category Card ---
class CategoryCardItem extends StatelessWidget {
  final Category category;

  const CategoryCardItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ImageWithFallback(src: category.image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
        ),
        Text(
          '${category.itemCount} items',
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
      ],
    );
  }
}

// --- Component: Product Card ---
class ProductCardItem extends StatefulWidget {
  final Product product;

  const ProductCardItem({super.key, required this.product});

  @override
  State<ProductCardItem> createState() => _ProductCardItemState();
}

class _ProductCardItemState extends State<ProductCardItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              // Image container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ImageWithFallback(src: widget.product.image, fit: BoxFit.cover),
                ),
              ),
              // Badges
              if (widget.product.isNew)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                    child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              if (widget.product.originalPrice != null)
                Positioned(
                  top: 12,
                  left: widget.product.isNew ? 60 : 12, // Offset if NEW exists
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100)),
                    child: const Text('SALE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              // Favorite Button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => setState(() => isFavorite = !isFavorite),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isFavorite ? Colors.red : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            if (widget.product.originalPrice != null) ...[
              const SizedBox(width: 8),
              Text(
                '\$${widget.product.originalPrice}',
                style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, color: Colors.grey[400]),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

// --- Utility: ImageWithFallback (Xử lý ảnh lỗi) ---
class ImageWithFallback extends StatelessWidget {
  final String src;
  final BoxFit fit;

  const ImageWithFallback({super.key, required this.src, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[100],
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[100],
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image_not_supported_outlined, color: Colors.grey[400], size: 32),
              const SizedBox(height: 4),
              Text('Error', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
            ],
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _showFilters = false;
  final Set<String> _selectedCategories = {};
  final Set<String> _selectedColors = {};
  final Set<String> _selectedSizes = {};
  final Set<String> _selectedShoeSizes = {};
  final Set<String> _selectedWaistSizes = {};
  final TextEditingController _searchController = TextEditingController();

  final List<String> _menCategories = [
    'Tất cả Đồ Nam',
    'Áo Thun Nam',
    'Áo Sơ Mi Nam',
    'Áo Polo Nam',
    'Áo Khoác Nam',
    'Áo Hoodie Nam',
    'Quần Jean Nam',
    'Quần Short Nam',
    'Quần Tây Nam',
  ];

  final List<ColorOption> _colors = [
    ColorOption('Nâu', 'brown', Color(0xFF8B4513)),
    ColorOption('Trắng', 'white', Color(0xFFFFFFFF)),
    ColorOption('Vàng', 'yellow', Color(0xFFFFD700)),
    ColorOption('Xanh', 'blue', Color(0xFF1E40AF)),
    ColorOption('Đen', 'black', Color(0xFF000000)),
    ColorOption('Đỏ', 'red', Color(0xFFDC2626)),
  ];

  final List<String> _sizes = ['L', 'M', 'S', 'XL', 'XXL'];
  final List<String> _shoeSizes = ['39', '40', '41', '42', '43'];
  final List<String> _waistSizes = ['100cm', '110cm', '120cm', '85cm', '90cm'];

  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Áo Thun Basic Premium',
      price: 29,
      image: 'https://images.unsplash.com/photo-1614209429278-6d7c259bfb55',
      isNew: true,
    ),
    Product(
      id: 2,
      name: 'Hoodie Streetwear',
      price: 45,
      originalPrice: 65,
      image: 'https://images.unsplash.com/photo-1632682582909-2b3a2581eef7',
    ),
    Product(
      id: 3,
      name: 'Đầm Dạ Hội Sang Trọng',
      price: 79,
      image: 'https://images.unsplash.com/photo-1760083545495-b297b1690672',
      isNew: true,
    ),
    Product(
      id: 4,
      name: 'Áo Khoác Denim',
      price: 89,
      image: 'https://images.unsplash.com/photo-1632934330201-a641618914d3',
    ),
    Product(
      id: 5,
      name: 'Áo Sơ Mi Oxford',
      price: 39,
      image: 'https://images.unsplash.com/photo-1614209429278-6d7c259bfb55',
    ),
    Product(
      id: 6,
      name: 'Quần Jean Slim Fit',
      price: 59,
      originalPrice: 79,
      image: 'https://images.unsplash.com/photo-1632682582909-2b3a2581eef7',
    ),
  ];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  void _toggleColor(String color) {
    setState(() {
      if (_selectedColors.contains(color)) {
        _selectedColors.remove(color);
      } else {
        _selectedColors.add(color);
      }
    });
  }

  void _toggleSize(String size) {
    setState(() {
      if (_selectedSizes.contains(size)) {
        _selectedSizes.remove(size);
      } else {
        _selectedSizes.add(size);
      }
    });
  }

  void _toggleShoeSize(String size) {
    setState(() {
      if (_selectedShoeSizes.contains(size)) {
        _selectedShoeSizes.remove(size);
      } else {
        _selectedShoeSizes.add(size);
      }
    });
  }

  void _toggleWaistSize(String size) {
    setState(() {
      if (_selectedWaistSizes.contains(size)) {
        _selectedWaistSizes.remove(size);
      } else {
        _selectedWaistSizes.add(size);
      }
    });
  }

  void _clearAllFilters() {
    setState(() {
      _selectedCategories.clear();
      _selectedColors.clear();
      _selectedSizes.clear();
      _selectedShoeSizes.clear();
      _selectedWaistSizes.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                _buildHeader(),
                // Products Grid
                Expanded(
                  child: _buildProductsGrid(),
                ),
              ],
            ),
            // Filter Sidebar
            if (_showFilters) _buildFilterSidebar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Column(
        children: [
          // Search Bar and Back Button
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm sản phẩm...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Results Count and Filter Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tìm thấy ${_products.length} sản phẩm',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _showFilters = true;
                  });
                },
                icon: const Icon(Icons.tune, size: 16),
                label: const Text('Bộ lọc', style: TextStyle(fontSize: 14)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(_products[index]);
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Badge
              if (product.isNew || product.originalPrice != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.originalPrice != null ? Colors.red : Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.originalPrice != null ? 'SALE' : 'NEW',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              // Favorite Button
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Product Name
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Price
        Row(
          children: [
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            if (product.originalPrice != null) ...[
              const SizedBox(width: 8),
              Text(
                '\$${product.originalPrice}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildFilterSidebar() {
    return Stack(
      children: [
        // Backdrop
        GestureDetector(
          onTap: () {
            setState(() {
              _showFilters = false;
            });
          },
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        // Sidebar
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            color: Colors.white,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bộ lọc',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _showFilters = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // Filter Content
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildFilterSection(
                        'Đồ Nam',
                        _buildCategoryFilter(),
                        defaultOpen: true,
                      ),
                      _buildFilterSection('Đồ Nữ', _buildPlaceholder()),
                      _buildFilterSection('Đồ Thể Thao', _buildPlaceholder()),
                      _buildFilterSection('Đồ Dạ', _buildPlaceholder()),
                      _buildFilterSection('Phụ Kiện', _buildPlaceholder()),
                      _buildFilterSection('Khoảng giá', _buildPlaceholder()),
                      _buildColorFilter(),
                      _buildSizeFilter(),
                      _buildShoeSizeFilter(),
                      _buildWaistSizeFilter(),
                    ],
                  ),
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _clearAllFilters,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text('Xóa tất cả'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showFilters = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Áp dụng',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(String title, Widget content, {bool defaultOpen = false}) {
    return FilterSectionWidget(
      title: title,
      defaultOpen: defaultOpen,
      child: content,
    );
  }

  Widget _buildCategoryFilter() {
    return Column(
      children: _menCategories.map((category) {
        final isSelected = _selectedCategories.contains(category);
        return InkWell(
          onTap: () => _toggleCategory(category),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (_) => _toggleCategory(category),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildColorFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Màu Sắc',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _colors.map((color) {
              final isSelected = _selectedColors.contains(color.value);
              return GestureDetector(
                onTap: () => _toggleColor(color.value),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.hex,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: color.value == 'white'
                        ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 4,
                      ),
                    ]
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kích Cỡ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _sizes.map((size) {
              final isSelected = _selectedSizes.contains(size);
              return GestureDetector(
                onTap: () => _toggleSize(size),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildShoeSizeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kích Cỡ Giày',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _shoeSizes.map((size) {
              final isSelected = _selectedShoeSizes.contains(size);
              return GestureDetector(
                onTap: () => _toggleShoeSize(size),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaistSizeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kích Cỡ Thật Lưng',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _waistSizes.map((size) {
              final isSelected = _selectedWaistSizes.contains(size);
              return GestureDetector(
                onTap: () => _toggleWaistSize(size),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.white,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Đang cập nhật...',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}

// Filter Section Widget with Expand/Collapse
class FilterSectionWidget extends StatefulWidget {
  final String title;
  final Widget child;
  final bool defaultOpen;

  const FilterSectionWidget({
    Key? key,
    required this.title,
    required this.child,
    this.defaultOpen = false,
  }) : super(key: key);

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.defaultOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
          if (_isOpen) ...[
            const SizedBox(height: 12),
            widget.child,
          ],
        ],
      ),
    );
  }
}

// Product Model
class Product {
  final int id;
  final String name;
  final int price;
  final int? originalPrice;
  final String image;
  final bool isNew;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.image,
    this.isNew = false,
  });
}

// Color Option Model
class ColorOption {
  final String name;
  final String value;
  final Color hex;

  ColorOption(this.name, this.value, this.hex);
}

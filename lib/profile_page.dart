import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Content
            Expanded(
              child: ListView(
                children: [
                  // Profile Card
                  _buildProfileCard(),
                  // Membership Card
                  _buildMembershipCard(),
                  // Menu Section
                  _buildMenuSection(),
                  // Settings Section
                  _buildSettingsSection(),
                  // Logout Button
                  _buildLogoutButton(),
                  // App Version
                  _buildAppVersion(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 16),
          const Text(
            'Tài Khoản',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF111827), Color(0xFF374151)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // User Info
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nguyễn Văn A',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'nguyenvana@email.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFD1D5DB),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Stats
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(value: '12', label: 'Đơn hàng'),
                _StatItem(value: '350', label: 'Điểm tích lũy'),
                _StatItem(value: '5', label: 'Voucher'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '👑',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hạng thành viên',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Gold Member',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      _MenuItem(
        icon: Icons.shopping_bag_outlined,
        title: 'Đơn hàng của tôi',
        subtitle: 'Xem lịch sử đơn hàng',
        badge: '3',
        color: const Color(0xFF2563EB),
        bgColor: const Color(0xFFEFF6FF),
      ),
      _MenuItem(
        icon: Icons.location_on_outlined,
        title: 'Địa chỉ giao hàng',
        subtitle: 'Quản lý địa chỉ nhận hàng',
        color: const Color(0xFF16A34A),
        bgColor: const Color(0xFFF0FDF4),
      ),
      _MenuItem(
        icon: Icons.credit_card_outlined,
        title: 'Phương thức thanh toán',
        subtitle: 'Thẻ & ví điện tử',
        color: const Color(0xFF9333EA),
        bgColor: const Color(0xFFFAF5FF),
      ),
      _MenuItem(
        icon: Icons.local_offer_outlined,
        title: 'Ưu đãi của tôi',
        subtitle: 'Voucher & mã giảm giá',
        badge: '5',
        color: const Color(0xFFEA580C),
        bgColor: const Color(0xFFFFF7ED),
      ),
      _MenuItem(
        icon: Icons.favorite_outline,
        title: 'Danh sách yêu thích',
        subtitle: 'Sản phẩm đã lưu',
        badge: '12',
        color: const Color(0xFFDC2626),
        bgColor: const Color(0xFFFEF2F2),
      ),
      _MenuItem(
        icon: Icons.notifications_outlined,
        title: 'Thông báo',
        subtitle: 'Cài đặt thông báo',
        color: const Color(0xFFCA8A04),
        bgColor: const Color(0xFFFEFCE8),
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUẢN LÝ TÀI KHOẢN',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: menuItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return _buildMenuItem(
                  item,
                  isLast: index == menuItems.length - 1,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(_MenuItem item, {bool isLast = false}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          )
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.icon,
                color: item.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (item.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item.badge!,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    final settingsItems = [
      _SettingsItem(
        icon: Icons.settings_outlined,
        title: 'Cài đặt tài khoản',
      ),
      _SettingsItem(
        icon: Icons.help_outline,
        title: 'Trợ giúp & Hỗ trợ',
      ),
      _SettingsItem(
        icon: Icons.description_outlined,
        title: 'Điều khoản & Chính sách',
      ),
      _SettingsItem(
        icon: Icons.shield_outlined,
        title: 'Bảo mật & Quyền riêng tư',
      ),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CÀI ĐẶT',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: settingsItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return _buildSettingsItem(
                  item,
                  isLast: index == settingsItems.length - 1,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(_SettingsItem item, {bool isLast = false}) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: !isLast
              ? Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          )
              : null,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout,
                color: Color(0xFFDC2626),
                size: 20,
              ),
              SizedBox(width: 12),
              Text(
                'Đăng xuất',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFDC2626),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppVersion() {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Center(
        child: Text(
          'BLANK CANVAS v1.0.0',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade400,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// Stat Item Widget
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFFD1D5DB),
          ),
        ),
      ],
    );
  }
}

// Menu Item Model
class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? badge;
  final Color color;
  final Color bgColor;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.badge,
    required this.color,
    required this.bgColor,
  });
}

// Settings Item Model
class _SettingsItem {
  final IconData icon;
  final String title;

  _SettingsItem({
    required this.icon,
    required this.title,
  });
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helpers/stripe_payment_service.dart';
import '../../models/product_model.dart';


class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isPaymentLoading = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim =
        CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
            CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── Payment Handler ───────────────────────────────────────────────────────

  Future<void> _handlePayment() async {
    if (!widget.product.isInStock || _isPaymentLoading) return;

    setState(() => _isPaymentLoading = true);

    final success = await StripePaymentService.instance.processPayment(
      context: context,
      amount: widget.product.price * _quantity,
      currency: 'usd',
      description: '${widget.product.name} x$_quantity',
      metadata: {
        'sku': widget.product.sku,
        'quantity': '$_quantity',
      },
      primaryColor: const Color(0xffFF6B00),
      merchantName: 'Your Store Name',
    );

    if (mounted) {
      setState(() => _isPaymentLoading = false);
      if (success) _showResultDialog(success: true);
    }
  }

  // ── Result Dialog ─────────────────────────────────────────────────────────

  void _showResultDialog({required bool success, String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: success
                    ? const Color(0xffF0FDF4)
                    : const Color(0xffFFF1F1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                success
                    ? Icons.check_circle_rounded
                    : Icons.error_rounded,
                color: success
                    ? const Color(0xff4CAF50)
                    : const Color(0xffE53935),
                size: 52,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              success ? 'Payment Successful!' : 'Payment Failed',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              success
                  ? 'Your order for ${widget.product.name} (x$_quantity) has been placed successfully.'
                  : (message ?? 'Your payment could not be processed. Please try again.'),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color(0xff5A5A5A),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (success) Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFF6B00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  success ? 'Done' : 'OK',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // ── Hero App Bar ────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 340,
                pinned: true,
                backgroundColor: const Color(0xffFF6B00),
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.black87, size: 20),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () =>
                        setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Icon(
                          _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          key: ValueKey(_isFavorite),
                          color: _isFavorite ? Colors.red : Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        right: 8, top: 8, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: const Icon(Icons.share_outlined,
                        color: Colors.black87, size: 20),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background gradient
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xffFFF5EE),
                              Color(0xffFFE8D6),
                            ],
                          ),
                        ),
                      ),
                      // Decorative circles
                      Positioned(
                        top: -40,
                        right: -40,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffFF6B00)
                                .withOpacity(0.06),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -20,
                        left: -30,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xffFF6B00)
                                .withOpacity(0.05),
                          ),
                        ),
                      ),
                      // Product Image
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 60, bottom: 16),
                        child: product.imageUrl.isNotEmpty
                            ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              _buildImagePlaceholder(),
                        )
                            : _buildImagePlaceholder(),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Content ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Main Card ────────────────────────────────
                        Container(
                          margin:
                          const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category + Stock Row
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFF0E6),
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      product.category.isNotEmpty
                                          ? product.category
                                          : 'Product',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffFF6B00),
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  _buildStockBadge(product.isInStock),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Product Name
                              Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff1A1A1A),
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // SKU
                              Text(
                                'SKU: ${product.sku}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xffAAAAAA),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 20),

                              const Divider(
                                  color: Color(0xffF0F0F0),
                                  thickness: 1.5),
                              const SizedBox(height: 20),

                              // Price + Quantity
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Price',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: const Color(0xffAAAAAA),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '\$${(product.price * _quantity).toStringAsFixed(2)}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xffFF6B00),
                                          height: 1.1,
                                        ),
                                      ),
                                      // Unit price hint when qty > 1
                                      if (_quantity > 1)
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)} each',
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: const Color(0xffAAAAAA),
                                          ),
                                        ),
                                    ],
                                  ),
                                  _buildQuantitySelector(),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Description Card ─────────────────────────
                        _buildSectionCard(
                          title: 'Description',
                          icon: Icons.description_outlined,
                          child: Text(
                            product.description.isNotEmpty
                                ? product.description
                                : 'No description available for this product.',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xff5A5A5A),
                              height: 1.7,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Product Info Card ────────────────────────
                        _buildSectionCard(
                          title: 'Product Info',
                          icon: Icons.info_outline,
                          child: Column(
                            children: [
                              _buildInfoRow(
                                  'Category',
                                  product.category.isNotEmpty
                                      ? product.category
                                      : '—'),
                              _buildInfoRow('SKU', product.sku),
                              _buildInfoRow(
                                'Availability',
                                product.isInStock
                                    ? 'In Stock'
                                    : 'Out of Stock',
                                valueColor: product.isInStock
                                    ? const Color(0xff4CAF50)
                                    : const Color(0xffE53935),
                              ),
                              _buildInfoRow(
                                  'Unit Price',
                                  '\$${product.price.toStringAsFixed(2)}'),
                            ],
                          ),
                        ),

                        // Bottom spacing for button bar
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom Buy Now Bar ──────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, -6),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: product.isInStock && !_isPaymentLoading
                      ? _handlePayment
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF6B00),
                    disabledBackgroundColor: const Color(0xffE0E0E0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: _isPaymentLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.flash_on_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        product.isInStock
                            ? 'Buy Now  •  \$${(product.price * _quantity).toStringAsFixed(2)}'
                            : 'Unavailable',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Widget _buildImagePlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inventory_2_outlined,
              size: 80, color: Color(0xffFFBB99)),
          const SizedBox(height: 8),
          Text(
            'No Image',
            style: GoogleFonts.poppins(
                fontSize: 12, color: const Color(0xffFFBB99)),
          ),
        ],
      ),
    );
  }

  Widget _buildStockBadge(bool inStock) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: inStock
            ? const Color(0xffF0FDF4)
            : const Color(0xffFFF1F1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: inStock
              ? const Color(0xff86EFAC)
              : const Color(0xffFCA5A5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: inStock
                  ? const Color(0xff4CAF50)
                  : const Color(0xffE53935),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            inStock ? 'In Stock' : 'Out of Stock',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: inStock
                  ? const Color(0xff16A34A)
                  : const Color(0xffDC2626),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _quantityBtn(
            icon: Icons.remove,
            onTap: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1A1A1A),
              ),
            ),
          ),
          _quantityBtn(
            icon: Icons.add,
            onTap: () => setState(() => _quantity++),
            isAdd: true,
          ),
        ],
      ),
    );
  }

  Widget _quantityBtn({
    required IconData icon,
    required VoidCallback onTap,
    bool isAdd = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: isAdd
              ? const Color(0xffFF6B00)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isAdd ? Colors.white : const Color(0xff5A5A5A),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xffFFF0E6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon,
                    color: const Color(0xffFF6B00), size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color(0xffAAAAAA),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xff1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}
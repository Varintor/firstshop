import 'dart:convert';
import 'package:firstshop/pages/detailpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Cleaner background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Computer Knowledge',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data found'));
            }

            final List<dynamic> data = json.decode(snapshot.data!);

            return ListView.builder(
              physics: const BouncingScrollPhysics(), // Smooth bounce on iOS/Android
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                // Determine animation delay based on index
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + (index * 100)),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - value)), // Slide up effect
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: ProductCard(
                    title: data[index]['title'],
                    subtitle: data[index]['subtitle'],
                    imageUrl: data[index]['imageUrl'],
                    index: index, // Used for unique Hero tag
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final int index;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.index,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // ปรับ Scale ให้น้อยลง (1.02) เพื่อไม่ให้กินพื้นที่มากเกินไป
    final double cardScale = _isPressed ? 0.98 : (_isHovered ? 1.02 : 1.0);
    
    // เพิ่มลูกเล่นซูมรูปภาพข้างใน (Internal Zoom) ดูแพงกว่าขยายกล่อง
    final double imageScale = _isHovered ? 1.1 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          print("nextpage>>");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Detailpage()),
          );
        },
        // ใช้ AnimatedScale แทน Matrix4 เพื่อคุมไม่ให้ล้นง่ายๆ
        child: AnimatedScale(
          scale: cardScale,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 20), // Margin เดิมที่มีอยู่
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // เงาจะฟุ้งขึ้นเมื่อ Hover แต่ไม่ขยายขนาดเงาจนน่าเกลียด
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? Colors.blue.withOpacity(0.25)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: _isHovered ? 15 : 10,
                  offset: _isHovered ? const Offset(0, 8) : const Offset(0, 5),
                  spreadRadius: _isHovered ? 2 : 0, // เงาแผ่ออกนิดเดียว
                ),
              ],
            ),
            // ClipRRect สำคัญมาก! ตัดส่วนเกินของรูปที่ซูมออก ไม่ให้ล้นกรอบมน
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 150, // Fix ความสูงไว้เลย เพื่อความนิ่ง
                child: Stack(
                  children: [
                    // 1. Image Background (ซูมรูปแทนซูมกล่อง)
                    Positioned.fill(
                      child: AnimatedScale(
                        scale: imageScale,
                        duration: const Duration(milliseconds: 400), // รูปซูมช้ากว่ากล่องนิดนึงให้ดูนุ่ม
                        curve: Curves.easeOut,
                        child: Hero(
                          tag: 'image_${widget.index}',
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),

                    // 2. Gradient Overlay (อ่านตัวหนังสือชัดขึ้น)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. Ripple Effect (Touch Feedback)
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detailpage()),
                            );
                          },
                          splashColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),

                    // 4. Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 22, // ปรับลดลงนิดนึงให้พอดีกรอบ
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 5, color: Colors.black45, offset: Offset(1, 1))
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.subtitle,
                                  maxLines: 1, // บังคับบรรทัดเดียวไม่ให้ล้น
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ),
                              // ไอคอนลูกศรเล็กๆ ขยับเมื่อ Hover
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: Matrix4.translationValues(
                                    _isHovered ? 5 : 0, 0, 0),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
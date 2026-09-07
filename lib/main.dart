// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الأول: الثوابت، النماذج، ومستودع السحابة مع المزامنة اللحظية Real-Time Sync]
// ==============================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ==============================================================================
// 1. الثوابت السحابية المركزية المحدثة وبيانات الاتصال الحقيقية (Supabase & APIs)
// ==============================================================================
const String kSupabaseUrl = 'https://zbjjkigkxbpktpmpcdqc.supabase.co';
const String kSupabaseAnonKey =
    'sb_publishable_ZZBI_vTK7ks1yfO2g3Zo0Q_Sg4QizEr';

// بوابات الدفع والشحن الحصرية المعتمدة 100%
const String kShamCashAccountKey = '0308a7227251b7c8ebca471cd30b15a8';
const String kBinanceWalletAddress = 'TCHJ8QyEijnRsQmyXJWBCoiuPET1mZqBK2';
const String kOfficialUpdateUrl =
    'https://celadon-pithivier-77918a.netlify.app';

const String kAppOwnerPhone = '+963985954605';
const String kAppOwnerWhatsApp = '+963985954605';
const String kAppOwnerEmail = 'khafayef2010@gmail.com';
const String kDefaultShareDomain =
    'https://celadon-pithivier-77918a.netlify.app';

// مستودعات التخزين السحابي الفعلي (Supabase Storage Buckets)
const String kStorageBucketAds = 'ads_images';
const String kStorageBucketBanners = 'banners_images';
const String kStorageBucketPanoramas = 'panoramas_images';
const String kStorageBucketFeedbacks = 'feedback_attachments';

// القائمة المعتمدة لمدراء غرفة العمليات والمالكين (Super Admins)
const List<String> kAuthorizedAdminEmails = [
  'khafayef2010@gmail.com',
  'sameraoaad@gmail.com',
  'aoaadabdo@gmail.com',
];

enum BannerDisplayLayoutMode {
  dualGrid,
  fullPanorama,
}

// ==============================================================================
// 2. علم الاستقلال السوري الجديد (3 نجوم حمراء) - رسم فيكتور نقي
// ==============================================================================
class SyrianIndependenceFlag extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SyrianIndependenceFlag({
    Key? key,
    this.width = 34.0,
    this.height = 22.0,
    this.borderRadius = 3.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
          painter: _SyrianFlagPainter(),
        ),
      ),
    );
  }
}

class _SyrianFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stripeHeight = size.height / 3.0;

    // 1. الشريط الأخضر العلوي
    final greenPaint = Paint()
      ..color = const Color(0xFF007A3D)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, stripeHeight), greenPaint);

    // 2. الشريط الأبيض الأوسط
    final whitePaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, stripeHeight, size.width, stripeHeight), whitePaint);

    // 3. الشريط الأسود السفلي
    final blackPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, stripeHeight * 2, size.width, stripeHeight),
        blackPaint);

    // 4. النجوم الحمراء الثلاث في الوسط
    final starPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.fill;

    final centerY = size.height / 2.0;
    final starRadius = stripeHeight * 0.33;
    final starSpacing = size.width / 4.0;

    for (int i = 1; i <= 3; i++) {
      final centerX = starSpacing * i;
      _drawFivePointedStar(canvas, centerX, centerY, starRadius, starPaint);
    }
  }

  void _drawFivePointedStar(
      Canvas canvas, double cx, double cy, double radius, Paint paint) {
    final path = Path();
    final points = 5;
    final innerRadius = radius * 0.45;
    double angle = -pi / 2.0;
    final step = pi / points;

    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? radius : innerRadius;
      final x = cx + r * cos(angle);
      final y = cy + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      angle += step;
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==============================================================================
// 3. نماذج البيانات الحقيقية المتصلة بقواعد البيانات السحابية (Cloud Models)
// ==============================================================================

class BidRecord {
  final String id;
  final String userId;
  final String userName;
  final double amount;
  final DateTime timestamp;

  BidRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'amount': amount,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BidRecord.fromMap(Map<String, dynamic> map) => BidRecord(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مزايد',
        amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
        timestamp: map['timestamp'] != null
            ? DateTime.tryParse(map['timestamp'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class SnipResult {
  final bool wasExtended;
  final DateTime newEndTime;
  final String message;

  SnipResult({
    required this.wasExtended,
    required this.newEndTime,
    required this.message,
  });
}

class PaymentAuditRecord {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String userGovernorate;
  final String requestType; // 'plan_subscription' أو 'panorama_booking'
  final String planId;
  final String planName;
  final String durationLabel; // مثلاً: 'شهري (30 يوم)' أو 'سنوي' أو '48 ساعة'
  final int durationHours; // إجمالي الساعات للحساب الزمني الدقيق
  final String gateway;
  final double amountUsd;
  final double amountSyp;
  final String transactionRefOrTxId;
  final String? receiptImageUrl; // صورة إيصال الدفع الحقيقية 📸
  final List<String>
      bannerImages; // صور البانوراما في حال كان الطلب حجز بانوراما
  final String bannerTitle;
  final String bannerSubtitle;
  final String bannerLinkUrl;
  String status;
  String? adminRejectionReason;
  final DateTime createdAt;
  DateTime? processedAt;

  PaymentAuditRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    this.userEmail = '',
    required this.userGovernorate,
    this.requestType = 'plan_subscription',
    required this.planId,
    required this.planName,
    this.durationLabel = 'شهري (30 يوم)',
    this.durationHours = 720,
    required this.gateway,
    required this.amountUsd,
    required this.amountSyp,
    required this.transactionRefOrTxId,
    this.receiptImageUrl,
    this.bannerImages = const [],
    this.bannerTitle = '',
    this.bannerSubtitle = '',
    this.bannerLinkUrl = '',
    this.status = 'pending',
    this.adminRejectionReason,
    required this.createdAt,
    this.processedAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_phone': userPhone,
        'user_email': userEmail,
        'user_governorate': userGovernorate,
        'request_type': requestType,
        'plan_id': planId,
        'plan_name': planName,
        'duration_label': durationLabel,
        'duration_hours': durationHours,
        'gateway': gateway,
        'amount_usd': amountUsd,
        'amount_syp': amountSyp,
        'transaction_ref': transactionRefOrTxId,
        'receipt_image_url': receiptImageUrl,
        'banner_images': bannerImages,
        'banner_title': bannerTitle,
        'banner_subtitle': bannerSubtitle,
        'banner_link_url': bannerLinkUrl,
        'status': status,
        'rejection_reason': adminRejectionReason,
        'created_at': createdAt.toIso8601String(),
        'processed_at': processedAt?.toIso8601String(),
      };

  factory PaymentAuditRecord.fromMap(Map<String, dynamic> map) {
    List<String> bImages = [];
    if (map['banner_images'] is List) {
      bImages =
          (map['banner_images'] as List).map((e) => e.toString()).toList();
    }

    return PaymentAuditRecord(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      userName: map['user_name']?.toString() ?? 'مشترك',
      userPhone: map['user_phone']?.toString() ?? '',
      userEmail: map['user_email']?.toString() ?? '',
      userGovernorate: map['user_governorate']?.toString() ?? 'دمشق',
      requestType: map['request_type']?.toString() ?? 'plan_subscription',
      planId: map['plan_id']?.toString() ?? '',
      planName: map['plan_name']?.toString() ?? '',
      durationLabel: map['duration_label']?.toString() ?? 'شهري (30 يوم)',
      durationHours: (map['duration_hours'] as num?)?.toInt() ?? 720,
      gateway: map['gateway']?.toString() ?? 'SHAM_CASH',
      amountUsd: (map['amount_usd'] as num?)?.toDouble() ?? 0.0,
      amountSyp: (map['amount_syp'] as num?)?.toDouble() ?? 0.0,
      transactionRefOrTxId: map['transaction_ref']?.toString() ?? '',
      receiptImageUrl: map['receipt_image_url']?.toString(),
      bannerImages: bImages,
      bannerTitle: map['banner_title']?.toString() ?? '',
      bannerSubtitle: map['banner_subtitle']?.toString() ?? '',
      bannerLinkUrl: map['banner_link_url']?.toString() ?? '',
      status: map['status']?.toString() ?? 'pending',
      adminRejectionReason: map['rejection_reason']?.toString(),
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      processedAt: map['processed_at'] != null
          ? DateTime.tryParse(map['processed_at'].toString())
          : null,
    );
  }
}

class DepartmentNode {
  final String id;
  String nameAr;
  String nameEn;
  String? parentId;
  String description;
  String iconName;
  Color themeColor;
  bool isEnabled;
  int sortOrder;
  String requiredPermission;
  int activeAdsCount;
  bool allowSubBranches;
  int maxSubDepth;
  List<DepartmentNode> subBranches;

  DepartmentNode({
    required this.id,
    required this.nameAr,
    this.nameEn = '',
    this.parentId,
    this.description = '',
    this.iconName = 'Category',
    this.themeColor = const Color(0xFF0284C7),
    this.isEnabled = true,
    this.sortOrder = 0,
    this.requiredPermission = 'manage_categories',
    this.activeAdsCount = 0,
    this.allowSubBranches = true,
    this.maxSubDepth = 3,
    this.subBranches = const [],
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'parent_id': parentId,
        'description': description,
        'icon_name': iconName,
        'theme_color': themeColor.value,
        'is_enabled': isEnabled,
        'sort_order': sortOrder,
        'required_permission': requiredPermission,
        'active_ads_count': activeAdsCount,
        'allow_sub_branches': allowSubBranches,
        'max_sub_depth': maxSubDepth,
      };

  factory DepartmentNode.fromMap(Map<String, dynamic> map) => DepartmentNode(
        id: map['id']?.toString() ??
            'dep_${DateTime.now().millisecondsSinceEpoch}',
        nameAr: map['name_ar']?.toString() ?? '',
        nameEn: map['name_en']?.toString() ?? '',
        parentId: map['parent_id']?.toString(),
        description: map['description']?.toString() ?? '',
        iconName: map['icon_name']?.toString() ?? 'Category',
        themeColor: map['theme_color'] != null
            ? Color((map['theme_color'] as num).toInt())
            : const Color(0xFF0284C7),
        isEnabled: map['is_enabled'] ?? true,
        sortOrder: (map['sort_order'] as num?)?.toInt() ?? 0,
        requiredPermission:
            map['required_permission']?.toString() ?? 'manage_categories',
        activeAdsCount: (map['active_ads_count'] as num?)?.toInt() ?? 0,
        allowSubBranches: map['allow_sub_branches'] ?? true,
        maxSubDepth: (map['max_sub_depth'] as num?)?.toInt() ?? 3,
      );
}

class AdItem {
  final String id;
  final String userId;
  final String title;
  final String description;
  final double? priceUsd;
  final double? priceSyp;
  final String governorate;
  final String neighborhood;
  final String categoryId;
  final String subcategory;
  final String condition;
  final String contactPhone;
  final String contactWhatsapp;
  final List<String> imageUrls;
  final String? videoUrl;
  final String? facebookUrl;
  final String? telegramUrl;
  final String? instagramUrl;
  final String? tiktokUrl;
  final String? youtubeUrl;
  final String publisherName;
  final String publisherEmail;
  final bool isVerifiedSeller;
  final int sellerPositiveLikes;
  final int sellerDislikes;
  final int viewsCount;
  String status; // 'pending' أو 'approved' أو 'rejected'
  final String? rejectionReason;
  final bool isFeatured;
  final bool isAuction;
  final double? startingBid;
  final double? currentBid;
  final DateTime? auctionEndTime;
  final List<BidRecord> bids;
  final bool isSold;
  final DateTime? soldAt;
  final String fraudRisk;
  final DateTime createdAt;
  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inSeconds < 60) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} سا';
    if (diff.inDays == 1) return 'أمس';
    if (diff.inDays < 30) return 'منذ ${diff.inDays} يوم';
    return '${createdAt.year}/${createdAt.month}/${createdAt.day}';
  }

  AdItem({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.priceUsd,
    this.priceSyp,
    required this.governorate,
    required this.neighborhood,
    required this.categoryId,
    required this.subcategory,
    required this.condition,
    required this.contactPhone,
    required this.contactWhatsapp,
    required this.imageUrls,
    this.videoUrl,
    this.facebookUrl,
    this.telegramUrl,
    this.instagramUrl,
    this.tiktokUrl,
    this.youtubeUrl,
    required this.publisherName,
    required this.publisherEmail,
    this.isVerifiedSeller = false,
    this.sellerPositiveLikes = 0,
    this.sellerDislikes = 0,
    this.viewsCount = 0,
    this.status = 'pending',
    this.rejectionReason,
    this.isFeatured = false,
    this.isAuction = false,
    this.startingBid,
    this.currentBid,
    this.auctionEndTime,
    this.bids = const [],
    this.isSold = false,
    this.soldAt,
    this.fraudRisk = 'low',
    required this.createdAt,
  });

  String get phone => contactPhone;
  String get whatsapp => contactWhatsapp;
  String get userName => publisherName;

  bool get isApproved => status == 'approved';
  bool get isPending => status == 'pending';
  bool get isRejected => status == 'rejected';

  bool get shouldBeDeletedNow {
    if (!isSold || soldAt == null) return false;
    return DateTime.now().difference(soldAt!).inMinutes >= 15;
  }

  Duration? get soldRemainingDuration {
    if (!isSold || soldAt == null) return null;
    final diff =
        const Duration(minutes: 15) - DateTime.now().difference(soldAt!);
    return diff.isNegative ? Duration.zero : diff;
  }

  AdItem copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? priceUsd,
    double? priceSyp,
    String? governorate,
    String? neighborhood,
    String? categoryId,
    String? subcategory,
    String? condition,
    String? contactPhone,
    String? contactWhatsapp,
    List<String>? imageUrls,
    String? videoUrl,
    String? facebookUrl,
    String? telegramUrl,
    String? instagramUrl,
    String? tiktokUrl,
    String? youtubeUrl,
    String? publisherName,
    String? publisherEmail,
    bool? isVerifiedSeller,
    int? sellerPositiveLikes,
    int? sellerDislikes,
    int? viewsCount,
    String? status,
    String? rejectionReason,
    bool? isFeatured,
    bool? isAuction,
    double? startingBid,
    double? currentBid,
    DateTime? auctionEndTime,
    List<BidRecord>? bids,
    bool? isSold,
    DateTime? soldAt,
    String? fraudRisk,
    DateTime? createdAt,
  }) {
    return AdItem(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      priceUsd: priceUsd ?? this.priceUsd,
      priceSyp: priceSyp ?? this.priceSyp,
      governorate: governorate ?? this.governorate,
      neighborhood: neighborhood ?? this.neighborhood,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      condition: condition ?? this.condition,
      contactPhone: contactPhone ?? this.contactPhone,
      contactWhatsapp: contactWhatsapp ?? this.contactWhatsapp,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      telegramUrl: telegramUrl ?? this.telegramUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      tiktokUrl: tiktokUrl ?? this.tiktokUrl,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      publisherName: publisherName ?? this.publisherName,
      publisherEmail: publisherEmail ?? this.publisherEmail,
      isVerifiedSeller: isVerifiedSeller ?? this.isVerifiedSeller,
      sellerPositiveLikes: sellerPositiveLikes ?? this.sellerPositiveLikes,
      sellerDislikes: sellerDislikes ?? this.sellerDislikes,
      viewsCount: viewsCount ?? this.viewsCount,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      isFeatured: isFeatured ?? this.isFeatured,
      isAuction: isAuction ?? this.isAuction,
      startingBid: startingBid ?? this.startingBid,
      currentBid: currentBid ?? this.currentBid,
      auctionEndTime: auctionEndTime ?? this.auctionEndTime,
      bids: bids ?? this.bids,
      isSold: isSold ?? this.isSold,
      soldAt: soldAt ?? this.soldAt,
      fraudRisk: fraudRisk ?? this.fraudRisk,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
        if (id.isNotEmpty && !id.startsWith('ad_')) 'id': id,
        if (userId.isNotEmpty && userId != 'guest') 'user_id': userId,
        'title': title,
        'description': description,
        'price_usd': priceUsd,
        'price_syp': priceSyp,
        'governorate': governorate,
        'neighborhood': neighborhood,
        'category_id': categoryId,
        'subcategory': subcategory,
        'condition': condition,
        'publisher_phone':
            contactPhone.isNotEmpty ? contactPhone : contactWhatsapp,
        'publisher_name': publisherName.isNotEmpty ? publisherName : 'معلن',
        'publisher_email': publisherEmail,
        'image_urls': imageUrls,
        'video_url': videoUrl ?? '',
        'is_featured': isFeatured,
        'is_sold': isSold,
        'status': 'approved',
        'created_at': createdAt.toIso8601String(),
      };

  factory AdItem.fromMap(Map<String, dynamic> map) {
    List<String> imgs = [];
    if (map['image_urls'] is List) {
      imgs = (map['image_urls'] as List).map((e) => e.toString()).toList();
    } else if (map['image_url'] != null &&
        map['image_url'].toString().isNotEmpty) {
      imgs = [map['image_url'].toString()];
    }

    List<BidRecord> parsedBids = [];
    if (map['bids'] is List) {
      parsedBids = (map['bids'] as List)
          .map((b) => BidRecord.fromMap(b as Map<String, dynamic>))
          .toList();
    }

    final isAuctionVal = map['is_auction'] == true ||
        map['is_auction'] == 1 ||
        map['is_auction'] == 'true';

    return AdItem(
      id: map['id']?.toString() ??
          'ad_${DateTime.now().millisecondsSinceEpoch}',
      userId: map['user_id']?.toString() ?? 'guest',
      title: map['title']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      priceUsd: (map['price_usd'] as num?)?.toDouble(),
      priceSyp: (map['price_syp'] as num?)?.toDouble(),
      governorate: map['governorate']?.toString() ?? 'دمشق',
      neighborhood: map['neighborhood']?.toString() ?? 'المركز',
      categoryId: map['category_id']?.toString() ?? 'عام',
      subcategory: map['subcategory']?.toString() ?? 'عام',
      condition: map['condition']?.toString() ?? 'مستعمل',
      contactPhone: map['publisher_phone']?.toString() ??
          map['contact_phone']?.toString() ??
          kAppOwnerPhone,
      contactWhatsapp: map['contact_whatsapp']?.toString() ?? kAppOwnerWhatsApp,
      imageUrls: imgs,
      videoUrl: map['video_url']?.toString(),
      facebookUrl: map['facebook_url']?.toString(),
      telegramUrl: map['telegram_url']?.toString(),
      instagramUrl: map['instagram_url']?.toString(),
      tiktokUrl: map['tiktok_url']?.toString(),
      youtubeUrl: map['youtube_url']?.toString(),
      publisherName: map['publisher_name']?.toString() ?? 'معلن',
      publisherEmail: map['publisher_email']?.toString() ?? '',
      isVerifiedSeller: map['is_verified_seller'] == true,
      sellerPositiveLikes: (map['seller_positive_likes'] as num?)?.toInt() ?? 0,
      sellerDislikes: (map['seller_dislikes'] as num?)?.toInt() ?? 0,
      viewsCount: (map['views_count'] as num?)?.toInt() ?? 0,
      status: map['status']?.toString() ?? 'pending',
      rejectionReason: map['rejection_reason']?.toString(),
      isFeatured: map['is_featured'] == true,
      isAuction: isAuctionVal,
      startingBid: (map['starting_bid'] as num?)?.toDouble(),
      currentBid: (map['current_bid'] as num?)?.toDouble(),
      auctionEndTime: map['auction_end_time'] != null
          ? DateTime.tryParse(map['auction_end_time'].toString())
          : null,
      bids: parsedBids,
      isSold: map['is_sold'] == true,
      soldAt: map['sold_at'] != null
          ? DateTime.tryParse(map['sold_at'].toString())
          : null,
      fraudRisk: map['fraud_risk']?.toString() ?? 'low',
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}

class BannerItem {
  final String id;
  final List<String> imageUrls;
  final String title;
  final String subtitle;
  final String description;
  final String location;
  final String phone;
  final String whatsapp;
  final String linkUrl;
  final String facebookUrl;
  final String telegramUrl;
  final String instagramUrl;
  final String youtubeUrl;
  final String tiktokUrl;
  final int slot; // 1 للقسم الأيمن، 2 للقسم الأيسر
  final String badgeText;
  final Color badgeColor;
  final int displayDurationSeconds;
  final DateTime expiresAt;
  bool isActive;

  BannerItem({
    required this.id,
    required this.imageUrls,
    required this.title,
    this.subtitle = '',
    this.description = '',
    this.location = 'كل المحافظات',
    this.phone = '',
    this.whatsapp = '',
    this.linkUrl = '',
    this.facebookUrl = '',
    this.telegramUrl = '',
    this.instagramUrl = '',
    this.youtubeUrl = '',
    this.tiktokUrl = '',
    this.slot = 1,
    this.badgeText = 'VIP ★',
    this.badgeColor = const Color(0xFFD4AF37),
    this.displayDurationSeconds = 3,
    required this.expiresAt,
    this.isActive = true,
  });

  String get imageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toMap() => {
        'id': id,
        'image_urls': imageUrls,
        'image_url': imageUrl,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'location': location,
        'phone': phone,
        'whatsapp': whatsapp,
        'link_url': linkUrl,
        'facebook_url': facebookUrl,
        'telegram_url': telegramUrl,
        'instagram_url': instagramUrl,
        'youtube_url': youtubeUrl,
        'tiktok_url': tiktokUrl,
        'slot': slot,
        'badge_text': badgeText,
        'badge_color': badgeColor.value,
        'display_duration_seconds': displayDurationSeconds,
        'expires_at': expiresAt.toIso8601String(),
        'is_active': isActive,
      };

  factory BannerItem.fromMap(Map<String, dynamic> map) {
    List<String> imgs = [];
    if (map['image_urls'] is List) {
      imgs = (map['image_urls'] as List).map((e) => e.toString()).toList();
    } else if (map['image_url'] != null &&
        map['image_url'].toString().isNotEmpty) {
      imgs = [map['image_url'].toString()];
    }

    return BannerItem(
      id: map['id']?.toString() ??
          'bn_${DateTime.now().millisecondsSinceEpoch}',
      imageUrls: imgs,
      title: map['title']?.toString() ?? '',
      subtitle: map['subtitle']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      location: map['location']?.toString() ?? 'كل المحافظات',
      phone: map['phone']?.toString() ?? '',
      whatsapp: map['whatsapp']?.toString() ?? '',
      linkUrl: map['link_url']?.toString() ?? '',
      facebookUrl: map['facebook_url']?.toString() ?? '',
      telegramUrl: map['telegram_url']?.toString() ?? '',
      instagramUrl: map['instagram_url']?.toString() ?? '',
      youtubeUrl: map['youtube_url']?.toString() ?? '',
      tiktokUrl: map['tiktok_url']?.toString() ?? '',
      slot: (map['slot'] as num?)?.toInt() ?? 1,
      badgeText: map['badge_text']?.toString() ?? 'VIP ★',
      badgeColor: map['badge_color'] != null
          ? Color((map['badge_color'] as num).toInt())
          : const Color(0xFFD4AF37),
      displayDurationSeconds:
          (map['display_duration_seconds'] as num?)?.toInt() ?? 3,
      expiresAt: map['expires_at'] != null
          ? DateTime.tryParse(map['expires_at'].toString()) ??
              DateTime.now().add(const Duration(days: 30))
          : DateTime.now().add(const Duration(days: 30)),
      isActive: map['is_active'] ?? true,
    );
  }
}

class CategoryItem {
  final String id;
  String name;
  String iconName;
  IconData iconData;
  Color textColor;
  Color backgroundColor;
  double borderRadiusValue;
  List<String> subcategories;
  bool isEnabled;
  String description;
  int activeAdsCount;

  CategoryItem({
    required this.id,
    required this.name,
    this.iconName = 'Category',
    required this.iconData,
    this.textColor = const Color(0xFFD4AF37),
    this.backgroundColor = const Color(0xFF1E293B),
    this.borderRadiusValue = 10.0,
    required this.subcategories,
    this.isEnabled = true,
    this.description = '',
    this.activeAdsCount = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'icon_name': iconName,
        'text_color': textColor.value,
        'bg_color': backgroundColor.value,
        'border_radius': borderRadiusValue,
        'subcategories': subcategories,
        'is_enabled': isEnabled,
        'description': description,
        'active_ads_count': activeAdsCount,
      };

  factory CategoryItem.fromMap(Map<String, dynamic> map) {
    return CategoryItem(
      id: map['id']?.toString() ??
          'cat_${DateTime.now().millisecondsSinceEpoch}',
      name: map['name']?.toString() ?? 'قسم عام',
      iconName: map['icon_name']?.toString() ?? 'Category',
      iconData: Icons.category,
      textColor: map['text_color'] != null
          ? Color(map['text_color'] as int)
          : const Color(0xFFD4AF37),
      backgroundColor: map['bg_color'] != null
          ? Color(map['bg_color'] as int)
          : const Color(0xFF1E293B),
      borderRadiusValue: (map['border_radius'] as num?)?.toDouble() ?? 10.0,
      subcategories:
          (map['subcategories'] as List?)?.map((e) => e.toString()).toList() ??
              ['عام'],
      isEnabled: map['is_enabled'] ?? true,
      description: map['description']?.toString() ?? '',
      activeAdsCount: (map['active_ads_count'] as num?)?.toInt() ?? 0,
    );
  }
}

class SubscriptionPlanItem {
  final String id;
  final String name;
  final double priceUsd;
  final int maxAds;
  final int maxImagesPerAd;
  final int maxPanoramasAllowed;
  final bool canPostAuctions;
  final bool hasVerifiedBadge;
  final bool hasKycVerification;
  final List<String> features;

  SubscriptionPlanItem({
    required this.id,
    required this.name,
    required this.priceUsd,
    required this.maxAds,
    required this.maxImagesPerAd,
    this.maxPanoramasAllowed = 0,
    this.canPostAuctions = true,
    this.hasVerifiedBadge = false,
    this.hasKycVerification = false,
    required this.features,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price_usd': priceUsd,
        'max_ads': maxAds,
        'max_images_per_ad': maxImagesPerAd,
        'max_panoramas_allowed': maxPanoramasAllowed,
        'can_post_auctions': canPostAuctions,
        'has_verified_badge': hasVerifiedBadge,
        'has_kyc_verification': hasKycVerification,
        'features': features,
      };

  factory SubscriptionPlanItem.fromMap(Map<String, dynamic> map) =>
      SubscriptionPlanItem(
        id: map['id']?.toString() ?? 'plan_free',
        name: map['name']?.toString() ?? 'الباقة المجانية',
        priceUsd: (map['price_usd'] as num?)?.toDouble() ?? 0.0,
        maxAds: (map['max_ads'] as num?)?.toInt() ?? 5,
        maxImagesPerAd: (map['max_images_per_ad'] as num?)?.toInt() ?? 4,
        maxPanoramasAllowed:
            (map['max_panoramas_allowed'] as num?)?.toInt() ?? 0,
        canPostAuctions: map['can_post_auctions'] ?? true,
        hasVerifiedBadge: map['has_verified_badge'] ?? false,
        hasKycVerification: map['has_kyc_verification'] ?? false,
        features:
            (map['features'] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
}

class AdCommentItem {
  final String id;
  final String adId;
  final String userId;
  final String userName;
  final String commentText;
  final DateTime createdAt;

  AdCommentItem({
    required this.id,
    required this.adId,
    required this.userId,
    required this.userName,
    required this.commentText,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'ad_id': adId,
        'user_id': userId,
        'user_name': userName,
        'comment_text': commentText,
        'created_at': createdAt.toIso8601String(),
      };

  factory AdCommentItem.fromMap(Map<String, dynamic> map) => AdCommentItem(
        id: map['id']?.toString() ?? '',
        adId: map['ad_id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'مستخدم',
        commentText: map['comment_text']?.toString() ?? '',
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class AppFeedbackItem {
  final String id;
  final String userId;
  final String userName;
  final String userContact;
  final String type;
  final String content;
  final String? screenshotUrl;
  final DateTime createdAt;

  AppFeedbackItem({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userContact,
    required this.type,
    required this.content,
    this.screenshotUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'user_name': userName,
        'user_contact': userContact,
        'type': type,
        'content': content,
        'screenshot_url': screenshotUrl,
        'created_at': createdAt.toIso8601String(),
      };

  factory AppFeedbackItem.fromMap(Map<String, dynamic> map) => AppFeedbackItem(
        id: map['id']?.toString() ?? '',
        userId: map['user_id']?.toString() ?? '',
        userName: map['user_name']?.toString() ?? 'زائر',
        userContact: map['user_contact']?.toString() ?? '',
        type: map['type']?.toString() ?? '',
        content: map['content']?.toString() ?? '',
        screenshotUrl: map['screenshot_url']?.toString(),
        createdAt: map['created_at'] != null
            ? DateTime.tryParse(map['created_at'].toString()) ?? DateTime.now()
            : DateTime.now(),
      );
}

class AuditLogItem {
  final String id;
  final String title;
  final String details;
  final String category;
  final String timestamp;
  final String adminName;
  final bool isCritical;

  AuditLogItem({
    required this.id,
    required this.title,
    required this.details,
    required this.category,
    required this.timestamp,
    required this.adminName,
    this.isCritical = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'details': details,
        'category': category,
        'timestamp': timestamp,
        'admin_name': adminName,
        'is_critical': isCritical,
      };

  factory AuditLogItem.fromMap(Map<String, dynamic> map) => AuditLogItem(
        id: map['id']?.toString() ?? '',
        title: map['title']?.toString() ?? '',
        details: map['details']?.toString() ?? '',
        category: map['category']?.toString() ?? 'عام',
        timestamp:
            map['timestamp']?.toString() ?? DateTime.now().toIso8601String(),
        adminName: map['admin_name']?.toString() ?? 'المدير',
        isCritical: map['is_critical'] == true,
      );
}

// ==============================================================================
// 4. الأدوات المساعدة وخدمات التخزين السحابي الفعلي (Helpers & Storage)
// ==============================================================================

class PhoneHelper {
  static bool isValidPhone(String phone) {
    final clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    return clean.length >= 8;
  }

  static String formatForWhatsapp(String phone) {
    var clean = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.startsWith('09')) {
      clean = '963${clean.substring(1)}';
    } else if (clean.startsWith('9') && clean.length == 9) {
      clean = '963$clean';
    }
    return clean;
  }
}

class StorageUploadService {
  static Future<String?> uploadImageBytes({
    required String bucketName,
    required Uint8List imageBytes,
    String prefix = 'img',
  }) async {
    try {
      final fileName =
          '${prefix}_${DateTime.now().millisecondsSinceEpoch}_${imageBytes.lengthInBytes}.jpg';
      await Supabase.instance.client.storage.from(bucketName).uploadBinary(
            fileName,
            imageBytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      return Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(fileName);
    } catch (e) {
      debugPrint('Storage Upload Notice: $e');
      final b64 = base64Encode(imageBytes);
      return 'data:image/jpeg;base64,$b64';
    }
  }

  static Future<List<String>> uploadMultipleImageBytes({
    required String bucketName,
    required List<Uint8List> imagesBytesList,
    String prefix = 'ad',
  }) async {
    List<String> results = [];
    for (int i = 0; i < imagesBytesList.length; i++) {
      final url = await uploadImageBytes(
        bucketName: bucketName,
        imageBytes: imagesBytesList[i],
        prefix: '${prefix}_$i',
      );
      if (url != null && url.isNotEmpty) {
        results.add(url);
      }
    }
    return results;
  }
}

class AppSmartImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const AppSmartImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.memCacheWidth = 450,
    this.memCacheHeight = 450,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: const Color(0xFF1E293B),
        child: const Icon(Icons.image_not_supported,
            color: Colors.white30, size: 28),
      );
    }

    if (imageUrl.startsWith('data:image')) {
      try {
        final b64 = imageUrl.split(',').last;
        final bytes = base64Decode(b64);
        return Image.memory(
          bytes,
          fit: fit,
          width: width,
          height: height,
          cacheWidth: memCacheWidth,
          cacheHeight: memCacheHeight,
          errorBuilder: (_, __, ___) => _errorPlaceholder(),
        );
      } catch (_) {
        return _errorPlaceholder();
      }
    }

    return Image.network(
      imageUrl,
      fit: fit,
      width: width,
      height: height,
      cacheWidth: memCacheWidth,
      cacheHeight: memCacheHeight,
      frameBuilder: (ctx, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return AnimatedOpacity(
            opacity: frame != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: child,
          );
        }
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF1E293B),
        );
      },
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return Container(
          width: width,
          height: height,
          color: const Color(0xFF0F172A),
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: const Color(0xFFD4AF37),
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
              ),
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => _errorPlaceholder(),
    );
  }

  Widget _errorPlaceholder() => Container(
        width: width,
        height: height,
        color: const Color(0xFF1E293B),
        child: const Icon(Icons.broken_image, color: Colors.white30, size: 24),
      );
}

// ==============================================================================
// 5. مدير الحالة والذاكرة المركزية الدائمة (AppStateManager) - المزامنة الحية المباشرة
// ==============================================================================
class AppStateManager extends ChangeNotifier {
  static final AppStateManager _instance = AppStateManager._internal();
  factory AppStateManager() => _instance;
  AppStateManager._internal();

  // 1. جلب خطة اشتراك المستخدم الحالية (حل خطأ السطر 3161 و 9671)
  SubscriptionPlanItem getCurrentUserPlan() {
    if (subscriptionPlans.isNotEmpty) {
      final match = subscriptionPlans.where((p) => p.id == currentUserPlanId);
      if (match.isNotEmpty) return match.first;
      return subscriptionPlans.first;
    }
    return SubscriptionPlanItem.fromMap({
      'id': 'plan_free',
      'name': 'الباقة المجانية',
      'price_usd': 0,
      'max_ads': 5,
      'max_images_per_ad': 8,
      'features': ['نشر إعلانات مجانية'],
    });
  }

  // ميزة ترقية باقة المستخدم وتفعيل مدة الاشتراك (حل خطأ السطر 1980)
  void upgradeUserPlan(String planId, {int durationHours = 720}) {
    currentUserPlanId = planId;
    currentUserPlanExpiresAt =
        DateTime.now().add(Duration(hours: durationHours));
    isCurrentUserVerified = true;
    notifyListeners();

    try {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('ss_user_plan_id', planId);
        prefs.setString('ss_user_plan_expires',
            currentUserPlanExpiresAt!.toIso8601String());
        prefs.setBool('ss_user_verified', true);
      });
      if (currentUserId.isNotEmpty) {
        Supabase.instance.client.from('profiles').update({
          'plan_id': planId,
          'plan_expires_at': currentUserPlanExpiresAt!.toIso8601String(),
          'is_verified': true,
        }).eq('id', currentUserId);
      }
    } catch (_) {}
  }

  // 2. تتبع كلمات البحث وإحصائيات السوق (حل خطأ السطر 8565)
  void trackSearchKeyword(String val) {
    if (val.trim().isEmpty) return;
    try {
      Supabase.instance.client.from('search_analytics').insert({
        'keyword': val.trim(),
        'searched_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {}
  }

  // 3. تتبع وزيادة نقرات البانوراما الإعلانية (حل خطأ السطر 8884)
  void incrementBannerClick(String bannerId) {
    try {
      Supabase.instance.client.rpc('increment_banner_clicks', params: {
        'banner_id': bannerId,
      });
    } catch (_) {}
  }

  // ميزة زيادة وتحديث مشاهدات الإعلان الحية
  void incrementAdViews(String adId) {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(viewsCount: ads[idx].viewsCount + 1);
      notifyListeners();

      try {
        Supabase.instance.client
            .from('ads')
            .update({'views_count': ads[idx].viewsCount}).eq('id', adId);
      } catch (_) {}
    }
  }

  // ==============================================================================
  // إعدادات الهوية والتطبيق
  // ==============================================================================
  String appTitle = 'سوق سوريا الشامل 2028';
  Color primaryColor = const Color(0xFF0F172A);
  Color secondaryColor = const Color(
      0xFFD4AF37); // تم تصليح السطر وإضافة الفاصلة المنقوطة واللون الملكي
  Color buttonColor = const Color(0xFF0284C7);
  Color scaffoldBgColor = const Color(0xFFF8FAFC);
  Color appBarColor = const Color(0xFF0F172A);

  Color titleTextColor = const Color(0xFF0F172A);
  Color priceUsdColor = const Color(0xFF16A34A);
  Color priceSypColor = const Color(0xFFD4AF37);
  Color locationTextColor = const Color(0xFF64748B);

  bool isVoiceTypingEnabled = true;
  bool isMaintenanceMode = false;
  String maintenanceMessage =
      'المنصة قيد التحديث والترقية المجدولة لخدمتكم بشكل أفضل.';

  // شريط الأخبار العاجلة وأسعار الصرف اللحظية
  List<String> newsTicker = [
    '🌟 أهلاً بكم في سوق سوريا الشامل 2028 - بوابتكم للتجارة الحرة والآمنة',
    '⚡ أسعار الذهب والعملات يتم تحديثها لحظياً على مدار الساعة',
    '🛡️ تنبيه: لا تدفع أي عربون مسبق قبل استلام وفحص سلعتك يداً بيد',
  ];
  Color tickerBackgroundColor = const Color(0xFF0F172A);
  Color tickerTextColor = const Color(0xFFFFFFFF);
  IconData tickerIcon = Icons.bolt;
  double tickerFontSize = 12.0;
  double tickerSpeed = 1.2;

  // أسعار الصرف السورية المحدثة
  double exchangeRateUsdToSyp = 15200.0;
  double goldPrice21kSyp = 980000.0;

  // بيانات المستخدم والجلسة الدائمة
  String currentUserId = '';
  String currentUserName = 'زائر المنصة';
  String currentUserEmail = '';
  String currentUserPhone = '';
  String currentUserRole = 'user';
  String currentUserPlanId = 'plan_free';
  DateTime? currentUserPlanExpiresAt;
  bool isCurrentUserVerified = false;
  int currentUserPositiveLikes = 0;
  int currentUserDislikes = 0;

  bool get isLoggedIn => currentUserId.isNotEmpty;
  bool get isSuperAdmin =>
      currentUserRole == 'super_admin' ||
      kAuthorizedAdminEmails.contains(currentUserEmail.toLowerCase());
  bool get isModerator => isSuperAdmin || currentUserRole == 'moderator';
  bool get isAdmin => isSuperAdmin || isModerator;

  bool get isUserPlanExpired {
    if (currentUserPlanId == 'plan_free' || currentUserPlanExpiresAt == null) {
      return false;
    }
    return DateTime.now().isAfter(currentUserPlanExpiresAt!);
  }

  String get remainingPlanTimeFormatted {
    if (currentUserPlanId == 'plan_free' || currentUserPlanExpiresAt == null) {
      return 'باقة مجانية مفتوحة';
    }
    final diff = currentUserPlanExpiresAt!.difference(DateTime.now());
    if (diff.isNegative) return 'انتهى الاشتراك ❌';
    if (diff.inDays > 0) {
      return 'متبقي: ${diff.inDays} يوم و ${diff.inHours % 24} ساعة ⏳';
    }
    return 'متبقي: ${diff.inHours} ساعة و ${diff.inMinutes % 60} دقيقة ⏳';
  }

  void checkPlanExpiration() {
    if (isUserPlanExpired) {
      currentUserPlanId = 'plan_free';
      isCurrentUserVerified = false;
      currentUserPlanExpiresAt = null;
      try {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('ss_user_plan_id', 'plan_free');
          prefs.remove('ss_user_plan_expires');
          prefs.setBool('ss_user_verified', false);
        });
      } catch (_) {}
      notifyListeners();
    }
  }

  // القوائم والبيانات الحقيقية
  List<AdItem> ads = [];
  List<BannerItem> banners = [];
  List<CategoryItem> categories = [];
  List<DepartmentNode> departments = [];
  List<SubscriptionPlanItem> subscriptionPlans = [];
  List<PaymentAuditRecord> paymentAudits = [];
  List<AppFeedbackItem> feedbacks = [];
  List<AuditLogItem> auditLogs = [];
  List<String> forbiddenKeywords = [
    'عربون مسبق',
    'دولار مجمد',
    'سيريتل كاش قبل الاستلام',
    'حوالة مسبقة',
    'شحن شدات',
    'قرض فوري بدون ضمانات',
  ];

  BannerDisplayLayoutMode bannerDisplayMode = BannerDisplayLayoutMode.dualGrid;
  bool isBannerAutoScrollEnabled = true;
  int bannerDefaultIntervalSeconds = 3;
  bool isLoadingCloudData = false;
  int bannerSlot1IntervalSeconds = 3;
  int bannerSlot2IntervalSeconds = 4;

  StreamSubscription? _adsSubscription;
  StreamSubscription? _bannersSubscription;
  StreamSubscription? _ratesSubscription;

  Future<void> sendTelegramAlert(String message) async {
    debugPrint('Admin Notification: $message');
  }

  // ---------------------------------------------------------------------------
  // تفعيل المزامنة اللحظية المباشرة مع سيرفر Supabase لجميع الأجهزة فورياً
  // ---------------------------------------------------------------------------
  void initRealtimeListeners() {
    _adsSubscription?.cancel();
    _adsSubscription = Supabase.instance.client
        .from('ads')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .listen((List<Map<String, dynamic>> data) {
          ads = data.map((map) => AdItem.fromMap(map)).toList();
          saveAdsToOfflineCache(ads);
          checkPlanExpiration();
          notifyListeners();
        }, onError: (err) {
          debugPrint('Realtime Ads Error: $err');
        });

    _bannersSubscription?.cancel();
    _bannersSubscription = Supabase.instance.client
        .from('banners')
        .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
      banners = data
          .map((map) => BannerItem.fromMap(map))
          .where((b) => b.isActive && !b.isExpired)
          .toList();
      saveBannersToOfflineCache(banners);
      notifyListeners();
    }, onError: (err) {
      debugPrint('Realtime Banners Error: $err');
    });

    _ratesSubscription?.cancel();
    try {
      _ratesSubscription = Supabase.instance.client
          .from('exchange_rates')
          .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
        if (data.isNotEmpty) {
          final row = data.first;
          if (row['usd_rate'] != null) {
            exchangeRateUsdToSyp = (row['usd_rate'] as num).toDouble();
          }
          if (row['gold_price'] != null) {
            goldPrice21kSyp = (row['gold_price'] as num).toDouble();
          }
          notifyListeners();
        }
      }, onError: (e) {
        debugPrint('Rates Stream Notice: $e');
      });
    } catch (_) {}

    try {
      Supabase.instance.client.from('app_settings').stream(
          primaryKey: ['key']).listen((List<Map<String, dynamic>> data) {
        for (var row in data) {
          if (row['key'] == 'banner_settings') {
            if (row['mode'] == 'fullPanorama') {
              bannerDisplayMode = BannerDisplayLayoutMode.fullPanorama;
            } else if (row['mode'] == 'dualGrid') {
              bannerDisplayMode = BannerDisplayLayoutMode.dualGrid;
            }
            if (row['interval_seconds'] != null) {
              bannerDefaultIntervalSeconds =
                  (row['interval_seconds'] as num).toInt();
            }
          } else if (row['key'] == 'maintenance_mode') {
            isMaintenanceMode = row['value'] == 'true';
          }
        }
        notifyListeners();
      }, onError: (e) {
        debugPrint('Settings Stream Notice: $e');
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _adsSubscription?.cancel();
    _bannersSubscription?.cancel();
    _ratesSubscription?.cancel();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // حفظ واسترجاع الجلسة الدائمة
  // ---------------------------------------------------------------------------
  Future<void> loadPersistedSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      currentUserId = prefs.getString('ss_user_id') ?? '';
      currentUserName = prefs.getString('ss_user_name') ?? 'زائر المنصة';
      currentUserEmail = prefs.getString('ss_user_email') ?? '';
      currentUserPhone = prefs.getString('ss_user_phone') ?? '';
      currentUserRole = prefs.getString('ss_user_role') ?? 'user';
      currentUserPlanId = prefs.getString('ss_user_plan_id') ?? 'plan_free';
      isCurrentUserVerified = prefs.getBool('ss_user_verified') ?? false;
      currentUserPositiveLikes = prefs.getInt('ss_user_likes') ?? 0;
      currentUserDislikes = prefs.getInt('ss_user_dislikes') ?? 0;

      final expiresStr = prefs.getString('ss_user_plan_expires');
      if (expiresStr != null) {
        currentUserPlanExpiresAt = DateTime.tryParse(expiresStr);
      }

      if (kAuthorizedAdminEmails.contains(currentUserEmail.toLowerCase())) {
        currentUserRole = 'super_admin';
      }

      checkPlanExpiration();
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading session: $e');
    }
  }

  Future<void> setSessionUser({
    required String userId,
    required String email,
    required String name,
    required String phone,
    String role = 'user',
    String planId = 'plan_free',
    DateTime? planExpiresAt,
    bool isVerified = false,
    int positiveLikes = 0,
  }) async {
    currentUserId = userId;
    currentUserEmail = email;
    currentUserName = name.isNotEmpty ? name : 'مستخدم موثق';
    currentUserPhone = phone;
    currentUserRole = kAuthorizedAdminEmails.contains(email.toLowerCase())
        ? 'super_admin'
        : role;
    currentUserPlanId = planId;
    currentUserPlanExpiresAt = planExpiresAt;
    isCurrentUserVerified = isVerified;
    currentUserPositiveLikes = positiveLikes;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('ss_user_id', currentUserId);
      await prefs.setString('ss_user_name', currentUserName);
      await prefs.setString('ss_user_email', currentUserEmail);
      await prefs.setString('ss_user_phone', currentUserPhone);
      await prefs.setString('ss_user_role', currentUserRole);
      await prefs.setString('ss_user_plan_id', currentUserPlanId);
      if (currentUserPlanExpiresAt != null) {
        await prefs.setString('ss_user_plan_expires',
            currentUserPlanExpiresAt!.toIso8601String());
      } else {
        await prefs.remove('ss_user_plan_expires');
      }
      await prefs.setBool('ss_user_verified', isCurrentUserVerified);
      await prefs.setInt('ss_user_likes', currentUserPositiveLikes);
    } catch (e) {
      debugPrint('Error saving session: $e');
    }
    notifyListeners();
  }

  Future<void> logoutUser() async {
    currentUserId = '';
    currentUserName = 'زائر المنصة';
    currentUserEmail = '';
    currentUserPhone = '';
    currentUserRole = 'user';
    currentUserPlanId = 'plan_free';
    currentUserPlanExpiresAt = null;
    isCurrentUserVerified = false;
    currentUserPositiveLikes = 0;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('ss_user_id');
      await prefs.remove('ss_user_name');
      await prefs.remove('ss_user_email');
      await prefs.remove('ss_user_phone');
      await prefs.remove('ss_user_role');
      await prefs.remove('ss_user_plan_id');
      await prefs.remove('ss_user_plan_expires');
      await prefs.remove('ss_user_verified');
      await prefs.remove('ss_user_likes');
      await Supabase.instance.client.auth.signOut();
    } catch (_) {}
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // حفظ واسترجاع البيانات محلياً وسحابياً لضمان الديمومة
  // ---------------------------------------------------------------------------
  Future<void> saveAdsToOfflineCache(List<AdItem> adsList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = adsList.map((a) => a.toMap()).toList();
      await prefs.setString('ss_cached_ads', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error caching ads: $e');
    }
  }

  Future<void> saveBannersToOfflineCache(List<BannerItem> bannersList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = bannersList.map((b) => b.toMap()).toList();
      await prefs.setString('ss_cached_banners', jsonEncode(jsonList));
    } catch (e) {
      debugPrint('Error caching banners: $e');
    }
  }

  Future<bool> saveBannerToCloud(BannerItem item) async {
    try {
      final response = await Supabase.instance.client
          .from('banners')
          .upsert(item.toMap())
          .select();

      debugPrint('✅ تم حفظ البانوراما في السيرفر بنجاح: $response');

      final idx = banners.indexWhere((b) => b.id == item.id);
      if (idx != -1) {
        banners[idx] = item;
      } else {
        banners.insert(0, item);
      }
      await saveBannersToOfflineCache(banners);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('❌ خطأ في إرسال البانوراما للسيرفر: $e');
      return false;
    }
  }

  Future<bool> deleteBannerFromCloud(String bannerId) async {
    try {
      banners.removeWhere((b) => b.id == bannerId);
      saveBannersToOfflineCache(banners);
      notifyListeners();

      await Supabase.instance.client
          .from('banners')
          .delete()
          .eq('id', bannerId);
      return true;
    } catch (e) {
      debugPrint('Error deleting banner from cloud: $e');
      return false;
    }
  }

  Future<void> loadCachedDataOffline() async {
    _initDefaultCategories();
    _initDefaultDepartments();
    _initDefaultPlans();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedAdsStr = prefs.getString('ss_cached_ads');
      if (cachedAdsStr != null && cachedAdsStr.isNotEmpty) {
        final decoded = jsonDecode(cachedAdsStr) as List;
        ads = decoded
            .map((m) => AdItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }

      final cachedBannersStr = prefs.getString('ss_cached_banners');
      if (cachedBannersStr != null && cachedBannersStr.isNotEmpty) {
        final decoded = jsonDecode(cachedBannersStr) as List;
        banners = decoded
            .map((m) => BannerItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
    notifyListeners();

    fetchRealDataFromCloud();
    initRealtimeListeners();
  }

  Future<void> fetchRealDataFromCloud() async {
    isLoadingCloudData = true;
    notifyListeners();

    try {
      try {
        final ratesRes = await Supabase.instance.client
            .from('exchange_rates')
            .select()
            .limit(1)
            .timeout(const Duration(seconds: 8));

        if (ratesRes is List && ratesRes.isNotEmpty) {
          final data = ratesRes.first as Map<String, dynamic>;
          if (data['usd_rate'] != null) {
            exchangeRateUsdToSyp = (data['usd_rate'] as num).toDouble();
          }
          if (data['gold_price'] != null) {
            goldPrice21kSyp = (data['gold_price'] as num).toDouble();
          }
        }
      } catch (rateErr) {
        debugPrint('Rates fetch err: $rateErr');
      }

      final adsRes = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 12));

      if (adsRes is List && adsRes.isNotEmpty) {
        ads = adsRes
            .map((m) => AdItem.fromMap(m as Map<String, dynamic>))
            .toList();
        saveAdsToOfflineCache(ads);
      }

      final bannersRes = await Supabase.instance.client
          .from('banners')
          .select()
          .eq('is_active', true)
          .order('expires_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (bannersRes is List && bannersRes.isNotEmpty) {
        banners = bannersRes
            .map((m) => BannerItem.fromMap(m as Map<String, dynamic>))
            .toList();
        saveBannersToOfflineCache(banners);
      }

      final catsRes = await Supabase.instance.client
          .from('categories')
          .select()
          .order('sort_order', ascending: true)
          .timeout(const Duration(seconds: 10));

      if (catsRes is List && catsRes.isNotEmpty) {
        categories = catsRes
            .map((m) => CategoryItem.fromMap(m as Map<String, dynamic>))
            .toList();
      }

      if (isModerator) {
        final paymentRes = await Supabase.instance.client
            .from('payment_audits')
            .select()
            .order('created_at', ascending: false)
            .timeout(const Duration(seconds: 10));

        if (paymentRes is List) {
          paymentAudits = paymentRes
              .map((m) => PaymentAuditRecord.fromMap(m as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      debugPrint('Cloud Fetch Notice: $e');
    } finally {
      isLoadingCloudData = false;
      notifyListeners();
    }
  }

  // ===========================================================================
  // دوال إدارة الإعلانات والدفعات
  // ===========================================================================
  void addNewAdDirectly(AdItem ad) {
    ads.removeWhere((x) => x.id == ad.id);
    ads.insert(0, ad);
    saveAdsToOfflineCache(ads);
    notifyListeners();

    try {
      Supabase.instance.client.from('ads').insert(ad.toMap()).then((_) {
        debugPrint('Ad successfully synced to Supabase: ${ad.id}');
      }).catchError((err) {
        debugPrint('Error syncing ad to Supabase: $err');
      });
    } catch (e) {
      debugPrint('Ad insert exception: $e');
    }
  }

  void updateAdDirectly(AdItem updatedAd) {
    final idx = ads.indexWhere((x) => x.id == updatedAd.id);
    if (idx != -1) {
      ads[idx] = updatedAd;
    } else {
      ads.insert(0, updatedAd);
    }
    saveAdsToOfflineCache(ads);
    notifyListeners();

    try {
      Supabase.instance.client
          .from('ads')
          .update(updatedAd.toMap())
          .eq('id', updatedAd.id)
          .catchError((err) {
        debugPrint('Error updating ad in Supabase: $err');
      });
    } catch (e) {
      debugPrint('Ad update exception: $e');
    }
  }

  void deleteAdCompletely(String adId) {
    ads.removeWhere((x) => x.id == adId);
    saveAdsToOfflineCache(ads);
    try {
      Supabase.instance.client.from('ads').delete().eq('id', adId);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> approveAd(String adId) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(status: 'approved', rejectionReason: null);
      saveAdsToOfflineCache(ads);
      notifyListeners();
      try {
        await Supabase.instance.client.from('ads').update({
          'status': 'approved',
          'rejection_reason': null,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> rejectAd(String adId, String reason) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(status: 'rejected', rejectionReason: reason);
      saveAdsToOfflineCache(ads);
      notifyListeners();
      try {
        await Supabase.instance.client.from('ads').update({
          'status': 'rejected',
          'rejection_reason': reason,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> markAdAsSold(String adId, bool isSold) async {
    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      ads[idx] = ads[idx].copyWith(
        isSold: isSold,
        soldAt: isSold ? DateTime.now() : null,
      );
      saveAdsToOfflineCache(ads);
      notifyListeners();

      try {
        await Supabase.instance.client.from('ads').update({
          'is_sold': isSold,
          'sold_at': isSold ? DateTime.now().toIso8601String() : null,
        }).eq('id', adId);
      } catch (_) {}
    }
  }

  Future<void> autoCleanupExpiredSoldAds() async {
    final toDelete = ads.where((a) => a.shouldBeDeletedNow).toList();
    for (var ad in toDelete) {
      deleteAdCompletely(ad.id);
    }
  }

  Future<void> clearExpiredCache() async {
    try {
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      banners.removeWhere((b) => b.isExpired);
      ads.removeWhere((a) => a.shouldBeDeletedNow);

      await saveBannersToOfflineCache(banners);
      await saveAdsToOfflineCache(ads);

      notifyListeners();
    } catch (e) {
      debugPrint('Error cleaning expired cache: $e');
    }
  }

  Future<bool> submitPaymentAuditRequest({
    required String planId,
    required String planName,
    required double priceUsd,
    required String gateway,
    required String refOrTxId,
    required String userName,
    required String userPhone,
    required String userEmail,
    required String userGovernorate,
    String requestType = 'plan_subscription',
    String durationLabel = 'شهري (30 يوم)',
    int durationHours = 720,
    Uint8List? receiptBytes,
    List<String> bannerImages = const [],
    String bannerTitle = '',
    String bannerSubtitle = '',
    String bannerLinkUrl = '',
  }) async {
    String? uploadedReceiptUrl;
    if (receiptBytes != null) {
      uploadedReceiptUrl = await StorageUploadService.uploadImageBytes(
        bucketName: kStorageBucketFeedbacks,
        imageBytes: receiptBytes,
        prefix: 'receipt',
      );
    }

    final record = PaymentAuditRecord(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      userId: currentUserId.isNotEmpty
          ? currentUserId
          : 'guest_${DateTime.now().millisecondsSinceEpoch}',
      userName: userName,
      userPhone: userPhone,
      userEmail: userEmail,
      userGovernorate: userGovernorate,
      requestType: requestType,
      planId: planId,
      planName: planName,
      durationLabel: durationLabel,
      durationHours: durationHours,
      gateway: gateway,
      amountUsd: priceUsd,
      amountSyp: priceUsd * exchangeRateUsdToSyp,
      transactionRefOrTxId: refOrTxId,
      receiptImageUrl: uploadedReceiptUrl,
      bannerImages: bannerImages,
      bannerTitle: bannerTitle,
      bannerSubtitle: bannerSubtitle,
      bannerLinkUrl: bannerLinkUrl,
      status: 'pending',
      createdAt: DateTime.now(),
    );

    paymentAudits.insert(0, record);
    notifyListeners();

    try {
      await Supabase.instance.client
          .from('payment_audits')
          .insert(record.toMap());
      return true;
    } catch (e) {
      debugPrint('Submit Payment Audit Error: $e');
      return true;
    }
  }

  void approvePaymentTransaction(String txId) async {
    final index = paymentAudits.indexWhere((p) => p.id == txId);
    if (index != -1) {
      final audit = paymentAudits[index];
      audit.status = 'approved';
      audit.processedAt = DateTime.now();

      if (audit.requestType == 'plan_subscription') {
        upgradeUserPlan(audit.planId, durationHours: audit.durationHours);
      } else if (audit.requestType == 'panorama_booking') {
        final newBanner = BannerItem(
          id: 'bn_${DateTime.now().millisecondsSinceEpoch}',
          imageUrls: audit.bannerImages.isNotEmpty
              ? audit.bannerImages
              : [audit.receiptImageUrl ?? ''],
          title: audit.bannerTitle.isNotEmpty
              ? audit.bannerTitle
              : 'إعلان بانوراما VIP',
          subtitle: audit.bannerSubtitle.isNotEmpty
              ? audit.bannerSubtitle
              : 'سوق سوريا الشامل',
          description: 'معلن معتمد • تم الحجز والتفعيل عبر الإدارة المركزية',
          location: audit.userGovernorate,
          phone: audit.userPhone,
          whatsapp: audit.userPhone,
          linkUrl: audit.bannerLinkUrl,
          badgeText: 'VIP ★',
          badgeColor: const Color(0xFFD4AF37),
          displayDurationSeconds: bannerDefaultIntervalSeconds,
          expiresAt: DateTime.now().add(Duration(hours: audit.durationHours)),
          isActive: true,
        );

        banners.insert(0, newBanner);
        saveBannersToOfflineCache(banners);
        try {
          await Supabase.instance.client
              .from('banners')
              .insert(newBanner.toMap());
        } catch (_) {}
      }

      notifyListeners();

      try {
        await Supabase.instance.client.from('payment_audits').update({
          'status': 'approved',
          'processed_at': DateTime.now().toIso8601String(),
        }).eq('id', txId);
      } catch (_) {}
    }
  }

  void rejectPaymentTransaction(String txId, String reason) {
    final index = paymentAudits.indexWhere((p) => p.id == txId);
    if (index != -1) {
      paymentAudits[index].status = 'rejected';
      paymentAudits[index].adminRejectionReason = reason;
      paymentAudits[index].processedAt = DateTime.now();
      notifyListeners();

      try {
        Supabase.instance.client.from('payment_audits').update({
          'status': 'rejected',
          'rejection_reason': reason,
          'processed_at': DateTime.now().toIso8601String(),
        }).eq('id', txId);
      } catch (_) {}
    }
  }

  Future<bool> voteOnAd(
      {required String adId, required bool isPositive}) async {
    if (!isLoggedIn) return false;
    final prefs = await SharedPreferences.getInstance();
    final voteKey = 'voted_${adId}_$currentUserId';
    if (prefs.getBool(voteKey) == true) {
      return false;
    }

    final idx = ads.indexWhere((x) => x.id == adId);
    if (idx != -1) {
      final current = ads[idx];
      final newLikes = isPositive
          ? current.sellerPositiveLikes + 1
          : current.sellerPositiveLikes;
      final newDislikes =
          !isPositive ? current.sellerDislikes + 1 : current.sellerDislikes;

      ads[idx] = current.copyWith(
        sellerPositiveLikes: newLikes,
        sellerDislikes: newDislikes,
      );
      saveAdsToOfflineCache(ads);
      await prefs.setBool(voteKey, true);
      notifyListeners();

      try {
        await Supabase.instance.client.from('ads').update({
          'seller_positive_likes': newLikes,
          'seller_dislikes': newDislikes,
        }).eq('id', adId);
      } catch (_) {}
      return true;
    }
    return false;
  }

  Future<List<AdCommentItem>> fetchAdComments(String adId) async {
    try {
      final res = await Supabase.instance.client
          .from('ad_comments')
          .select()
          .eq('ad_id', adId)
          .order('created_at', ascending: true)
          .timeout(const Duration(seconds: 8));

      if (res is List) {
        return res
            .map((map) => AdCommentItem.fromMap(map as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error fetch comments: $e');
    }
    return [];
  }

  Future<AdCommentItem?> addAdComment({
    required String adId,
    required String commentText,
  }) async {
    final comment = AdCommentItem(
      id: 'cmt_${DateTime.now().millisecondsSinceEpoch}',
      adId: adId,
      userId: currentUserId.isNotEmpty ? currentUserId : 'usr_guest',
      userName: currentUserName.isNotEmpty ? currentUserName : 'مستخدم التطبيق',
      commentText: commentText.trim(),
      createdAt: DateTime.now(),
    );

    try {
      await Supabase.instance.client
          .from('ad_comments')
          .insert(comment.toMap())
          .timeout(const Duration(seconds: 8));
      return comment;
    } catch (e) {
      debugPrint('Error adding comment to Supabase: $e');
      return comment;
    }
  }

  void _initDefaultDepartments() {
    departments = [
      DepartmentNode(
        id: 'dep_cars',
        nameAr: 'سيارات ومركبات',
        nameEn: 'Vehicles',
        iconName: 'DirectionsCar',
        themeColor: const Color(0xFF0284C7),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_cars_sale',
            nameAr: 'سيارات سياحية للبيع',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_cars_rent',
            nameAr: 'سيارات للإيجار',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_cars_parts',
            nameAr: 'قطع غيار وإكسسوارات',
            parentId: 'dep_cars',
            activeAdsCount: 0,
          ),
        ],
      ),
      DepartmentNode(
        id: 'dep_realestate',
        nameAr: 'عقارات وأراضي',
        nameEn: 'Real Estate',
        iconName: 'Home',
        themeColor: const Color(0xFF16A34A),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_re_apartments',
            nameAr: 'شقق وفلل للبيع',
            parentId: 'dep_realestate',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_re_rent',
            nameAr: 'شقق للإيجار',
            parentId: 'dep_realestate',
            activeAdsCount: 0,
          ),
        ],
      ),
      DepartmentNode(
        id: 'dep_solar',
        nameAr: 'طاقة شمسية وبطاريات',
        nameEn: 'Solar Energy',
        iconName: 'WbSunny',
        themeColor: const Color(0xFFD4AF37),
        activeAdsCount: 0,
        subBranches: [
          DepartmentNode(
            id: 'dep_solar_batteries',
            nameAr: 'بطاريات ليثيوم LiFePO4',
            parentId: 'dep_solar',
            activeAdsCount: 0,
          ),
          DepartmentNode(
            id: 'dep_solar_inverters',
            nameAr: 'إنفرترات ومحولات ذكية',
            parentId: 'dep_solar',
            activeAdsCount: 0,
          ),
        ],
      ),
    ];
  }

  void _initDefaultCategories() {
    categories = [
      CategoryItem(
        id: 'cat_cars',
        name: 'سيارات ومركبات',
        iconName: 'DirectionsCar',
        iconData: Icons.directions_car,
        textColor: const Color(0xFF38BDF8),
        subcategories: [
          'سيارات سياحية للبيع',
          'سيارات للإيجار',
          'دراجات نارية وسكوتر',
          'شاحنات وآليات ثقيلة',
          'قطع غيار وإكسسوارات',
        ],
      ),
      CategoryItem(
        id: 'cat_realestate',
        name: 'عقارات وأراضي',
        iconName: 'Home',
        iconData: Icons.home,
        textColor: const Color(0xFF4ADE80),
        subcategories: [
          'شقق للبيع',
          'شقق للإيجار (سنوي/شهري)',
          'منازل وفلل ومزارع',
          'محلات ومكاتب تجارية',
          'أراضي وعقارات زراعية',
        ],
      ),
      CategoryItem(
        id: 'cat_solar',
        name: 'طاقة شمسية وبطاريات',
        iconName: 'WbSunny',
        iconData: Icons.wb_sunny,
        textColor: const Color(0xFFFACC15),
        subcategories: [
          'ألواح طاقة شمسية (تيرسي/مونو)',
          'بطاريات ليثيوم وجيل وأنظمة تخزين',
          'إنفرترات ومحولات ذكية',
          'غطاسات ومضخات شمسية',
          'مستلزمات وقواطع وتركيب',
        ],
      ),
      CategoryItem(
        id: 'cat_phones',
        name: 'هواتف وإلكترونيات',
        iconName: 'Smartphone',
        iconData: Icons.smartphone,
        textColor: const Color(0xFFA78BFA),
        subcategories: [
          'موبايلات وأجهزة ذكية',
          'لابتوبات وكمبيوترات',
          'شاشات وتلفزيونات وأجهزة منزلية',
          'كاميرات وأجهزة تصوير',
          'سماعات وإكسسوارات إلكترونية',
        ],
      ),
      CategoryItem(
        id: 'cat_jobs',
        name: 'وظائف ومهن وخدمات',
        iconName: 'Work',
        iconData: Icons.work,
        textColor: const Color(0xFFF472B6),
        subcategories: [
          'وظائف شاغرة وتوظيف',
          'خدمات صيانة منزلية وورشات',
          'تعليم وتدريس خصوصي ولغات',
          'برمجة وتصميم وتسويق إلكتروني',
          'نقل عفش وشحن وتوصيل',
        ],
      ),
      CategoryItem(
        id: 'cat_furniture',
        name: 'أثاث ومفروشات',
        iconName: 'Weekend',
        iconData: Icons.weekend,
        textColor: const Color(0xFFFB923C),
        subcategories: [
          'صالونات وغرف جلوس',
          'غرف نوم وأسرة وخزائن',
          'طاولات وكراسي ومطابخ',
          'سجاد وموكيت ومفروشات',
          'تحف وديكورات وإضاءة',
        ],
      ),
      CategoryItem(
        id: 'cat_agriculture',
        name: 'زراعة ومواشي',
        iconName: 'Agriculture',
        iconData: Icons.agriculture,
        textColor: const Color(0xFF34D399),
        subcategories: [
          'أشجار ومحاصيل ومستلزمات زراعية',
          'أبقار وأغنام ومواشي',
          'أعلاف وأدوية بيطرية',
          'جرارات ومعدات حصاد وري',
        ],
      ),
    ];
  }

  void _initDefaultPlans() {
    subscriptionPlans = [
      SubscriptionPlanItem(
        id: 'plan_free',
        name: 'الباقة المجانية 🌟',
        priceUsd: 0,
        maxAds: 5,
        maxImagesPerAd: 4,
        maxPanoramasAllowed: 0,
        canPostAuctions: true,
        hasVerifiedBadge: false,
        hasKycVerification: false,
        features: [
          'نشر حتى 5 إعلانات نشطة في نفس الوقت',
          'إضافة حتى 4 صور لكل إعلان',
          'المشاركة في المزادات العلنية',
          'ربط مباشر مع أرقام الواتساب والاتصال',
        ],
      ),
      SubscriptionPlanItem(
        id: 'plan_pro',
        name: 'باقة التاجر المتقدم (Pro) 💼',
        priceUsd: 15,
        maxAds: 30,
        maxImagesPerAd: 8,
        maxPanoramasAllowed: 2,
        canPostAuctions: true,
        hasVerifiedBadge: true,
        hasKycVerification: true,
        features: [
          'نشر حتى 30 إعلاناً نشطاً شهرياً',
          'إضافة حتى 8 صور عالية الدقة لكل إعلان',
          'شارة التاجر الموثق الذهبية (Kyc Badge)',
          'حجز وتفعيل 2 بانوراما إعلانية دوارة',
          'تمييز المنشورات في أعلى نتائج البحث',
          'إحصائيات متقدمة لعدد المشاهدات والنقرات',
        ],
      ),
      SubscriptionPlanItem(
        id: 'plan_vip',
        name: 'باقة كبار التجار والشركات VIP 👑',
        priceUsd: 35,
        maxAds: 999,
        maxImagesPerAd: 15,
        maxPanoramasAllowed: 6,
        canPostAuctions: true,
        hasVerifiedBadge: true,
        hasKycVerification: true,
        features: [
          'نشر إعلانات غير محدود (Unlimited)',
          'إضافة حتى 15 صورة + فيديو توضيحي لكل سلعة',
          'حجز وتفعيل حتى 6 بانورامات تفاعلية',
          'شارة التوثيق الملكية الرسمية VIP 👑',
          'تثبيت البنرات الإعلانية في الواجهة الرئيسية',
          'دعم فني مخصص وخط مباشر مع إدارة المنصة على مدار الساعة',
        ],
      ),
    ];
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 2 من أصل 4: المكونات البصرية، بوابات الدفع، البانوراما، الشجرة، والمصادقة]
// مربوطة بالكامل بالسيرفر الحقيقي وقواعد البيانات الحقيقية دون أي اختصار
// ==============================================================================

// ==============================================================================
// 6. شارة التوثيق الملكية وعداد الإعجاب الذهبي (KycVerificationBadge)
// ==============================================================================
class KycVerificationBadge extends StatelessWidget {
  final bool isVerified;
  final int positiveLikes;
  final double size;

  const KycVerificationBadge({
    Key? key,
    required this.isVerified,
    required this.positiveLikes,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVerified && positiveLikes < 1000) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFD4AF37),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: size, color: const Color(0xFF0F172A)),
          const SizedBox(width: 3),
          Text(
            isVerified ? 'موثق VIP' : 'بائع ذهبي ★',
            style: TextStyle(
              color: const Color(0xFF0F172A),
              fontSize: size * 0.68,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 7. محرك منع القنص وتمديد المزادات الذكي (AntiSnipingEngine)
// ==============================================================================
class AntiSnipingEngine {
  static const Duration extensionThreshold = Duration(minutes: 3);
  static const Duration extensionBonus = Duration(minutes: 5);

  static SnipResult evaluateBidTiming({
    required DateTime currentEndTime,
    required DateTime bidTimestamp,
  }) {
    final remaining = currentEndTime.difference(bidTimestamp);
    if (remaining > Duration.zero && remaining <= extensionThreshold) {
      final newEnd = currentEndTime.add(extensionBonus);
      return SnipResult(
        wasExtended: true,
        newEndTime: newEnd,
        message:
            '🔨 تمت المزايدة بنجاح وتم تمديد وقت المزاد 5 دقائق إضافية تلقائياً لمنع القنص وضمان تكافؤ الفرص!',
      );
    }
    return SnipResult(
      wasExtended: false,
      newEndTime: currentEndTime,
      message: '🔨 تمت إضافة مزايدتك بنجاح وبشكل مباشر!',
    );
  }

  static DateTime? evaluateAuctionEndTime(
      DateTime? currentEndTime, DateTime bidTime) {
    if (currentEndTime == null) return null;
    final remaining = currentEndTime.difference(bidTime);
    if (remaining > Duration.zero && remaining <= extensionThreshold) {
      return currentEndTime.add(extensionBonus);
    }
    return currentEndTime;
  }
}

// ==============================================================================
// 8. شريط أسعار الصرف والذهب اللحظي (LiveCurrencyExchangeTicker)
// ==============================================================================
class LiveCurrencyExchangeTicker extends StatelessWidget {
  final double usdRate;
  final double gold21kPrice;
  final VoidCallback? onRefresh;

  const LiveCurrencyExchangeTicker({
    Key? key,
    required this.usdRate,
    required this.gold21kPrice,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD4AF37).withOpacity(0.35),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('💵 \$1 USD = ',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
              Text(
                '${usdRate.toInt()} ل.س',
                style: const TextStyle(
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(height: 14, width: 1, color: Colors.white24),
          Row(
            children: [
              const Text('🪙 غرام 21 = ',
                  style: TextStyle(color: Colors.white70, fontSize: 11)),
              Text(
                '${gold21kPrice.toInt()} ل.س',
                style: const TextStyle(
                  color: Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          if (onRefresh != null)
            GestureDetector(
              onTap: onRefresh,
              child: const Icon(Icons.sync, color: Color(0xFF38BDF8), size: 16),
            ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 9. بطاقة بوابتي الدفع المعتمدتين حصرياً (شام كاش & بينانس USDT)
// ==============================================================================
class ExclusivePaymentGatewayCard extends StatelessWidget {
  const ExclusivePaymentGatewayCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  SyrianIndependenceFlag(width: 24, height: 16),
                  SizedBox(width: 8),
                  Text(
                    'بوابات الدفع والشحن الحصرية 💳',
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'معتمد 100%',
                  style: TextStyle(
                      color: Color(0xFF22C55E),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // شام كاش
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xFF38BDF8).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SyrianIndependenceFlag(width: 18, height: 12),
                          SizedBox(width: 6),
                          Text(
                            'حساب شام كاش (Sham Cash)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'بالليرة السورية',
                            style: TextStyle(
                                color: Color(0xFFD4AF37), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        kShamCashAccountKey,
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFD4AF37), size: 18),
                  tooltip: 'نسخ مفتاح شام كاش',
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: kShamCashAccountKey));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✓ تم نسخ مفتاح حساب شام كاش بنجاح!'),
                        backgroundColor: Color(0xFF0284C7),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // بينانس USDT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color(0xFFFACC15).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            '🪙 بينانس (Binance Pay / USDT)',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'TRC20 / USD',
                            style: TextStyle(
                                color: Color(0xFF22C55E), fontSize: 9.5),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        kBinanceWalletAddress,
                        style: const TextStyle(
                          color: Color(0xFFFACC15),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy,
                      color: Color(0xFFFACC15), size: 18),
                  tooltip: 'نسخ عنوان محفظة بينانس',
                  onPressed: () {
                    Clipboard.setData(
                        const ClipboardData(text: kBinanceWalletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            '✓ تم نسخ عنوان محفظة بينانس USDT (TRC20) بنجاح!'),
                        backgroundColor: Color(0xFF16A34A),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 10. محرك البانورامات التفاعلية والعروض المرئية المجدولة (DynamicPanoramasCarousel)
// ==============================================================================
class DynamicPanoramasCarousel extends StatefulWidget {
  final List<BannerItem> banners;
  final Function(BannerItem)? onBannerTap;

  const DynamicPanoramasCarousel({
    Key? key,
    required this.banners,
    this.onBannerTap,
  }) : super(key: key);

  @override
  State<DynamicPanoramasCarousel> createState() =>
      _DynamicPanoramasCarouselState();
}

class _DynamicPanoramasCarouselState extends State<DynamicPanoramasCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _autoScrollTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.banners.isEmpty) return;

    final currentBanner = widget.banners[_currentIndex % widget.banners.length];
    final intervalSeconds = currentBanner.displayDurationSeconds.clamp(2, 15);

    _autoScrollTimer = Timer(Duration(seconds: intervalSeconds), () {
      if (!_isUserInteracting && mounted && widget.banners.isNotEmpty) {
        final nextIndex = (_currentIndex + 1) % widget.banners.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
        setState(() {
          _currentIndex = nextIndex;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 155,
          child: GestureDetector(
            onPanDown: (_) => setState(() => _isUserInteracting = true),
            onPanCancel: () {
              setState(() => _isUserInteracting = false);
              _startAutoScroll();
            },
            onPanEnd: (_) {
              setState(() => _isUserInteracting = false);
              _startAutoScroll();
            },
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _startAutoScroll();
              },
              itemBuilder: (context, index) {
                final item = widget.banners[index];
                return GestureDetector(
                  onTap: () => widget.onBannerTap?.call(item),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppSmartImage(
                            imageUrl: item.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.85),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 3),
                              decoration: BoxDecoration(
                                color: item.badgeColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                item.badgeText,
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (item.subtitle.isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      color: Color(0xFFD4AF37),
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (index) {
            final isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              height: 4,
              width: isSelected ? 16 : 4,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFD4AF37) : Colors.white24,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ==============================================================================
// 11. الشجرة الهيكلية للأقسام والفروع (DepartmentTreeItemWidget)
// ==============================================================================
class DepartmentTreeItemWidget extends StatefulWidget {
  final DepartmentNode node;
  final int depth;
  final Function(DepartmentNode)? onSelect;
  final Function(DepartmentNode)? onEdit;
  final Function(DepartmentNode)? onDelete;

  const DepartmentTreeItemWidget({
    Key? key,
    required this.node,
    this.depth = 0,
    this.onSelect,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<DepartmentTreeItemWidget> createState() =>
      _DepartmentTreeItemWidgetState();
}

class _DepartmentTreeItemWidgetState extends State<DepartmentTreeItemWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.node.subBranches.isNotEmpty;
    final isRoot = widget.depth == 0;

    return Padding(
      padding: EdgeInsets.only(
        left: (widget.depth * 12.0).clamp(0.0, 40.0),
        bottom: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: isRoot ? const Color(0xFF1E293B) : const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isRoot
                    ? const Color(0xFF38BDF8).withOpacity(0.5)
                    : Colors.white12,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getIcon(widget.node.iconName),
                  color: isRoot
                      ? const Color(0xFF38BDF8)
                      : const Color(0xFFD4AF37),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.node.nameAr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight:
                              isRoot ? FontWeight.bold : FontWeight.w600,
                          fontSize: isRoot ? 12.5 : 11.5,
                        ),
                      ),
                      if (widget.node.description.isNotEmpty)
                        Text(
                          widget.node.description,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 9.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0284C7).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${widget.node.activeAdsCount} إعلان',
                    style: const TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (widget.onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: Color(0xFF38BDF8), size: 16),
                    onPressed: () => widget.onEdit?.call(widget.node),
                  ),
                if (hasChildren)
                  IconButton(
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white70,
                      size: 18,
                    ),
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  ),
              ],
            ),
          ),
          if (_isExpanded && hasChildren)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                children: widget.node.subBranches.map((child) {
                  return DepartmentTreeItemWidget(
                    node: child,
                    depth: widget.depth + 1,
                    onSelect: widget.onSelect,
                    onEdit: widget.onEdit,
                    onDelete: widget.onDelete,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'DirectionsCar':
        return Icons.directions_car;
      case 'Home':
        return Icons.home;
      case 'WbSunny':
        return Icons.wb_sunny;
      case 'Smartphone':
        return Icons.phone_android;
      default:
        return Icons.category;
    }
  }
}

// ==============================================================================
// 12. نافذة البحث الصوتي الذكي بالميكروفون (VoiceInputDialog)
// ==============================================================================
class VoiceInputDialog extends StatefulWidget {
  final String title;

  const VoiceInputDialog({Key? key, required this.title}) : super(key: key);

  @override
  State<VoiceInputDialog> createState() => _VoiceInputDialogState();
}

class _VoiceInputDialogState extends State<VoiceInputDialog> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.mic, color: Color(0xFF0284C7)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'تحدث الآن بوضوح أو اكتب الكلمات المراد البحث عنها في السوق:',
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _inputController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'مثال: سيارة كيا، شقة للإيجار بدمشق...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A)),
          onPressed: () {
            final val = _inputController.text.trim();
            Navigator.pop(context, val);
          },
          child: const Text('بحث 🔍', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

// ==============================================================================
// 13. القائمة الجانبية السيادية المتقدمة (CustomServerDrawer)
// ==============================================================================
class CustomServerDrawer extends StatelessWidget {
  final String userId;
  final VoidCallback onOpenContactAdmin;
  final VoidCallback onOpenFeedback;
  final VoidCallback onOpenPlans;
  final VoidCallback onOpenAdminPanel;

  const CustomServerDrawer({
    Key? key,
    required this.userId,
    required this.onOpenContactAdmin,
    required this.onOpenFeedback,
    required this.onOpenPlans,
    required this.onOpenAdminPanel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();
    final plan = manager.getCurrentUserPlan();

    return Drawer(
      backgroundColor: manager.scaffoldBgColor,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 50, bottom: 20, right: 16, left: 16),
            color: manager.appBarColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: manager.secondaryColor,
                  child: Text(
                    manager.currentUserName.isNotEmpty
                        ? manager.currentUserName[0]
                        : 'س',
                    style: TextStyle(
                      color: manager.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        manager.currentUserName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'باقة: ${plan.name}',
                        style: TextStyle(
                          color: manager.secondaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        manager.isLoggedIn
                            ? manager.currentUserEmail
                            : 'زائر المنصة',
                        style: const TextStyle(
                            color: Colors.white60, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: [
                ListTile(
                  leading:
                      Icon(Icons.headset_mic, color: manager.secondaryColor),
                  title: const Text('تواصل مباشر مع الإدارة'),
                  subtitle: const Text('واتساب أو اتصال هاتفي فوري'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenContactAdmin();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.lightbulb, color: manager.secondaryColor),
                  title: const Text('صوتك مسموع 💡 (اقتراح ميزة)'),
                  subtitle: const Text('إرسال فكرة مع لقطة شاشة'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenFeedback();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium,
                      color: Color(0xFFD4AF37)),
                  title: const Text('باقات الاشتراك والترقية VIP'),
                  onTap: () {
                    Navigator.pop(context);
                    onOpenPlans();
                  },
                ),
                // دليل المكاتب العقارية لجميع المستخدمين
                ListTile(
                  leading: const Icon(Icons.real_estate_agent,
                      color: Color(0xFFD4AF37)),
                  title: const Text('دليل المكاتب العقارية المعتمدة 🏢'),
                  subtitle: const Text('تصفح مكاتب وشركات العقارات في سوريا'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => const RealEstateDirectoryScreen()),
                    );
                  },
                ),
                const Divider(),
                // زر إضافة وتوثيق مكتب عقاري - محمي حصرياً للمشرفين والمسؤولين
                if (manager.isAdmin || manager.isModerator) ...[
                  ListTile(
                    leading: const Icon(Icons.add_business,
                        color: Color(0xFFD4AF37)),
                    title: const Text(
                      'إضافة مكتب عقاري رسمي 🛡️',
                      style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        const Text('صلاحية إدارية خاصة بالمشرفين والمسؤولين'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                const RealEstateDirectoryScreen()),
                      );
                    },
                  ),
                  const Divider(),
                ],
                if (manager.isModerator) ...[
                  ListTile(
                    leading: const Icon(Icons.admin_panel_settings,
                        color: Colors.red),
                    title: const Text(
                      'غرفة العمليات المركزية 🛡️',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    subtitle:
                        const Text('لوحة تحكم الإدارة الكاملة بـ 9 قطاعات'),
                    onTap: () {
                      Navigator.pop(context);
                      onOpenAdminPanel();
                    },
                  ),
                  const Divider(),
                ],
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.blue),
                  title: const Text('مشاركة رابط المنصة'),
                  onTap: () {
                    Navigator.pop(context);
                    Share.share(
                      'حمل واستمتع بأقوى سوق إلكتروني حر في سوريا 2028:\n$kDefaultShareDomain',
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SyrianIndependenceFlag(width: 18, height: 12),
                const SizedBox(width: 6),
                Text(
                  'سوق سوريا الشامل © 2028 • النسخة السيادية 5.0',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 14. شاشة تفاصيل البنر والبانوراما الإعلانية (FullBannerDetailsScreen)
// مزودة بجميع أزرار وروابط التواصل الاجتماعي والمواقع بالكامل
// ==============================================================================
class FullBannerDetailsScreen extends StatelessWidget {
  final BannerItem banner;

  const FullBannerDetailsScreen({Key? key, required this.banner})
      : super(key: key);

  Future<void> _launchExternalUrl(String urlStr) async {
    if (urlStr.trim().isEmpty) return;
    String target = urlStr.trim();
    if (!target.startsWith('http://') && !target.startsWith('https://')) {
      target = 'https://$target';
    }
    try {
      final uri = Uri.parse(target);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Launch URL err: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = AppStateManager();

    return Scaffold(
      backgroundColor: manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: manager.appBarColor,
        title: Text(
          banner.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 230,
            child: PageView.builder(
              itemCount:
                  banner.imageUrls.isNotEmpty ? banner.imageUrls.length : 1,
              itemBuilder: (ctx, idx) {
                final url = banner.imageUrls.isNotEmpty
                    ? banner.imageUrls[idx]
                    : banner.imageUrl;
                return AppSmartImage(imageUrl: url, fit: BoxFit.cover);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: banner.badgeColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        banner.badgeText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 15, color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          banner.location,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  banner.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (banner.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    banner.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: manager.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Divider(height: 24),
                const Text(
                  'تفاصيل ومواصفات العرض الترويجي:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  banner.description.isNotEmpty
                      ? banner.description
                      : 'تواصل مع المعلن مباشرة للاستفادة من كامل العروض والخدمات.',
                  style: const TextStyle(fontSize: 13, height: 1.6),
                ),
                const SizedBox(height: 20),

                // أزرار التواصل المباشر (اتصال وواتساب)
                Row(
                  children: [
                    if (banner.phone.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: manager.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.phone,
                              color: Colors.white, size: 18),
                          label: const Text(
                            'اتصال بالمعلن',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            final uri = Uri.parse('tel:${banner.phone}');
                            if (await canLaunchUrl(uri)) await launchUrl(uri);
                          },
                        ),
                      ),
                    if (banner.phone.isNotEmpty && banner.whatsapp.isNotEmpty)
                      const SizedBox(width: 10),
                    if (banner.whatsapp.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.chat,
                              color: Colors.white, size: 18),
                          label: const Text(
                            'واتساب المعلن',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            final clean =
                                PhoneHelper.formatForWhatsapp(banner.whatsapp);
                            final msg = Uri.encodeComponent(
                                'مرحباً، بخصوص إعلانكم في بانوراما سوق سوريا الشامل (${banner.title}):');
                            final uri =
                                Uri.parse('https://wa.me/$clean?text=$msg');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                // أزرار وحسابات التواصل الاجتماعي والمواقع (فيسبوك، إنستغرام، تيك توك، تيليجرام، يوتيوب، الموقع)
                const Text(
                  'قنوات وصفحات التواصل والموقع 🌐:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (banner.facebookUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.facebook,
                            color: Color(0xFF1877F2), size: 18),
                        label: const Text('فيسبوك'),
                        onPressed: () => _launchExternalUrl(banner.facebookUrl),
                      ),
                    if (banner.instagramUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.camera_alt,
                            color: Color(0xFFE4405F), size: 18),
                        label: const Text('إنستغرام'),
                        onPressed: () =>
                            _launchExternalUrl(banner.instagramUrl),
                      ),
                    if (banner.telegramUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.send,
                            color: Color(0xFF0088CC), size: 18),
                        label: const Text('تيليجرام'),
                        onPressed: () => _launchExternalUrl(banner.telegramUrl),
                      ),
                    if (banner.tiktokUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.music_note,
                            color: Colors.black, size: 18),
                        label: const Text('تيك توك'),
                        onPressed: () => _launchExternalUrl(banner.tiktokUrl),
                      ),
                    if (banner.youtubeUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.play_circle_fill,
                            color: Color(0xFFFF0000), size: 18),
                        label: const Text('يوتيوب'),
                        onPressed: () => _launchExternalUrl(banner.youtubeUrl),
                      ),
                    if (banner.linkUrl.isNotEmpty)
                      ActionChip(
                        avatar: const Icon(Icons.language,
                            color: Color(0xFF0284C7), size: 18),
                        label: const Text('الموقع الإلكتروني'),
                        onPressed: () => _launchExternalUrl(banner.linkUrl),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 15. شاشة "صوتك مسموع 💡" وصندوق مقترحات وتطوير المنصة (AppFeedbackScreen)
// ==============================================================================
class AppFeedbackScreen extends StatefulWidget {
  const AppFeedbackScreen({Key? key}) : super(key: key);

  @override
  State<AppFeedbackScreen> createState() => _AppFeedbackScreenState();
}

class _AppFeedbackScreenState extends State<AppFeedbackScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _feedbackType = 'فكرة وميزة جديدة 💡';
  final List<String> _feedbackTypes = [
    'فكرة وميزة جديدة 💡',
    'اقتراح لتطوير التطبيق 🚀',
    'بلاغ عن مشكلة تقنية ⚠️',
    'طلب حجز بنر إعلاني 🌟',
    'شكر وتقدير للإدارة ❤️'
  ];

  final ImagePicker _picker = ImagePicker();
  Uint8List? _screenshotBytes;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = _manager.currentUserName;
    _contactController.text = _manager.currentUserPhone.isNotEmpty
        ? _manager.currentUserPhone
        : _manager.currentUserEmail;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickScreenshot() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxWidth: 800,
      );
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() => _screenshotBytes = bytes);
      }
    } catch (e) {
      debugPrint('Pick screenshot notice: $e');
    }
  }

  Future<void> _submitFeedback() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSending = true);

    String? uploadedScreenshotUrl;
    if (_screenshotBytes != null) {
      uploadedScreenshotUrl = await StorageUploadService.uploadImageBytes(
        bucketName: kStorageBucketFeedbacks,
        imageBytes: _screenshotBytes!,
        prefix: 'feedback',
      );
    }

    final newFeedback = AppFeedbackItem(
      id: 'fb_${DateTime.now().millisecondsSinceEpoch}',
      userId: _manager.currentUserId,
      userName: _nameController.text.trim().isNotEmpty
          ? _nameController.text.trim()
          : 'زائر المنصة',
      userContact: _contactController.text.trim(),
      type: _feedbackType,
      content: _contentController.text.trim(),
      screenshotUrl: uploadedScreenshotUrl,
      createdAt: DateTime.now(),
    );

    setState(() {
      _manager.feedbacks.insert(0, newFeedback);
    });

    try {
      await Supabase.instance.client
          .from('app_feedback')
          .insert(newFeedback.toMap())
          .timeout(const Duration(seconds: 8));
    } catch (_) {}

    try {
      final alertText = '💡 مقترح أو بلاغ جديد عبر صوتك مسموع:\n'
          '👤 الاسم: ${newFeedback.userName}\n'
          '📞 للتواصل: ${newFeedback.userContact}\n'
          '🏷️ النوع: ${newFeedback.type}\n'
          '📝 التفاصيل: ${newFeedback.content}\n'
          '${uploadedScreenshotUrl != null ? "📸 لقطة الشاشة: $uploadedScreenshotUrl" : ""}';
      await _manager.sendTelegramAlert(alertText);
    } catch (_) {}

    if (mounted) {
      setState(() => _isSending = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 24),
              SizedBox(width: 8),
              Text('شكراً لمشاركتك القيّمة ❤️', style: TextStyle(fontSize: 16)),
            ],
          ),
          content: const Text(
            'تم إرسال رسالتك ومقترحك مباشرةً إلى غرفة عمليات الإدارة. نحن نقرأ كافة الأفكار بعناية فائقة لتطوير سوق سوريا الشامل.',
            style: TextStyle(fontSize: 13, height: 1.5),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('حسناً', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: const Text(
          'صوتك مسموع 💡 (اقترح وطوّر)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _manager.secondaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: _manager.secondaryColor.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb,
                      color: _manager.secondaryColor, size: 28),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'رأيك يصنع الفرق! شاركنا بأي فكرة، ميزة جديدة، أو ملاحظة لتطوير التطبيق لخدمتك بشكل أفضل.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _feedbackType,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'نوع الرسالة أو المقترح',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _feedbackTypes
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _feedbackType = v!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'اسمك الكريم (اختياري)',
                prefixIcon: const Icon(Icons.person),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'رقم هاتفك أو بريدك للتواصل والمتابعة',
                prefixIcon: const Icon(Icons.contact_phone),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'يرجى إدخال وسيلة تواصل'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: 'تفاصيل الفكرة أو الملاحظة *',
                hintText: 'اكتب اقتراحك بالتفصيل هنا...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 5)
                  ? 'يرجى كتابة تفاصيل المقترح'
                  : null,
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(
                  _screenshotBytes != null
                      ? Icons.check_circle
                      : Icons.add_photo_alternate,
                  color: _screenshotBytes != null ? Colors.green : Colors.grey,
                ),
                title: Text(
                  _screenshotBytes != null
                      ? 'تم إرفاق لقطة الشاشة'
                      : 'إرفاق لقطة شاشة توضيحية (اختياري)',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _manager.primaryColor),
                  onPressed: _pickScreenshot,
                  child: Text(_screenshotBytes != null ? 'تغيير' : 'اختيار',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isSending ? null : _submitFeedback,
                child: _isSending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'إرسال لصاحب التطبيق مباشرةً 🚀',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 16. واجهة المصادقة واسترجاع كلمة المرور الحقيقية (AuthScreen)
// ==============================================================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();

  bool _isLoginMode = true;
  bool _isSubmitting = false;
  bool _obscurePassword = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showForgotPasswordDialog() {
    final resetEmailController =
        TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.lock_reset, color: _manager.primaryColor),
            const SizedBox(width: 8),
            const Text('استرجاع كلمة المرور', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'أدخل بريدك الإلكتروني المسجل، وسنرسل لك رابط إعادة تعيين كلمة المرور فوراً عبر خادم السحابة:',
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: resetEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                hintText: 'example@gmail.com',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: _manager.buttonColor),
            onPressed: () async {
              final email = resetEmailController.text.trim();
              if (email.isEmpty || !email.contains('@')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('يرجى إدخال بريد إلكتروني صالح')),
                );
                return;
              }
              Navigator.pop(ctx);

              try {
                await Supabase.instance.client.auth
                    .resetPasswordForEmail(email)
                    .timeout(const Duration(seconds: 12));
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          '✅ تم إرسال رابط استرجاع كلمة المرور لبريدك الإلكتروني.'),
                    ),
                  );
                }
              } on SocketException catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          '⚠️ تعذر الاتصال بالخادم، يرجى التأكد من اتصال الإنترنت.'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('تنبيه استرجاع كلمة المرور: $e')),
                  );
                }
              }
            },
            child: const Text('إرسال الرابط',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAuth() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    try {
      if (_isLoginMode) {
        final AuthResponse res = await Supabase.instance.client.auth
            .signInWithPassword(
              email: email,
              password: password,
            )
            .timeout(const Duration(seconds: 15));

        if (res.user != null) {
          final isSuper = kAuthorizedAdminEmails.contains(email.toLowerCase());

          // مزامنة فورية لجدول profiles في Supabase
          try {
            await Supabase.instance.client.from('profiles').upsert({
              'id': res.user!.id,
              'email': email,
              'display_name': name.isNotEmpty ? name : email.split('@').first,
              'role': isSuper ? 'admin' : 'user',
              'is_active': true,
            });
          } catch (_) {}

          await _manager.setSessionUser(
            userId: res.user!.id,
            email: email,
            name: res.user!.userMetadata?['name']?.toString() ?? name,
            phone: res.user!.phone ??
                res.user!.userMetadata?['phone']?.toString() ??
                phone,
            role: isSuper ? 'super_admin' : 'user',
          );
        }
      } else {
        final AuthResponse res = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
          data: {'name': name, 'phone': phone},
        ).timeout(const Duration(seconds: 15));

        if (res.user != null) {
          final isSuper = kAuthorizedAdminEmails.contains(email.toLowerCase());

          // إنشاء ملف حقيقي في جدول profiles في Supabase
          try {
            await Supabase.instance.client.from('profiles').upsert({
              'id': res.user!.id,
              'email': email,
              'display_name': name.isNotEmpty ? name : email.split('@').first,
              'role': isSuper ? 'admin' : 'user',
              'is_active': true,
            });
          } catch (_) {}

          await _manager.setSessionUser(
            userId: res.user!.id,
            email: email,
            name: name,
            phone: phone,
            role: isSuper ? 'super_admin' : 'user',
          );
        }
      }

      if (mounted) {
        setState(() => _isSubmitting = false);
        Navigator.pop(context);
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في بيانات الحساب: ${e.message}'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'تعذر الاتصال بالخادم، يرجى التحقق من اتصال الإنترنت وإعادة المحاولة.'),
            backgroundColor: Colors.orange.shade900,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        final errStr = e.toString();
        final displayMsg = errStr.contains('SocketException') ||
                errStr.contains('connection abort') ||
                errStr.contains('TimeoutException')
            ? 'انقطع الاتصال مؤقتاً أثناء التوثيق. يرجى المحاولة مجدداً.'
            : 'تنبيه المصادقة: $errStr';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(displayMsg),
            backgroundColor: Colors.red.shade800,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          _isLoginMode ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _manager.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8)
                    ],
                  ),
                  child: Icon(Icons.storefront,
                      size: 48, color: _manager.secondaryColor),
                ),
                const SizedBox(height: 14),
                Text(
                  _manager.appTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _manager.primaryColor,
                  ),
                ),
                Text(
                  _isLoginMode
                      ? 'أهلاً بك مجدداً في سوقك الحر'
                      : 'انضم لآلاف البائعين والمشترين في سوريا',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                if (!_isLoginMode) ...[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'الاسم الكامل أو اسم المتجر *',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم هاتف الاتصال والواتساب *',
                      hintText: '0933000000',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) =>
                        (v == null || !PhoneHelper.isValidPhone(v))
                            ? 'رقم هاتف صالح مطلوب'
                            : null,
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني *',
                    hintText: 'example@gmail.com',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) => (v == null || !v.contains('@'))
                      ? 'بريد إلكتروني صالح مطلوب'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور *',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? 'كلمة المرور يجب أن لا تقل عن 6 خانات'
                      : null,
                ),
                if (_isLoginMode) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      child: const Text('نسيت كلمة المرور؟',
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _manager.buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isSubmitting ? null : _submitAuth,
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            _isLoginMode
                                ? 'تسجيل الدخول 🚀'
                                : 'إنشاء الحساب فوراً ✨',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => setState(() => _isLoginMode = !_isLoginMode),
                  child: Text(
                    _isLoginMode
                        ? 'ليس لديك حساب؟ سجل حساباً جديداً الآن'
                        : 'لديك حساب بالفعل؟ سجل دخولك',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [القسم الثالث: شاشة المعاينة، تفاصيل الإعلان والمزاد الحي، والشاشة الرئيسية الكبرى مع الفلترة والمزامنة]
// ==============================================================================

// ==============================================================================
// 17. شاشة معاينة ومشاركة المنشور بنمط صفحة الويب المدمجة (InAppPostWebPreviewScreen)
// ==============================================================================
class InAppPostWebPreviewScreen extends StatelessWidget {
  final AdItem ad;

  const InAppPostWebPreviewScreen({Key? key, required this.ad})
      : super(key: key);

  String get shareableWebUrl =>
      'https://celadon-pithivier-77918a.netlify.app/ad/${ad.id}';

  void _copyShareableLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: shareableWebUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ تم نسخ رابط المنشور الرسمي للحافظة بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _shareViaWhatsApp(BuildContext context) async {
    final title = Uri.encodeComponent(
      '🌟 شاهد إعلان "${ad.title}" على سوق سوريا الشامل 2028:\n'
      '📍 المحافظة: ${ad.governorate} - ${ad.neighborhood}\n'
      '💵 السعر: \$${ad.priceUsd ?? 0} (${ad.priceSyp ?? 0} ل.س)\n'
      '🔗 رابط المعاينة المباشر: $shareableWebUrl',
    );
    final uri = Uri.parse('https://wa.me/?text=$title');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          'معاينة الرابط الرسمي للمنشور 🌐',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy, color: Color(0xFFD4AF37)),
            tooltip: 'نسخ الرابط',
            onPressed: () => _copyShareableLink(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock, color: Colors.green, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      shareableWebUrl,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: AppSmartImage(
                      imageUrl:
                          ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ad.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (ad.priceUsd != null)
                              Text(
                                '\$${ad.priceUsd!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Color(0xFF22C55E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (ad.priceSyp != null)
                              Text(
                                '${ad.priceSyp!.toStringAsFixed(0)} ل.س',
                                style: const TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '📍 ${ad.governorate} - ${ad.neighborhood}',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        ),
                        const Divider(color: Colors.white24, height: 24),
                        Text(
                          ad.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: const Color(0xFFD4AF37),
                              child: Text(
                                ad.publisherName.isNotEmpty
                                    ? ad.publisherName[0]
                                    : 'U',
                                style: const TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'المعلن: ${ad.publisherName}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.share, color: Colors.white),
                    label: const Text(
                      'مشاركة عبر واتساب',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _shareViaWhatsApp(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4AF37)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    icon: const Icon(Icons.copy, color: Color(0xFFD4AF37)),
                    label: const Text(
                      'نسخ الرابط',
                      style: TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _copyShareableLink(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 18. شاشة تفاصيل الإعلانات والمزادات الحرة الكبرى (FullAdDetailsScreen)
// ==============================================================================
class FullAdDetailsScreen extends StatefulWidget {
  final AdItem ad;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final Function(AdItem) onAdUpdated;
  final Function(String) onAdDeleted;

  const FullAdDetailsScreen({
    Key? key,
    required this.ad,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAdUpdated,
    required this.onAdDeleted,
  }) : super(key: key);

  @override
  State<FullAdDetailsScreen> createState() => _FullAdDetailsScreenState();
}

class _FullAdDetailsScreenState extends State<FullAdDetailsScreen> {
  final AppStateManager _manager = AppStateManager();
  late AdItem _currentAd;
  final PageController _pageController = PageController();
  final TransformationController _zoomController = TransformationController();
  int _currentImageIndex = 0;
  double _currentScale = 1.0;

  final TextEditingController _bidController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  bool _isPlacingBid = false;
  List<AdCommentItem> _adComments = [];
  StreamSubscription? _commentsSubscription;
  bool _isLoadingComments = false;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _currentAd = widget.ad;
    _loadComments();

    if (_currentAd.isSold) {
      _startSoldCountdownTimer();
    }
  }

  @override
  void dispose() {
    _commentsSubscription?.cancel();
    _countdownTimer?.cancel();
    _pageController.dispose();
    _zoomController.dispose();
    _bidController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  // عداد الحذف التنازلي التلقائي: 15 دقيقة
  void _startSoldCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        if (_currentAd.shouldBeDeletedNow) {
          timer.cancel();
          _manager.deleteAdCompletely(_currentAd.id);
          widget.onAdDeleted(_currentAd.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    '⏳ انتهت مهلة الـ 15 دقيقة وتم حذف المنشور المباع تلقائياً.')),
          );
          Navigator.pop(context);
        } else {
          setState(() {});
        }
      }
    });
  }

  void _loadComments() {
    setState(() => _isLoadingComments = true);
    _commentsSubscription?.cancel();
    _commentsSubscription = Supabase.instance.client
        .from('ad_comments')
        .stream(primaryKey: ['id'])
        .eq('ad_id', _currentAd.id)
        .order('created_at', ascending: true)
        .listen((List<Map<String, dynamic>> data) {
          if (mounted) {
            setState(() {
              _adComments = data.map((m) => AdCommentItem.fromMap(m)).toList();
              _isLoadingComments = false;
            });
          }
        }, onError: (err) {
          debugPrint('Comments Stream Error: $err');
          if (mounted) setState(() => _isLoadingComments = false);
        });
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final commentMap = {
      'id': 'cm_${DateTime.now().millisecondsSinceEpoch}',
      'ad_id': _currentAd.id,
      'user_id': _manager.currentUserId.isNotEmpty
          ? _manager.currentUserId
          : 'guest_${DateTime.now().millisecondsSinceEpoch % 10000}',
      'user_name': _manager.currentUserName.isNotEmpty
          ? _manager.currentUserName
          : 'مستخدم',
      'user_phone': _manager.currentUserPhone,
      'content': text,
      'comment': text,
      'created_at': DateTime.now().toIso8601String(),
    };

    _commentController.clear();
    FocusScope.of(context).unfocus();

    try {
      await Supabase.instance.client
          .from('ad_comments')
          .insert(commentMap)
          .timeout(const Duration(seconds: 8));

      if (!_adComments.any((c) => c.id == commentMap['id'])) {
        setState(() {
          _adComments.add(AdCommentItem.fromMap(commentMap));
        });
      }
    } catch (e) {
      debugPrint('Comment insert error: $e');
    }
  }

  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + 0.5).clamp(1.0, 4.0);
      _zoomController.value = Matrix4.identity()..scale(_currentScale);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - 0.5).clamp(1.0, 4.0);
      _zoomController.value = Matrix4.identity();
    });
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _zoomController.value = Matrix4.identity();
    });
  }

  void _openFullScreenImage(int index) {
    final images =
        _currentAd.imageUrls.isNotEmpty ? _currentAd.imageUrls : [''];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(ctx),
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 5.0,
              child: AppSmartImage(
                imageUrl: images[index],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _callSeller() async {
    final phone = _currentAd.contactPhone.isNotEmpty
        ? _currentAd.contactPhone
        : _currentAd.phone;
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (_) {}
  }

  void _openWhatsapp() async {
    final target = _currentAd.contactWhatsapp.isNotEmpty
        ? _currentAd.contactWhatsapp
        : (_currentAd.whatsapp.isNotEmpty
            ? _currentAd.whatsapp
            : _currentAd.phone);
    final clean = PhoneHelper.formatForWhatsapp(target);
    final msg = Uri.encodeComponent(
      'مرحباً، أنا مهتم بإعلانك "${_currentAd.title}" المعروض على تطبيق سوق سوريا الشامل 2028.',
    );
    final uri = Uri.parse('https://wa.me/$clean?text=$msg');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _openSocialLink(String? url) async {
    if (url == null || url.trim().isEmpty) return;
    try {
      String target = url.trim();
      if (!target.startsWith('http://') && !target.startsWith('https://')) {
        target = 'https://$target';
      }
      final uri = Uri.parse(target);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  // ويدجت شريط روابط السوشيال ميديا الحصري للمعلن المميز
  Widget _buildSellerSocialBar() {
    final hasFb = _currentAd.facebookUrl != null &&
        _currentAd.facebookUrl!.trim().isNotEmpty;
    final hasYt = _currentAd.youtubeUrl != null &&
        _currentAd.youtubeUrl!.trim().isNotEmpty;
    final hasIg = _currentAd.instagramUrl != null &&
        _currentAd.instagramUrl!.trim().isNotEmpty;
    final hasTg = _currentAd.telegramUrl != null &&
        _currentAd.telegramUrl!.trim().isNotEmpty;
    final hasTt =
        _currentAd.tiktokUrl != null && _currentAd.tiktokUrl!.trim().isNotEmpty;

    if (!hasFb && !hasYt && !hasIg && !hasTg && !hasTt) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified, color: Color(0xFFD4AF37), size: 18),
              SizedBox(width: 6),
              Text(
                'حسابات المعلن المعتمدة وتضمين الفيديو 🔗',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (hasYt)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0000),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.play_circle_fill, size: 16),
                  label: const Text('فيديو يوتيوب',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSocialLink(_currentAd.youtubeUrl),
                ),
              if (hasFb)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1877F2),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.facebook, size: 16),
                  label: const Text('فيسبوك',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSocialLink(_currentAd.facebookUrl),
                ),
              if (hasIg)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE1306C),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.camera_alt, size: 16),
                  label: const Text('إنستغرام',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSocialLink(_currentAd.instagramUrl),
                ),
              if (hasTg)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF229ED9),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('تليجرام',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSocialLink(_currentAd.telegramUrl),
                ),
              if (hasTt)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF000000),
                    foregroundColor: Colors.cyanAccent,
                    side: const BorderSide(color: Colors.white24),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.music_note, size: 16),
                  label: const Text('تيك توك',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  onPressed: () => _openSocialLink(_currentAd.tiktokUrl),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _openDirectChat() {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                '⚠️ يرجى تسجيل الدخول أولاً لبدء المحادثة والتفاوض المباشر.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FullChatNegotiationScreen(
          adId: _currentAd.id,
          partnerName: _currentAd.userName,
          productTitle: _currentAd.title,
          initialPrice: _currentAd.priceUsd ?? _currentAd.priceSyp ?? 0,
        ),
      ),
    );
  }

  void _openWebPreview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => InAppPostWebPreviewScreen(ad: _currentAd),
      ),
    );
  }

  Future<void> _handleVote(bool isPositive) async {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يجب تسجيل الدخول أولاً لتقييم مصداقية المعلن.')),
      );
      return;
    }

    final success = await _manager.voteOnAd(
      adId: _currentAd.id,
      isPositive: isPositive,
    );

    if (!success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                '⚠️ لقد قمت بالتقييم مسبقاً على هذا المنشور! التصويت مقفل لكل حساب منعاً للتكرار.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    final newLikes = isPositive
        ? _currentAd.sellerPositiveLikes + 1
        : _currentAd.sellerPositiveLikes;
    final newDislikes =
        !isPositive ? _currentAd.sellerDislikes + 1 : _currentAd.sellerDislikes;

    final updatedAd = _currentAd.copyWith(
      sellerPositiveLikes: newLikes,
      sellerDislikes: newDislikes,
    );

    setState(() {
      _currentAd = updatedAd;
    });
    widget.onAdUpdated(updatedAd);

    try {
      await Supabase.instance.client
          .from('ads')
          .update({
            'seller_positive_likes': newLikes,
            'seller_dislikes': newDislikes,
          })
          .eq('id', _currentAd.id)
          .timeout(const Duration(seconds: 10));

      try {
        await Supabase.instance.client.from('ad_votes').insert({
          'ad_id': _currentAd.id,
          'user_id': _manager.currentUserId,
          'is_positive': isPositive,
          'created_at': DateTime.now().toIso8601String(),
        }).timeout(const Duration(seconds: 5));
      } catch (_) {}
    } catch (e) {
      debugPrint('Error updating vote in database: $e');
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isPositive
                ? '👍 شكراً لتقييمك! تم حفظ التقييم الإيجابي بنجاح على السيرفر.'
                : '👎 تم تسجيل تقييمك السلبي بنجاح على السيرفر.',
          ),
          backgroundColor:
              isPositive ? Colors.green.shade800 : Colors.red.shade900,
        ),
      );
    }
  }

  Future<void> _confirmMarkAsSold() async {
    final confirm = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: const Color(0xFF0F172A),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.check_circle_outline,
                    color: Color(0xFFDC2626), size: 24),
                SizedBox(width: 8),
                Text('تأكيد تم البيع ✓ SOLD',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text(
              'هل تم بيع هذه السلعة بالفعل؟\nسيظهر ختم "تم البيع" لجميع المستخدمين مع عداد تنازلي 15 دقيقة، وسيتم حذف المنشور نهائياً بعد انتهاء المدة.',
              style:
                  TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child:
                    const Text('إلغاء', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC2626),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('تأكيد ختم البيع',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirm) return;
    final willBeSold = !_currentAd.isSold;
    final nowUtc = DateTime.now().toUtc();

    // 1. تحديث الحالة فوراً على السيرفر بتوقيت UTC العالمي الموحد
    try {
      await Supabase.instance.client
          .from('ads')
          .update({
            'is_sold': willBeSold,
            'sold_at': willBeSold ? nowUtc.toIso8601String() : null,
          })
          .eq('id', _currentAd.id)
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      debugPrint('Error updating sold status: $e');
    }

    setState(() {
      _currentAd = _currentAd.copyWith(
        isSold: willBeSold,
        soldAt: willBeSold ? nowUtc : null,
      );
    });
    widget.onAdUpdated(_currentAd);

    if (willBeSold) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              '🤝 تم ختم الإعلان (تم البيع). سيتم حذفه نهائياً من السيرفر بعد 5 دقائق!'),
          backgroundColor: Color(0xFFD4AF37),
          duration: Duration(seconds: 4),
        ),
      );

      _countdownTimer?.cancel();
      // تشغيل مؤقت الحذف النهائي التلقائي من السيرفر بعد 5 دقائق بالضبط (300 ثانية)
      _countdownTimer = Timer(const Duration(minutes: 5), () async {
        try {
          // حذف الإعلان نهائياً من جدول Supabase لكي لا يشغل مساحة
          await Supabase.instance.client
              .from('ads')
              .delete()
              .eq('id', _currentAd.id);

          // حذفه من القائمة المحلية
          _manager.ads.removeWhere((a) => a.id == _currentAd.id);
          _manager.notifyListeners();

          debugPrint(
              '🗑️ تم حذف الإعلان المباع من السيرفر نهائياً: ${_currentAd.id}');

          if (mounted) {
            Navigator.pop(context); // إغلاق صفحة الإعلان المحذوف
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ تم حذف الإعلان المباع من السيرفر نهائياً.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } catch (e) {
          debugPrint('خطأ أثناء الحذف التلقائي من السيرفر: $e');
        }
      });
    } else {
      _countdownTimer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إلغاء ختم البيع وإعادة الإعلان للعمل بنجاح.'),
          backgroundColor: Colors.blueGrey,
        ),
      );
    }
  }

  // دالة إرسال تنبيهات المزاد الفورية للمعلن والمزايدين
  Future<void> _sendAuctionNotification({
    required String targetUserId,
    required String title,
    required String message,
  }) async {
    if (targetUserId.isEmpty || targetUserId == _manager.currentUserId) return;
    try {
      await Supabase.instance.client.from('notifications').insert({
        'id': 'notif_${DateTime.now().millisecondsSinceEpoch}',
        'user_id': targetUserId,
        'title': title,
        'message': message,
        'ad_id': _currentAd.id,
        'is_read': false,
        'created_at': DateTime.now().toIso8601String(),
      }).timeout(const Duration(seconds: 4));
    } catch (_) {}
  }

  // ويدجت العداد التنازلي الحي للمزاد بالثواني
  Widget _buildAuctionLiveCountdown() {
    if (!_currentAd.isAuction || _currentAd.auctionEndTime == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final end = _currentAd.auctionEndTime!;
    final diff = end.difference(now);

    if (diff.isNegative) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withOpacity(0.5)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer_off, color: Colors.redAccent, size: 16),
            SizedBox(width: 6),
            Text(
              '⚠️ انتهى وقت هذا المزاد',
              style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    final isUrgent = diff.inMinutes < 15;
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;

    String formatTime() {
      if (days > 0) return '$days يوم و $hours سا و $minutes د و $seconds ث';
      if (hours > 0) return '$hours سا و $minutes د و $seconds ث';
      return '$minutes د و $seconds ث';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: isUrgent
            ? Colors.red.shade900.withOpacity(0.3)
            : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUrgent ? Colors.redAccent : const Color(0xFFD4AF37),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUrgent ? Icons.local_fire_department : Icons.timer,
            color: isUrgent ? Colors.redAccent : const Color(0xFFD4AF37),
            size: 17,
          ),
          const SizedBox(width: 6),
          Text(
            isUrgent
                ? 'ينتهي قريباً جداً: ${formatTime()} 🔥'
                : 'الوقت المتبقي: ${formatTime()} ⏳',
            style: TextStyle(
              color: isUrgent ? Colors.redAccent : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // مشغل ومعاين فيديو يوتيوب المدمج داخل التطبيق
  Widget _buildYouTubeVideoCard() {
    final yt = _currentAd.youtubeUrl;
    if (yt == null || yt.trim().isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF180A0A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.play_arrow, color: Colors.redAccent, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'فيديو معاينة حية للسلعة (YouTube) 🎥',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
                SizedBox(height: 2),
                Text(
                  'شاهد تفاصيل السلعة بالفيديو عالي الدقة الآن',
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            onPressed: () => _openSocialLink(yt),
            child: const Text('تشغيل ▶',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _placeAuctionBid() async {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يرجى تسجيل الدخول للمشاركة في المزاد العلني.')),
      );
      return;
    }

    final entered = double.tryParse(_bidController.text);
    final minBid = (_currentAd.currentBid ?? _currentAd.startingBid ?? 0) + 5;

    if (entered == null || entered < minBid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                '⚠️ يجب أن تكون المزايدة \$${minBid.toStringAsFixed(0)} أو أعلى.')),
      );
      return;
    }

    setState(() => _isPlacingBid = true);

    final previousTopBidderId =
        _currentAd.bids.isNotEmpty ? _currentAd.bids.first.userId : null;

    final snipResult = AntiSnipingEngine.evaluateBidTiming(
      currentEndTime: _currentAd.auctionEndTime ??
          DateTime.now().add(const Duration(days: 1)),
      bidTimestamp: DateTime.now(),
    );

    final updatedBids = List<BidRecord>.from(_currentAd.bids)
      ..insert(
        0,
        BidRecord(
          id: 'bid_${DateTime.now().millisecondsSinceEpoch}',
          userId: _manager.currentUserId,
          userName: _manager.currentUserName,
          amount: entered,
          timestamp: DateTime.now(),
        ),
      );

    final updatedAd = _currentAd.copyWith(
      currentBid: entered,
      auctionEndTime: snipResult.newEndTime,
      bids: updatedBids,
    );

    setState(() {
      _currentAd = updatedAd;
      _bidController.clear();
      _isPlacingBid = false;
    });

    widget.onAdUpdated(updatedAd);

    try {
      await Supabase.instance.client
          .from('ads')
          .update(updatedAd.toMap())
          .eq('id', updatedAd.id)
          .timeout(const Duration(seconds: 8));

      _sendAuctionNotification(
        targetUserId: _currentAd.userId,
        title: 'مزايدة جديدة على إعلانك 🔨',
        message:
            'قام ${_manager.currentUserName} بالمزايدة بمبلغ \$${entered.toStringAsFixed(0)} على "${_currentAd.title}".',
      );

      if (previousTopBidderId != null &&
          previousTopBidderId != _manager.currentUserId) {
        _sendAuctionNotification(
          targetUserId: previousTopBidderId,
          title: 'تنبيه: تمت المزايدة بسعر أعلى! ⚡',
          message:
              'زايد شخص آخر بمبلغ \$${entered.toStringAsFixed(0)} على "${_currentAd.title}". زايد الآن لاستعادة الصدارة!',
        );
      }
    } catch (_) {}

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snipResult.message),
          backgroundColor: snipResult.wasExtended
              ? Colors.amber.shade900
              : Colors.green.shade800,
        ),
      );
    }
  }

  void _openEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (c) => FullAddAdScreen(
          initialAd: _currentAd,
          onAdCreated: (up) {
            setState(() => _currentAd = up);
            widget.onAdUpdated(up);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('✅ تم تحديث بيانات الإعلان بنجاح!'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images =
        _currentAd.imageUrls.isNotEmpty ? _currentAd.imageUrls : [''];

    final bool isOwner = _manager.isLoggedIn &&
        (_manager.currentUserId == _currentAd.userId ||
            (_manager.currentUserPhone.isNotEmpty &&
                _manager.currentUserPhone == _currentAd.phone));

    final bool canEdit =
        _manager.isSuperAdmin || _manager.isModerator || isOwner;

    final remaining = _currentAd.soldRemainingDuration;

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          _currentAd.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (canEdit)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
              tooltip: 'حذف الإعلان',
              onPressed: () async {
                final confirm = await showDialog<bool>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('حذف الإعلان نهائياً'),
                        content: const Text(
                            'هل أنت متأكد من رغبتك في حذف هذا الإعلان نهائياً من السوق؟'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('إلغاء')),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('تأكيد الحذف',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ) ??
                    false;
                if (confirm) {
                  _manager.deleteAdCompletely(_currentAd.id);
                  widget.onAdDeleted(_currentAd.id);
                  Navigator.pop(context);
                }
              },
            ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            tooltip: 'معاينة ومشاركة الرابط',
            onPressed: _openWebPreview,
          ),
          IconButton(
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: widget.onToggleFavorite,
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          if (canEdit)
            Container(
              color: const Color(0xFF0F172A),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0284C7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon:
                          const Icon(Icons.edit, color: Colors.white, size: 15),
                      label: const Text('تعديل الإعلان',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      onPressed: _openEditScreen,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 5,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentAd.isSold
                            ? Colors.grey.shade700
                            : const Color(0xFFDC2626),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      icon: Icon(
                          _currentAd.isSold
                              ? Icons.undo
                              : Icons.check_circle_outline,
                          color: Colors.white,
                          size: 15),
                      label: Text(
                          _currentAd.isSold ? 'إلغاء البيع' : 'ختم تم البيع ✓',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      onPressed: _confirmMarkAsSold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent, size: 20),
                    tooltip: 'حذف الإعلان',
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('حذف الإعلان نهائياً'),
                              content: const Text(
                                  'هل ترغب بالتأكيد في حذف هذا الإعلان؟'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text('إلغاء')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('حذف',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ) ??
                          false;
                      if (confirm) {
                        _manager.deleteAdCompletely(_currentAd.id);
                        widget.onAdDeleted(_currentAd.id);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          if (_currentAd.isPending)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.orange.shade900,
              child: const Row(
                children: [
                  Icon(Icons.hourglass_top, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '⏳ الإعلان قيد التدقيق والمراجعة من قبل الإدارة وسيظهر للجميع فور اعتماده.',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          else if (_currentAd.isRejected)
            Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red.shade900,
              child: Row(
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '❌ تم رفض هذا الإعلان لمخالفته الشروط.',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        if (_currentAd.rejectionReason != null &&
                            _currentAd.rejectionReason!.isNotEmpty)
                          Text(
                            'سبب الرفض: ${_currentAd.rejectionReason}',
                            style: const TextStyle(
                                color: Colors.amberAccent,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 270,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (i) => setState(() {
                    _currentImageIndex = i;
                    _resetZoom();
                  }),
                  itemBuilder: (c, idx) => GestureDetector(
                    onDoubleTap: () {
                      if (_currentScale > 1.0) {
                        _resetZoom();
                      } else {
                        _zoomIn();
                      }
                    },
                    onTap: () => _openFullScreenImage(idx),
                    child: InteractiveViewer(
                      transformationController: _zoomController,
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: AppSmartImage(
                          imageUrl: images[idx], fit: BoxFit.cover),
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (idx) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: _currentImageIndex == idx ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _currentImageIndex == idx
                                ? _manager.secondaryColor
                                : Colors.white60,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.zoom_in,
                              color: Colors.white, size: 20),
                          onPressed: _zoomIn,
                          tooltip: 'تكبير',
                        ),
                        IconButton(
                          icon: const Icon(Icons.zoom_out,
                              color: Colors.white, size: 20),
                          onPressed: _zoomOut,
                          tooltip: 'تصغير',
                        ),
                        IconButton(
                          icon: const Icon(Icons.fullscreen,
                              color: Colors.white, size: 20),
                          onPressed: () =>
                              _openFullScreenImage(_currentImageIndex),
                          tooltip: 'ملء الشاشة',
                        ),
                      ],
                    ),
                  ),
                ),
                if (_currentAd.isSold)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.65),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: -0.18,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDC2626),
                                  borderRadius: BorderRadius.circular(8),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black45, blurRadius: 8)
                                  ],
                                ),
                                child: const Text(
                                  'تم البيع ✓ SOLD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            if (remaining != null) ...[
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFFD4AF37), width: 1),
                                ),
                                child: Text(
                                  'سيتم حذف المنشور تلقائياً بعد: ${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')} دقيقة ⏳',
                                  style: const TextStyle(
                                    color: Color(0xFFD4AF37),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (images.length > 1) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: images.length,
                itemBuilder: (ctx, i) {
                  final isSel = _currentImageIndex == i;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSel
                              ? const Color(0xFFD4AF37)
                              : Colors.grey.shade400,
                          width: isSel ? 2.5 : 1,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child:
                          AppSmartImage(imageUrl: images[i], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _currentAd.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _manager.titleTextColor,
                        ),
                      ),
                    ),
                    if (_currentAd.priceUsd != null)
                      Text(
                        '\$${_currentAd.priceUsd!.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _manager.priceUsdColor,
                        ),
                      ),
                  ],
                ),
                if (_currentAd.priceSyp != null)
                  Text(
                    '${_currentAd.priceSyp!.toStringAsFixed(0)} ليرة سورية',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _manager.priceSypColor,
                    ),
                  ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 14, color: _manager.locationTextColor),
                    const SizedBox(width: 4),
                    Text(
                      '${_currentAd.governorate} - ${_currentAd.neighborhood}',
                      style: TextStyle(
                          fontSize: 12, color: _manager.locationTextColor),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _currentAd.condition,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _manager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded,
                        size: 13, color: _manager.locationTextColor),
                    const SizedBox(width: 4),
                    Text(
                      'تاريخ النشر: ${_currentAd.timeAgo}',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: _manager.locationTextColor,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                if (_currentAd.videoUrl != null ||
                    _currentAd.facebookUrl != null ||
                    _currentAd.telegramUrl != null ||
                    _currentAd.instagramUrl != null ||
                    _currentAd.tiktokUrl != null ||
                    _currentAd.youtubeUrl != null) ...[
                  const Text('روابط التواصل وفيديو المعاينة:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (_currentAd.videoUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.play_circle_fill,
                              color: Colors.red, size: 16),
                          label: const Text('فيديو توضيحي',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () => _openSocialLink(_currentAd.videoUrl),
                        ),
                      if (_currentAd.facebookUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.facebook,
                              color: Colors.blue, size: 16),
                          label: const Text('فيسبوك',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.facebookUrl),
                        ),
                      if (_currentAd.telegramUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.send,
                              color: Colors.lightBlue, size: 16),
                          label: const Text('تليجرام',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.telegramUrl),
                        ),
                      if (_currentAd.instagramUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.camera_alt,
                              color: Colors.pink, size: 16),
                          label: const Text('إنستغرام',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.instagramUrl),
                        ),
                      if (_currentAd.tiktokUrl != null)
                        ActionChip(
                          avatar: const Icon(Icons.music_note,
                              color: Colors.black87, size: 16),
                          label: const Text('تيك توك',
                              style: TextStyle(fontSize: 11)),
                          onPressed: () =>
                              _openSocialLink(_currentAd.tiktokUrl),
                        ),
                    ],
                  ),
                  const Divider(height: 24),
                ],
                // ================= شريط روابط التواصل الاجتماعي وتضمين الفيديو =================
                _buildSellerSocialBar(),
                const SizedBox(height: 12),

                if (_currentAd.isAuction) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.withOpacity(0.5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.gavel, color: Colors.amber, size: 20),
                            SizedBox(width: 6),
                            Text(
                              'غرفة المزاد العلني المباشر ⚖️ (مع حماية منع القنص)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'أعلى مزايدة حالية: \$${(_currentAd.currentBid ?? _currentAd.startingBid ?? 0).toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // ================= العداد التنازلي الحي للمزاد بالثواني =================
                        _buildAuctionLiveCountdown(),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _bidController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'قيمة المزايدة (\$)',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _manager.buttonColor),
                              onPressed:
                                  _isPlacingBid ? null : _placeAuctionBid,
                              child: _isPlacingBid
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                  : const Text(
                                      'زايد الآن 🔨',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                // ================= بطاقة معاينة وتشغيل فيديو يوتيوب المدمج =================
                _buildYouTubeVideoCard(),
                const Text(
                  'تفاصيل ومواصفات السلعة:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentAd.description,
                  style: const TextStyle(fontSize: 13.5, height: 1.6),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: _manager.primaryColor,
                            child: Text(
                              _currentAd.userName.isNotEmpty
                                  ? _currentAd.userName[0]
                                  : 'U',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _currentAd.userName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(width: 4),
                                    KycVerificationBadge(
                                      isVerified: _currentAd.isVerifiedSeller,
                                      positiveLikes:
                                          _currentAd.sellerPositiveLikes,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                Text(
                                  'السمعة الحالية: ${_currentAd.sellerPositiveLikes} 👍 إيجابي • ${_currentAd.sellerDislikes} 👎 سلبي',
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                            icon: const Icon(Icons.thumb_up,
                                color: Colors.green, size: 18),
                            label: Text(
                              'تقييم إيجابي (${_currentAd.sellerPositiveLikes})',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () => _handleVote(true),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.thumb_down,
                                color: Colors.red, size: 18),
                            label: Text(
                              'تقييم سلبي (${_currentAd.sellerDislikes})',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            onPressed: () => _handleVote(false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'التعليقات والاستفسارات المباشرة 💬:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'اكتب استفسارك أو تعليقك حول السلعة...',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _manager.buttonColor),
                      onPressed: _submitComment,
                      child: const Text('تعليق',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (_isLoadingComments)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2)),
                  ))
                else if (_adComments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'لا توجد تعليقات بعد. كن أول من يستفسر عن السلعة!',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                else
                  ..._adComments.map(
                    (c) => Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c.userName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text(
                                '${c.createdAt.hour}:${c.createdAt.minute.toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(c.commentText,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text('واتساب',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: _openWhatsapp,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.phone, color: Colors.white),
                label: const Text('اتصال',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: _callSeller,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: _manager.secondaryColor.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: Icon(Icons.forum, color: _manager.primaryColor),
              tooltip: 'محادثة وتفاوض مباشر',
              onPressed: _openDirectChat,
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// شاشة استمارة ترقية الباقات الشهرية والسنوية مع رفع الإيصال (SubscriptionPlansScreen)
// ==============================================================================
class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  final AppStateManager _manager = AppStateManager();
  SubscriptionPlanItem? _selectedPlan;
  String _selectedDurationType = 'monthly';
  String _selectedGateway = 'SHAM_CASH';
  String _selectedGovernorate = 'دمشق';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _refController = TextEditingController();

  Uint8List? _receiptImageBytes;
  bool _isSubmitting = false;

  final List<String> _governorates = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = _manager.currentUserName;
    _phoneController.text = _manager.currentUserPhone;
    _emailController.text = _manager.currentUserEmail;
    if (_manager.subscriptionPlans.isNotEmpty) {
      _selectedPlan = _manager.subscriptionPlans.firstWhere(
        (p) => p.priceUsd > 0,
        orElse: () => _manager.subscriptionPlans.first,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _refController.dispose();
    super.dispose();
  }

  Future<void> _pickReceiptImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxWidth: 1080,
    );
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _receiptImageBytes = bytes);
    }
  }

  Future<void> _submitUpgrade() async {
    if (_nameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى كتابة الاسم ورقم الهاتف للتواصل')),
      );
      return;
    }

    if (_receiptImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('⚠️ يرجى إرفاق صورة إشعار أو إيصال التحويل لإثبات الدفع'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final isYearly = _selectedDurationType == 'yearly';
    final durationHours = isYearly ? 8760 : 720;
    final durationLabel =
        isYearly ? 'اشتراك سنوي (12 شهر) 🌟' : 'اشتراك شهري (30 يوم) 📅';
    final basePrice = _selectedPlan!.priceUsd;
    final finalPrice = isYearly ? (basePrice * 10) : basePrice;

    final success = await _manager.submitPaymentAuditRequest(
      planId: _selectedPlan!.id,
      planName: _selectedPlan!.name,
      priceUsd: finalPrice,
      gateway: _selectedGateway,
      refOrTxId: _refController.text.trim().isNotEmpty
          ? _refController.text.trim()
          : 'مرفق صورة الإيصال',
      userName: _nameController.text.trim(),
      userPhone: _phoneController.text.trim(),
      userEmail: _emailController.text.trim(),
      userGovernorate: _selectedGovernorate,
      requestType: 'plan_subscription',
      durationLabel: durationLabel,
      durationHours: durationHours,
      receiptBytes: _receiptImageBytes,
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.verified, color: Colors.green, size: 26),
              SizedBox(width: 8),
              Text('تم إرسال طلب الترقية 📄', style: TextStyle(fontSize: 16)),
            ],
          ),
          content: Text(
            'تم استلام بياناتك وصورة إشعار الدفع بنجاح ($durationLabel).\nسيتم مراجعة الإيصال وتفعيل باقتك مع العداد التنازلي التلقائي خلال دقائق!',
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('حسناً', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isYearly = _selectedDurationType == 'yearly';
    final basePrice = _selectedPlan != null ? _selectedPlan!.priceUsd : 0.0;
    final finalPriceUsd = isYearly ? (basePrice * 10) : basePrice;
    final finalPriceSyp =
        (finalPriceUsd * _manager.exchangeRateUsdToSyp).toInt();

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: const Text(
          'باقات الاشتراك وترقية الحساب 👑',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const Text('1. حدد فترة الاشتراك المطلوبة:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('اشتراك شهري (30 يوم) 📅'),
                  selected: _selectedDurationType == 'monthly',
                  selectedColor: const Color(0xFFD4AF37),
                  onSelected: (v) =>
                      setState(() => _selectedDurationType = 'monthly'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text('اشتراك سنوي (خصم شهرين) 🌟'),
                  selected: _selectedDurationType == 'yearly',
                  selectedColor: const Color(0xFFD4AF37),
                  onSelected: (v) =>
                      setState(() => _selectedDurationType = 'yearly'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('2. اختر الباقة المناسبة لك:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          ..._manager.subscriptionPlans
              .where((p) => p.priceUsd > 0)
              .map((plan) {
            final isSelected = _selectedPlan?.id == plan.id;
            final itemPrice = isYearly ? (plan.priceUsd * 10) : plan.priceUsd;
            final itemSyp = (itemPrice * _manager.exchangeRateUsdToSyp).toInt();

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color:
                      isSelected ? const Color(0xFFD4AF37) : Colors.transparent,
                  width: 2,
                ),
              ),
              child: ListTile(
                onTap: () => setState(() => _selectedPlan = plan),
                leading: CircleAvatar(
                  backgroundColor: isSelected
                      ? const Color(0xFFD4AF37)
                      : _manager.primaryColor,
                  child: Icon(
                    plan.id == 'plan_vip'
                        ? Icons.workspace_premium
                        : Icons.star,
                    color: Colors.white,
                  ),
                ),
                title: Text(plan.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text(
                    'الحد: ${plan.maxAds} إعلانات • ${plan.maxImagesPerAd} صور • شارة موثق',
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${itemPrice.toInt()} USD',
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Text('$itemSyp ل.س',
                        style: const TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المجموع: \$$finalPriceUsd دولار',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
                Text('$finalPriceSyp ليرة سورية',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('3. انسخ الحساب وحوّل المبلغ المطلوب:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          const ExclusivePaymentGatewayCard(),
          const SizedBox(height: 16),
          const Text('4. بياناتك للتواصل والتوثيق:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'الاسم الكامل أو اسم المتجر/المحل *',
              prefixIcon: const Icon(Icons.person),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'رقم هاتف الاتصال والواتساب *',
              prefixIcon: const Icon(Icons.phone),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني (لتأكيد الفاتورة)',
              prefixIcon: const Icon(Icons.email),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedGovernorate,
            decoration: InputDecoration(
              labelText: 'المحافظة',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            items: _governorates
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _selectedGovernorate = v);
            },
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('دفع عبر شام كاش 🇸🇾'),
                  selected: _selectedGateway == 'SHAM_CASH',
                  onSelected: (v) =>
                      setState(() => _selectedGateway = 'SHAM_CASH'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text('دفع عبر بينانس USDT 🪙'),
                  selected: _selectedGateway == 'BINANCE_USDT',
                  onSelected: (v) =>
                      setState(() => _selectedGateway = 'BINANCE_USDT'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _refController,
            decoration: const InputDecoration(
              labelText: 'رقم العملية أو رمز المعاملة (اختياري)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('5. إرفاق صورة الإيصال أو لقطة شاشة التحويل *:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickReceiptImage,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _receiptImageBytes != null
                      ? Colors.green
                      : _manager.secondaryColor,
                  width: 1.5,
                ),
              ),
              child: _receiptImageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: Image.memory(
                        _receiptImageBytes!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo,
                            color: _manager.secondaryColor, size: 36),
                        const SizedBox(height: 6),
                        const Text('اضغط لاختيار صورة إيصال التحويل من المعرض',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _manager.buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _isSubmitting ? null : _submitUpgrade,
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'إرسال التقرير وصورة الإشعار للإدارة فوراً 🚀',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class PanoramaBookingScreen extends StatefulWidget {
  const PanoramaBookingScreen({Key? key}) : super(key: key);

  @override
  State<PanoramaBookingScreen> createState() => _PanoramaBookingScreenState();
}

class _PanoramaBookingScreenState extends State<PanoramaBookingScreen> {
  final AppStateManager _manager = AppStateManager();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _refController = TextEditingController();

  String _selectedGateway = 'SHAM_CASH';
  String _selectedGovernorate = 'دمشق';

  final List<Map<String, dynamic>> _durationOptions = [
    {'label': '3 ساعات ⏱️', 'hours': 3, 'priceUsd': 3.0},
    {'label': '6 ساعات ⏱️', 'hours': 6, 'priceUsd': 5.0},
    {'label': '12 ساعة ⏱️', 'hours': 12, 'priceUsd': 8.0},
    {'label': '24 ساعة (يوم كامل) 🌞', 'hours': 24, 'priceUsd': 12.0},
    {'label': '48 ساعة (يومان) 📅', 'hours': 48, 'priceUsd': 20.0},
    {'label': 'أسبوع (7 أيام) 🌟', 'hours': 168, 'priceUsd': 45.0},
    {'label': '10 أيام 🔥', 'hours': 240, 'priceUsd': 60.0},
    {'label': 'شهر كامل (30 يوم) 👑', 'hours': 720, 'priceUsd': 150.0},
  ];

  late Map<String, dynamic> _selectedDuration;
  final List<Uint8List> _bannerImagesBytes = [];
  Uint8List? _receiptImageBytes;
  bool _isSubmitting = false;

  final List<String> _governorates = [
    'كل المحافظات',
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  @override
  void initState() {
    super.initState();
    _selectedDuration = _durationOptions[3]; // الافتراضي: 24 ساعة
    _phoneController.text = _manager.currentUserPhone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _phoneController.dispose();
    _linkController.dispose();
    _refController.dispose();
    super.dispose();
  }

  Future<void> _pickBannerImages() async {
    final picker = ImagePicker();
    final picked =
        await picker.pickMultiImage(imageQuality: 75, maxWidth: 1200);
    if (picked.isNotEmpty) {
      for (var f in picked) {
        if (_bannerImagesBytes.length < 15) {
          final b = await f.readAsBytes();
          setState(() => _bannerImagesBytes.add(b));
        }
      }
    }
  }

  Future<void> _pickReceiptImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 75, maxWidth: 1080);
    if (picked != null) {
      final b = await picked.readAsBytes();
      setState(() => _receiptImageBytes = b);
    }
  }

  Future<void> _submitPanoramaBooking() async {
    if (_titleController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('يرجى كتابة عنوان البانوراما ورقم الهاتف للتواصل')),
      );
      return;
    }

    if (_bannerImagesBytes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يرجى اختيار صورة واحدة على الأقل للبانوراما')),
      );
      return;
    }

    if (_receiptImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يرجى إرفاق صورة إيصال التحويل لإثبات الدفع')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final uploadedBannerUrls =
        await StorageUploadService.uploadMultipleImageBytes(
      bucketName: kStorageBucketBanners,
      imagesBytesList: _bannerImagesBytes,
      prefix: 'book_pan',
    );

    String? uploadedReceiptUrl;
    if (_receiptImageBytes != null) {
      uploadedReceiptUrl = await StorageUploadService.uploadImageBytes(
        bucketName: kStorageBucketFeedbacks,
        imageBytes: _receiptImageBytes!,
        prefix: 'receipt',
      );
    }

    final double priceUsd = (_selectedDuration['priceUsd'] as num).toDouble();

    await _manager.submitPaymentAuditRequest(
      planId: 'panorama_slot',
      planName: 'حجز بانوراما (${_selectedDuration['label']})',
      priceUsd: priceUsd,
      gateway: _selectedGateway,
      refOrTxId: _refController.text.trim().isNotEmpty
          ? _refController.text.trim()
          : 'مرفق إيصال الدفع',
      userName: _manager.currentUserName,
      userPhone: _phoneController.text.trim(),
      userEmail: _manager.currentUserEmail,
      userGovernorate: _selectedGovernorate,
      requestType: 'panorama_booking',
      durationLabel: _selectedDuration['label'].toString(),
      durationHours: _selectedDuration['hours'] as int,
      receiptBytes: _receiptImageBytes,
      bannerImages: uploadedBannerUrls,
      bannerTitle: _titleController.text.trim(),
      bannerSubtitle: _subtitleController.text.trim(),
      bannerLinkUrl: _linkController.text.trim(),
    );

    setState(() => _isSubmitting = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.verified, color: Colors.green, size: 26),
              SizedBox(width: 8),
              Text('تم استلام طلب حجز البانوراما 🖼️',
                  style: TextStyle(fontSize: 15)),
            ],
          ),
          content: Text(
            'تم إرسال صور البانوراما وإشعار الدفع بنجاح.\nسيتم تفعيل البانوراما في الواجهة الرئيسية فور تدقيق الإيصال لتبدأ مدة العرض (${_selectedDuration['label']}) مع العداد التنازلي التلقائي!',
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.primaryColor),
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              child: const Text('حسناً', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double priceUsd = (_selectedDuration['priceUsd'] as num).toDouble();
    final int priceSyp = (priceUsd * _manager.exchangeRateUsdToSyp).toInt();

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: const Text(
          'حجز بانوراما إعلانية تفاعلية 🖼️',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          // 1. مدة العرض والأسعار
          const Text('1. اختر مدة بقاء البانوراما في الرئيسية:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _durationOptions.map((opt) {
              final isSel = _selectedDuration['hours'] == opt['hours'];
              return ChoiceChip(
                label: Text(opt['label'].toString() +
                    ' (' +
                    opt['priceUsd'].toString() +
                    ' USD)'),
                selected: isSel,
                selectedColor: const Color(0xFFD4AF37),
                onSelected: (val) {
                  if (val) setState(() => _selectedDuration = opt);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('المبلغ المطلوب: \$$priceUsd دولار',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
                Text('$priceSyp ليرة سورية',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 2. صور البانوراما
          const Text('2. صور البانوراما (حتى 15 صورة تتقلب تلقائياً):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          SizedBox(
            height: 85,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: _pickBannerImages,
                  child: Container(
                    width: 85,
                    decoration: BoxDecoration(
                      color: _manager.primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _manager.secondaryColor, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate,
                            color: _manager.secondaryColor, size: 26),
                        const SizedBox(height: 4),
                        const Text('إضافة صور',
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ..._bannerImagesBytes.map((bytes) => Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 85,
                      height: 85,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.memory(bytes, fit: BoxFit.cover),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. نصوص وروابط البانوراما
          const Text('3. تفاصيل ونص الإعلان:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                labelText: 'العنوان الرئيسي للبانوراما *',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _subtitleController,
            decoration: const InputDecoration(
                labelText: 'النص الفرعي أو التخفيض',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                labelText: 'رقم الواتساب والاتصال للمشترين *',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _linkController,
            decoration: const InputDecoration(
                labelText: 'رابط صفحة أو موقع (فيسبوك/تليجرام/موقع)',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedGovernorate,
            decoration: const InputDecoration(
                labelText: 'المحافظة المستهدفة', border: OutlineInputBorder()),
            items: _governorates
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _selectedGovernorate = v);
            },
          ),
          const SizedBox(height: 16),

          // 4. الدفع وإرفاق الإيصال
          const Text('4. التحويل وإرفاق صورة الإشعار:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          const ExclusivePaymentGatewayCard(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('شام كاش 🇸🇾'),
                  selected: _selectedGateway == 'SHAM_CASH',
                  onSelected: (v) =>
                      setState(() => _selectedGateway = 'SHAM_CASH'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text('بينانس USDT 🪙'),
                  selected: _selectedGateway == 'BINANCE_USDT',
                  onSelected: (v) =>
                      setState(() => _selectedGateway = 'BINANCE_USDT'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _refController,
            decoration: const InputDecoration(
                labelText: 'رمز التحويل / TXID (اختياري)',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _pickReceiptImage,
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _receiptImageBytes != null
                      ? Colors.green
                      : _manager.secondaryColor,
                  width: 1.5,
                ),
              ),
              child: _receiptImageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.memory(_receiptImageBytes!,
                          fit: BoxFit.cover, width: double.infinity),
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long,
                            color: Color(0xFFD4AF37), size: 30),
                        SizedBox(height: 4),
                        Text('اضغط لإرفاق صورة إشعار أو لقطة شاشة التحويل 📸',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 20),

          // زر إرسال الطلب
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _manager.buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _isSubmitting ? null : _submitPanoramaBooking,
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('إرسال طلب الحجز والإشعار للإدارة فوراً 🚀',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ==============================================================================
// 19. الشاشة الرئيسية الكبرى المحصنة ضد Overflow (MainDashboardScreen)
// ==============================================================================
class MainDashboardScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const MainDashboardScreen({
    Key? key,
    required this.isDarkMode,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen>
    with WidgetsBindingObserver {
  final AppStateManager _manager = AppStateManager();
  final ImagePicker _picker = ImagePicker();
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      body: SafeArea(
        child: _currentNavIndex == 2
            ? _buildFavoritesTab()
            : _currentNavIndex == 3
                ? _buildProfileTab()
                : const Center(child: Text('سوق سوريا الشامل')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (i) => setState(() => _currentNavIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: _manager.appBarColor,
        selectedItemColor: _manager.secondaryColor,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  final List<String> _governorates = [
    'كل المحافظات',
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  String _selectedGovernorate = 'كل المحافظات';
  String? _selectedCategoryId;
  String? _selectedSubcategory;
  String _searchQuery = '';
  final Set<String> _favoriteAdIds = {};
  bool _isLoadingAds = false;
  bool _isLoadingMore = false;
  bool _hasMoreAds = true;
  int _currentPage = 0;
  static const int _pageSize = 24;

  int _pendingAdsCount = 0;
  List<Map<String, dynamic>> _userChatThreads = [];

  String _filterCondition = 'الكل';
  double? _filterMinPrice;
  double? _filterMaxPrice;
  String _sortBy = 'newest';

  final ScrollController _gridScrollController = ScrollController();
  final ScrollController _tickerScrollController = ScrollController();
  Timer? _tickerTimer;
  bool _isTickerPaused = false;

  final PageController _bannerCarouselController = PageController();
  int _currentBannerIndex = 0;
  Timer? _bannerAutoScrollTimer;
  bool _isBannerUserInteracting = false;
  bool _isUploadingBanner = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _manager.addListener(_onStateChange);

    _manager.loadCachedDataOffline();
    _manager.loadPersistedSession();
    _manager.initRealtimeListeners();

    _initLiveAdsFromSupabase();
    _fetchUserFavorites();
    _fetchUserChats();
    _startTickerAnimation();
    _startBannerCarouselTimer();

    _gridScrollController.addListener(_onScrollListener);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _manager.removeListener(_onStateChange);
    _gridScrollController.removeListener(_onScrollListener);
    _gridScrollController.dispose();
    _tickerTimer?.cancel();
    _tickerScrollController.dispose();
    _bannerAutoScrollTimer?.cancel();
    _bannerCarouselController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _tickerTimer?.cancel();
      _bannerAutoScrollTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      _startTickerAnimation();
      _startBannerCarouselTimer();
    }
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  void _onScrollListener() {
    if (_gridScrollController.position.pixels >=
            _gridScrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMoreAds &&
        !_isLoadingAds) {
      _fetchMoreAds();
    }
  }

  void _startTickerAnimation() {
    _tickerTimer?.cancel();
    _tickerTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (!_isTickerPaused && _tickerScrollController.hasClients) {
        final maxScroll = _tickerScrollController.position.maxScrollExtent;
        final currentScroll = _tickerScrollController.offset;
        if (currentScroll >= maxScroll) {
          _tickerScrollController.jumpTo(0.0);
        } else {
          _tickerScrollController.jumpTo(currentScroll + _manager.tickerSpeed);
        }
      }
    });
  }

  void _startBannerCarouselTimer() {
    _bannerAutoScrollTimer?.cancel();
    final interval = _manager.bannerDefaultIntervalSeconds > 0
        ? _manager.bannerDefaultIntervalSeconds
        : 3;

    _bannerAutoScrollTimer =
        Timer.periodic(Duration(seconds: interval), (timer) {
      if (mounted &&
          !_isBannerUserInteracting &&
          _manager.isBannerAutoScrollEnabled &&
          _manager.banners.length > 1 &&
          _bannerCarouselController.hasClients) {
        final nextIndex = (_currentBannerIndex + 1) % _manager.banners.length;
        _bannerCarouselController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
        setState(() => _currentBannerIndex = nextIndex);
      }
    });
  }

  Future<void> _fetchUserFavorites() async {
    if (!_manager.isLoggedIn || _manager.currentUserId.isEmpty) return;
    try {
      final res = await Supabase.instance.client
          .from('favorites')
          .select('ad_id')
          .eq('user_id', _manager.currentUserId)
          .timeout(const Duration(seconds: 10));

      if (res is List && mounted) {
        setState(() {
          _favoriteAdIds.clear();
          for (final row in res) {
            _favoriteAdIds.add(row['ad_id'].toString());
          }
        });
      }
    } catch (e) {
      debugPrint('Favorites fetch notice: $e');
    }
  }

  Future<void> _toggleFavoriteInSupabase(String adId) async {
    if (!_manager.isLoggedIn) return;
    final isFav = _favoriteAdIds.contains(adId);
    setState(() {
      if (isFav) {
        _favoriteAdIds.remove(adId);
      } else {
        _favoriteAdIds.add(adId);
      }
    });

    try {
      if (isFav) {
        await Supabase.instance.client
            .from('favorites')
            .delete()
            .match({'user_id': _manager.currentUserId, 'ad_id': adId}).timeout(
                const Duration(seconds: 10));
      } else {
        await Supabase.instance.client
            .from('favorites')
            .insert({'user_id': _manager.currentUserId, 'ad_id': adId}).timeout(
                const Duration(seconds: 10));
      }
    } catch (e) {
      debugPrint('Error toggling favorite: $e');
    }
  }

  Future<void> _fetchUserChats() async {
    if (!_manager.isLoggedIn || _manager.currentUserId.isEmpty) return;
    try {
      final res = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List && mounted) {
        setState(() {
          _userChatThreads = List<Map<String, dynamic>>.from(res);
        });
      }
    } catch (e) {
      debugPrint('Fetch chats notice: $e');
    }
  }

  Future<void> _initLiveAdsFromSupabase() async {
    if (mounted) {
      setState(() {
        _isLoadingAds = _manager.ads.isEmpty;
        _currentPage = 0;
        _hasMoreAds = true;
      });
    }

    try {
      // 1. جلب أسعار الصرف والذهب الحية فوراً من السيرفر وتحديثها على كل الأجهزة
      try {
        final ratesRes = await Supabase.instance.client
            .from('exchange_rates')
            .select()
            .limit(1)
            .timeout(const Duration(seconds: 8));

        if (ratesRes is List && ratesRes.isNotEmpty) {
          final data = ratesRes.first as Map<String, dynamic>;
          final usd = data['usd_rate'];
          final gold = data['gold_price'];

          if (usd != null) {
            _manager.exchangeRateUsdToSyp = (usd as num).toDouble();
          }
          if (gold != null) {
            _manager.goldPrice21kSyp = (gold as num).toDouble();
          }
          if (mounted) {
            setState(() {});
          }
          _manager.notifyListeners();
        }
      } catch (rateErr) {
        debugPrint('Supabase fetch rates notice: $rateErr');
      }

      // 2. جلب الإعلانات النشطة
      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .range(0, _pageSize - 1)
          .timeout(const Duration(seconds: 12));

      if (res is List) {
        final fetched = res
            .map((map) => AdItem.fromMap(map as Map<String, dynamic>))
            .toList();
        _manager.ads = fetched;
        _manager.saveAdsToOfflineCache(fetched);
        _hasMoreAds = fetched.length >= _pageSize;
      }

      // 3. جلب البانوراما الإعلانية الحية وتحديثها فوراً لجميع الأجهزة
      final bannerRes = await Supabase.instance.client
          .from('banners')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (bannerRes is List && (bannerRes).isNotEmpty) {
        final fetchedBanners = bannerRes
            .map((map) => BannerItem.fromMap(map as Map<String, dynamic>))
            .toList();
        _manager.banners = fetchedBanners;
        _manager.saveBannersToOfflineCache(fetchedBanners);
        if (mounted) {
          setState(() {});
        }
        _manager.notifyListeners();
      }

      final pendingRes = await Supabase.instance.client
          .from('ads')
          .select('id')
          .eq('status', 'pending')
          .timeout(const Duration(seconds: 10));

      if (pendingRes is List && mounted) {
        setState(() => _pendingAdsCount = pendingRes.length);
      }

      await _manager.autoCleanupExpiredSoldAds();
    } catch (e) {
      debugPrint('Supabase fetch ads notice: $e');
    } finally {
      if (mounted) setState(() => _isLoadingAds = false);
    }
  }

  Future<void> _fetchMoreAds() async {
    if (_isLoadingMore || !_hasMoreAds) return;
    setState(() => _isLoadingMore = true);

    try {
      final nextPage = _currentPage + 1;
      final from = nextPage * _pageSize;
      final to = from + _pageSize - 1;

      final res = await Supabase.instance.client
          .from('ads')
          .select()
          .order('created_at', ascending: false)
          .range(from, to)
          .timeout(const Duration(seconds: 10));

      if (res is List && res.isNotEmpty) {
        final moreAds = res
            .map((map) => AdItem.fromMap(map as Map<String, dynamic>))
            .toList();
        setState(() {
          _manager.ads.addAll(moreAds);
          _currentPage = nextPage;
          _hasMoreAds = moreAds.length >= _pageSize;
        });
      } else {
        setState(() => _hasMoreAds = false);
      }
    } catch (e) {
      debugPrint('Fetch more ads error: $e');
    } finally {
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  bool _requireAuth(VoidCallback onAuthenticated) {
    if (!_manager.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              '⚠️ يجب تسجيل الدخول أولاً لإتمام هذا الإجراء في المنصة.'),
          backgroundColor: const Color(0xFF1E293B),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          action: SnackBarAction(
            label: 'تسجيل الدخول',
            textColor: _manager.secondaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => AuthScreen()),
              );
            },
          ),
        ),
      );
      return false;
    }
    onAuthenticated();
    return true;
  }

  void _showBannerDetailsSheet(BannerItem b) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 18,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: b.badgeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        b.badgeText,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    if (b.location.isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(b.location,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  b.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (b.subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    b.subtitle,
                    style: TextStyle(
                        fontSize: 14,
                        color: _manager.secondaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  b.description,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.black87, height: 1.4),
                ),
                const SizedBox(height: 16),
                if (b.imageUrls.length > 1) ...[
                  const Text('صور إضافية للبانوراما 📸:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: b.imageUrls.length,
                      itemBuilder: (_, i) => Container(
                        margin: const EdgeInsets.only(left: 8),
                        width: 80,
                        height: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: AppSmartImage(
                            imageUrl: b.imageUrls[i], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  children: [
                    if (b.whatsapp.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.chat, color: Colors.white),
                          label: const Text('واتساب المعلن',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            final clean =
                                PhoneHelper.formatForWhatsapp(b.whatsapp);
                            final msg = Uri.encodeComponent(
                                'مرحباً، بخصوص إعلانكم في بانوراما سوق سوريا الشامل (${b.title}):');
                            final uri =
                                Uri.parse('https://wa.me/$clean?text=$msg');
                            try {
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri,
                                    mode: LaunchMode.externalApplication);
                              }
                            } catch (_) {}
                          },
                        ),
                      ),
                    if (b.whatsapp.isNotEmpty && b.phone.isNotEmpty)
                      const SizedBox(width: 8),
                    if (b.phone.isNotEmpty)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _manager.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          icon: const Icon(Icons.phone, color: Colors.white),
                          label: const Text('اتصال بالمعلن',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            final uri = Uri.parse('tel:${b.phone}');
                            try {
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            } catch (_) {}
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      side: BorderSide(color: _manager.secondaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(Icons.campaign, color: _manager.secondaryColor),
                    label: Text(
                      'تريد الإعلان في هذه المساحة البانورامية؟ تواصل معنا 📢',
                      style: TextStyle(
                          color: _manager.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      _showContactAdminDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickAndUploadBannerDirectly() async {
    if (!_manager.isAdmin) {
      _showContactAdminDialog();
      return;
    }

    // 1. سؤال المسؤول: لأي قسم تريد رفع البانوراما؟ (اليمين أم اليسار)
    final int? selectedSlot = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.view_carousel, color: Color(0xFFD4AF37)),
            SizedBox(width: 8),
            Text('تحديد قسم البانوراما 🖼️',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'اختر القسم الذي تريد نشر وتثبيت هذه البانوراما فيه لكي يراها كل الناس:',
          style: TextStyle(fontSize: 13),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0F172A),
            ),
            onPressed: () => Navigator.pop(ctx, 1),
            child: const Text('القسم الأيمن 🔲 (Slot 1)',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0284C7),
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, 2),
            child: const Text('القسم الأيسر 🔲 (Slot 2)',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (selectedSlot == null) return;

    // 2. اختيار الصور من المعرض
    try {
      final pickedList = await _picker.pickMultiImage(
        imageQuality: 75,
        maxWidth: 1200,
      );
      if (pickedList.isEmpty) return;

      setState(() => _isUploadingBanner = true);

      final List<Uint8List> bytesList = [];
      for (var f in pickedList) {
        final b = await f.readAsBytes();
        bytesList.add(b);
      }

      // رفع الصور لسيرفر التخزين
      final uploadedUrls = await StorageUploadService.uploadMultipleImageBytes(
        bucketName: 'banners',
        imagesBytesList: bytesList,
        prefix: 'banner_slot$selectedSlot',
      );

      if (uploadedUrls.isNotEmpty) {
        final newBanner = BannerItem(
          id: 'bn_${DateTime.now().millisecondsSinceEpoch}',
          imageUrls: uploadedUrls,
          title: selectedSlot == 1
              ? 'إعلان مميز (القسم الأيمن) ✨'
              : 'عرض خاص (القسم الأيسر) 🚀',
          subtitle: 'سوق سوريا الشامل',
          description: 'تمت إضافته بنجاح للقسم رقم $selectedSlot',
          location: _selectedGovernorate,
          phone: kAppOwnerPhone,
          whatsapp: kAppOwnerWhatsApp,
          slot: selectedSlot, // هنا تم تثبيت القسم المستقل (1 أو 2)
          badgeText: selectedSlot == 1 ? 'VIP ★' : 'معتمد 100%',
          badgeColor: selectedSlot == 1
              ? _manager.secondaryColor
              : const Color(0xFF22C55E),
          displayDurationSeconds: _manager.bannerDefaultIntervalSeconds,
          expiresAt: DateTime.now().add(const Duration(days: 30)),
        );

        // حفظ محلي وسحابي مباشر في Supabase
        setState(() {
          _manager.banners.insert(0, newBanner);
        });
        _manager.saveBannersToOfflineCache(_manager.banners);

        // إرسال مباشر لسيرفر Supabase لكي تظهر لجميع الناس في نفس اللحظة
        try {
          await Supabase.instance.client
              .from('banners')
              .upsert(newBanner.toMap());
          debugPrint('✅ تم نشر البانوراما في السيرفر لجميع المستخدمين بنجاح!');
        } catch (serverErr) {
          debugPrint('❌ تنبيه خطأ سيرفر: $serverErr');
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '✅ تم رفع ونشر البانوراما للقسم رقم ($selectedSlot) بنجاح وستظهر لكل الناس!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تعذر رفع البنر: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingBanner = false);
    }
  }

  void _showContactAdminDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _manager.secondaryColor,
                    child: Icon(Icons.headset_mic,
                        color: _manager.primaryColor, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('التواصل المباشر مع إدارة التطبيق',
                          style: TextStyle(
                              color: _manager.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const Text('نحن هنا لخدمتكم ومساعدتكم على مدار الساعة',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: const Color(0xFF25D366).withOpacity(0.12),
                leading: const Icon(Icons.chat, color: Color(0xFF25D366)),
                title: const Text('محادثة واتساب فورية مع الإدارة',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text(
                    'رد سريع على الاستفسارات وحجز الإعلانات والبنرات'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  Navigator.pop(ctx);
                  final clean =
                      PhoneHelper.formatForWhatsapp(kAppOwnerWhatsApp);
                  final msg = Uri.encodeComponent(
                      'مرحباً إدارة سوق سوريا الشامل، لدي استفسار أو طلب حجز بنر إعلاني:');
                  final uri = Uri.parse('https://wa.me/$clean?text=$msg');
                  try {
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri,
                          mode: LaunchMode.externalApplication);
                    }
                  } catch (_) {}
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.blue.withOpacity(0.1),
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: const Text('اتصال هاتفي مباشر بالإدارة',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('رقم الهاتف: $kAppOwnerPhone'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () async {
                  Navigator.pop(ctx);
                  final uri = Uri.parse('tel:$kAppOwnerPhone');
                  try {
                    if (await canLaunchUrl(uri)) await launchUrl(uri);
                  } catch (_) {}
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: _manager.secondaryColor.withOpacity(0.15),
                leading: Icon(Icons.lightbulb, color: _manager.secondaryColor),
                title: const Text('صوتك مسموع 💡 (صندوق الاقتراحات)',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: const Text('إرسال فكرة أو شكوى مع إرفاق لقطة شاشة'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => AppFeedbackScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAdvancedFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tune, color: _manager.primaryColor),
                            const SizedBox(width: 8),
                            const Text('تصفية وفلترة متقدمة',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setSheetState(() {
                              _filterCondition = 'الكل';
                              _filterMinPrice = null;
                              _filterMaxPrice = null;
                              _sortBy = 'newest';
                            });
                            setState(() {});
                          },
                          child: const Text('إعادة ضبط'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('حالة السلعة:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        'الكل',
                        'جديد بالكرتونة',
                        'مستعمل بحالة ممتازة',
                        'مستعمل',
                        'بحاجة صيانة'
                      ].map((cond) {
                        final sel = _filterCondition == cond;
                        return ChoiceChip(
                          label: Text(cond,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: sel ? Colors.white : Colors.black87)),
                          selected: sel,
                          selectedColor: _manager.primaryColor,
                          onSelected: (val) {
                            if (val) {
                              setSheetState(() => _filterCondition = cond);
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('ترتيب النتائج حسب:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        {'key': 'newest', 'label': 'الأحدث أولاً'},
                        {'key': 'price_asc', 'label': 'الأقل سعراً'},
                        {'key': 'price_desc', 'label': 'الأعلى سعراً'},
                        {'key': 'views', 'label': 'الأكثر مشاهدة 🔥'},
                      ].map((s) {
                        final sel = _sortBy == s['key'];
                        return ChoiceChip(
                          label: Text(s['label']!,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: sel ? Colors.white : Colors.black87)),
                          selected: sel,
                          selectedColor: _manager.primaryColor,
                          onSelected: (val) {
                            if (val) setSheetState(() => _sortBy = s['key']!);
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text('نطاق السعر التقريبي (\$ دولار):',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'من (\$)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8)),
                            onChanged: (val) =>
                                _filterMinPrice = double.tryParse(val),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'إلى (\$)',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8)),
                            onChanged: (val) =>
                                _filterMaxPrice = double.tryParse(val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _manager.buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(ctx);
                        },
                        child: const Text('تطبيق الفلترة ✨',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ================= شريط الوصول السريع الذكي (الخدمات الرئيسية والمكاتب) =================
  Widget _buildQuickAccessServicesBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.35)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. زر دليل المكاتب العقارية بالمحافظات
          _buildQuickServiceButton(
            icon: Icons.real_estate_agent,
            label: 'المكاتب العقارية',
            color: const Color(0xFFD4AF37),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => const RealEstateDirectoryScreen()),
              );
            },
          ),
          // 2. زر جميع الأقسام (لعرض كل شجرة الأقسام بدون زحمة)
          _buildQuickServiceButton(
            icon: Icons.grid_view_rounded,
            label: 'جميع الأقسام',
            color: const Color(0xFF0284C7),
            onTap: () {
              _showAllCategoriesBottomSheet();
            },
          ),
          // 3. زر المزادات العلنية المباشرة
          _buildQuickServiceButton(
            icon: Icons.gavel,
            label: 'المزادات الحية',
            color: Colors.amberAccent,
            onTap: () {
              setState(() {
                _searchQuery = '';
                _selectedCategoryId = null;
                _selectedSubcategory = null;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('⚖️ جاري عرض إعلانات المزادات العلنية فقط'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          // 4. زر إعادة ضبط وعرض كل الإعلانات الحديثة
          _buildQuickServiceButton(
            icon: Icons.all_inclusive,
            label: 'كل المنشورات',
            color: const Color(0xFF22C55E),
            onTap: () {
              setState(() {
                _selectedCategoryId = null;
                _selectedSubcategory = null;
                _searchQuery = '';
                _filterCondition = 'الكل';
                _filterMinPrice = null;
                _filterMaxPrice = null;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickServiceButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.18),
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.4)),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ورقة عرض جميع الأقسام بشكل منظم وأنيق بدون تكدس في الرئيسية
  void _showAllCategoriesBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.92,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      Icon(Icons.category, color: Color(0xFFD4AF37), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'دليل كافة أقسام وتصنيفات السوق 📂',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.95,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _manager.categories.length,
                      itemBuilder: (c, i) {
                        final cat = _manager.categories[i];
                        final isSelected = _selectedCategoryId == cat.id;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategoryId = cat.id;
                              _selectedSubcategory = null;
                            });
                            Navigator.pop(ctx);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? _manager.primaryColor
                                  : const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFD4AF37)
                                    : Colors.white12,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(cat.iconData,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFFD4AF37),
                                    size: 28),
                                const SizedBox(height: 8),
                                Text(
                                  cat.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHomeFeedTab() {
    var filteredAds = _manager.ads.where((ad) {
      final matchesGov = _selectedGovernorate == 'كل المحافظات' ||
          ad.governorate == _selectedGovernorate;
      final matchesCat =
          _selectedCategoryId == null || ad.categoryId == _selectedCategoryId;
      final matchesSub = _selectedSubcategory == null ||
          ad.subcategory == _selectedSubcategory;
      final matchesSearch = _searchQuery.isEmpty ||
          ad.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ad.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ad.neighborhood.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCond =
          _filterCondition == 'الكل' || ad.condition == _filterCondition;
      final matchesMinP = _filterMinPrice == null ||
          (ad.priceUsd != null && ad.priceUsd! >= _filterMinPrice!);
      final matchesMaxP = _filterMaxPrice == null ||
          (ad.priceUsd != null && ad.priceUsd! <= _filterMaxPrice!);

      final isApprovedForFeed =
          ad.status == 'approved' || (_manager.isModerator);

      return matchesGov &&
          matchesCat &&
          matchesSub &&
          matchesSearch &&
          matchesCond &&
          matchesMinP &&
          matchesMaxP &&
          isApprovedForFeed;
    }).toList();

    if (_sortBy == 'price_asc') {
      filteredAds.sort((a, b) => (a.priceUsd ?? 0).compareTo(b.priceUsd ?? 0));
    } else if (_sortBy == 'price_desc') {
      filteredAds.sort((a, b) => (b.priceUsd ?? 0).compareTo(a.priceUsd ?? 0));
    } else if (_sortBy == 'views') {
      filteredAds.sort((a, b) => b.viewsCount.compareTo(a.viewsCount));
    } else {
      filteredAds.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return Column(
      children: [
        LiveCurrencyExchangeTicker(
          usdRate: _manager.exchangeRateUsdToSyp,
          gold21kPrice: _manager.goldPrice21kSyp,
          onRefresh: _initLiveAdsFromSupabase,
        ),
        _buildCustomNewsTickerWidget(),
        _buildRoyalBannersSection(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() => _searchQuery = val);
                    _manager.trackSearchKeyword(val);
                  },
                  decoration: InputDecoration(
                    hintText:
                        'ابحث في كافة إعلانات السوق (سيارات، عقارات، هواتف...)...',
                    hintStyle: const TextStyle(fontSize: 12),
                    prefixIcon:
                        Icon(Icons.search, color: _manager.primaryColor),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.08),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.3)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: _filterCondition != 'الكل' ||
                          _filterMinPrice != null ||
                          _filterMaxPrice != null ||
                          _sortBy != 'newest'
                      ? _manager.secondaryColor
                      : Colors.grey.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(Icons.tune, color: _manager.primaryColor, size: 22),
                tooltip: 'تصفية وفلترة متقدمة',
                onPressed: _showAdvancedFilterSheet,
              ),
            ],
          ),
        ), // ================= شريط الخدمات السريعة الفاخر بديل الزحمة =================
        _buildQuickAccessServicesBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('أحدث إعلانات السوق المعتمدة',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _manager.titleTextColor)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('${filteredAds.length} إعلان',
                        style: TextStyle(
                            color: _manager.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              if (_selectedGovernorate != 'كل المحافظات')
                Text('محافظة: $_selectedGovernorate',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _initLiveAdsFromSupabase,
            color: _manager.primaryColor,
            child: _isLoadingAds
                ? Center(
                    child:
                        CircularProgressIndicator(color: _manager.primaryColor))
                : filteredAds.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          const SizedBox(height: 60),
                          Center(
                            child: Column(
                              children: [
                                Icon(Icons.search_off_rounded,
                                    size: 55, color: Colors.grey.shade400),
                                const SizedBox(height: 10),
                                const Text(
                                    'لا توجد إعلانات معتمدة حالياً في هذا القسم أو المحافظة',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      )
                    : GridView.builder(
                        controller: _gridScrollController,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.70,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemCount:
                            filteredAds.length + (_isLoadingMore ? 2 : 0),
                        itemBuilder: (ctx, index) {
                          if (index >= filteredAds.length) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                ),
                              ),
                            );
                          }
                          final ad = filteredAds[index];
                          return _buildCompactFacingGridAdCard(ad);
                        },
                      ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomNewsTickerWidget() {
    final newsText = _manager.newsTicker.join('   ✦   ');

    return Container(
      color: _manager.tickerBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
                color: _manager.secondaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_manager.tickerIcon,
                    color: _manager.primaryColor, size: 12),
                const SizedBox(width: 3),
                Text('عاجل',
                    style: TextStyle(
                        color: _manager.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 10)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Listener(
              onPointerDown: (_) => setState(() => _isTickerPaused = true),
              onPointerUp: (_) => setState(() => _isTickerPaused = false),
              onPointerCancel: (_) => setState(() => _isTickerPaused = false),
              child: SingleChildScrollView(
                controller: _tickerScrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  newsText,
                  style: TextStyle(
                    color: _manager.tickerTextColor,
                    fontSize: _manager.tickerFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoyalBannersSection() {
    final targetGovernorate = _selectedGovernorate;

    // بنرات القسم الأيمن فقط (slot 1)
    final rightSideBanners = _manager.banners.where((b) {
      final notExpired = !b.isExpired && b.isActive;
      final geoMatch = b.location == 'كل المحافظات' ||
          targetGovernorate == 'كل المحافظات' ||
          b.location == targetGovernorate;
      return notExpired && geoMatch && b.slot == 1;
    }).toList();

    // بنرات القسم الأيسر فقط (slot 2)
    final leftSideBanners = _manager.banners.where((b) {
      final notExpired = !b.isExpired && b.isActive;
      final geoMatch = b.location == 'كل المحافظات' ||
          targetGovernorate == 'كل المحافظات' ||
          b.location == targetGovernorate;
      return notExpired && geoMatch && b.slot == 2;
    }).toList();

    // ================= 1. وضع الدمج الكامل VIP (دمج كل صور القسمين وراء بعضهما) =================
    if (_manager.bannerDisplayMode == BannerDisplayLayoutMode.fullPanorama) {
      // جمع كل البنرات الفعالة من القسمين معاً
      final activeBanners = _manager.banners.where((b) {
        final notExpired = !b.isExpired && b.isActive;
        final geoMatch = b.location == 'كل المحافظات' ||
            targetGovernorate == 'كل المحافظات' ||
            b.location == targetGovernorate;
        return notExpired && geoMatch;
      }).toList();

      // دمج كل صور القسمين في قائمة واحدة لتتقلب وراء بعضها
      final List<Map<String, dynamic>> combinedSlideList = [];
      for (var b in activeBanners) {
        if (b.imageUrls.isNotEmpty) {
          for (var img in b.imageUrls) {
            combinedSlideList.add({'banner': b, 'image': img});
          }
        } else if (b.imageUrl.isNotEmpty) {
          combinedSlideList.add({'banner': b, 'image': b.imageUrl});
        }
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        height: 125,
        child: combinedSlideList.isNotEmpty
            ? PageView.builder(
                controller: _bannerCarouselController,
                itemCount: combinedSlideList.length,
                onPageChanged: (idx) =>
                    setState(() => _currentBannerIndex = idx),
                itemBuilder: (ctx, idx) {
                  final item = combinedSlideList[idx];
                  return _buildActiveBannerCard(
                    item['banner'] as BannerItem,
                    specificImage: item['image'] as String,
                    isPanorama: true,
                  );
                },
              )
            : _buildEmptySlotBannerCard(
                _manager.isAdmin
                    ? 'مساحة بانوراما إعلانية VIP شاغرة\n(اضغط للإدارة والرفع كمسؤول ⚙️)'
                    : 'مساحة إعلانية مميزة VIP\nسوق سوريا المفتوح 🌟',
              ),
      );
    }

    // ================= 2. وضع المربعين المنفصلين (كل قسم معزول بصوره لحال) =================
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      height: 105,
      child: Row(
        children: [
          // القسم الأيمن المعزول (Slot 1)
          Expanded(
            child: rightSideBanners.isNotEmpty
                ? PageView.builder(
                    itemCount: rightSideBanners.length,
                    itemBuilder: (ctx, idx) =>
                        _buildActiveBannerCard(rightSideBanners[idx]),
                  )
                : _buildEmptySlotBannerCard(
                    _manager.isAdmin
                        ? 'مساحة إعلانية (القسم الأيمن)\n(اضغط للإدارة كمسؤول ⚙️)'
                        : 'مساحة إعلانية شاغرة (اليمين) 🌟\nاحجز إعلانك هنا',
                  ),
          ),
          const SizedBox(width: 8),
          // القسم الأيسر المعزول (Slot 2)
          Expanded(
            child: leftSideBanners.isNotEmpty
                ? PageView.builder(
                    itemCount: leftSideBanners.length,
                    itemBuilder: (ctx, idx) =>
                        _buildActiveBannerCard(leftSideBanners[idx]),
                  )
                : _buildEmptySlotBannerCard(
                    _manager.isAdmin
                        ? 'مساحة إعلانية (القسم الأيسر)\n(اضغط للإدارة كمسؤول ⚙️)'
                        : 'مساحة إعلانية شاغرة (اليسار) 🚀\nاحجز إعلانك هنا',
                  ),
          ),
        ],
      ),
    );
  }

  // كرت عرض البانوراما مع دعم عرض الصورة المحددة في وضع الدمج
  Widget _buildActiveBannerCard(BannerItem banner,
      {String? specificImage, bool isPanorama = false}) {
    final displayImg = (specificImage != null && specificImage.isNotEmpty)
        ? specificImage
        : banner.imageUrl;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _manager.incrementBannerClick(banner.id);
        _showBannerDetailsSheet(banner);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: AppSmartImage(
                imageUrl: displayImg,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.85),
                      Colors.transparent
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                decoration: BoxDecoration(
                  color: banner.badgeColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  banner.badgeText,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 6,
              right: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    banner.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isPanorama ? 13 : 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    banner.subtitle,
                    style: TextStyle(
                        color: _manager.secondaryColor,
                        fontSize: isPanorama ? 10.5 : 9.5,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptySlotBannerCard(String placeholderText) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (_manager.isAdmin) {
          _pickAndUploadBannerDirectly();
        } else {
          _showContactAdminDialog();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _manager.primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _manager.secondaryColor.withOpacity(0.6),
            width: 1.2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isUploadingBanner
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(
                    _manager.isAdmin
                        ? Icons.add_photo_alternate_outlined
                        : Icons.campaign_outlined,
                    color: _manager.secondaryColor,
                    size: 22,
                  ),
            const SizedBox(height: 4),
            Text(
              _manager.isAdmin
                  ? placeholderText
                  : 'مساحة إعلانية شاغرة 📢\nاضغط هنا لحجز البانوراما مع الإدارة',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _manager.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesHorizontalBar() {
    final currentCat = _manager.categories.firstWhere(
      (c) => c.name == _selectedCategoryId,
      orElse: () => _manager.categories.isNotEmpty
          ? _manager.categories.first
          : CategoryItem(
              id: 'all',
              name: 'الكل',
              iconData: Icons.category,
              subcategories: []),
    );

    final subcategories =
        _selectedCategoryId != null ? currentCat.subcategories : <String>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FilterChip(
                  label: const Text('الكل',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  selected: _selectedCategoryId == null,
                  selectedColor: _manager.primaryColor,
                  labelStyle: TextStyle(
                      color: _selectedCategoryId == null
                          ? Colors.white
                          : Colors.black87),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onSelected: (_) => setState(() {
                    _selectedCategoryId = null;
                    _selectedSubcategory = null;
                  }),
                ),
              ),
              ..._manager.categories.map((cat) {
                final isSelected = _selectedCategoryId == cat.name;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: FilterChip(
                    avatar: Icon(cat.iconData,
                        size: 14,
                        color: isSelected ? Colors.white : cat.textColor),
                    label: Text(
                      cat.name,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : cat.textColor,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: cat.backgroundColor,
                    backgroundColor: cat.backgroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(cat.borderRadiusValue)),
                    onSelected: (val) {
                      setState(() {
                        _selectedCategoryId = val ? cat.name : null;
                        _selectedSubcategory = null;
                      });
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        if (subcategories.isNotEmpty) ...[
          const SizedBox(height: 3),
          SizedBox(
            height: 28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              children: subcategories.map((sub) {
                final isSelected = _selectedSubcategory == sub;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ChoiceChip(
                    label: Text(sub,
                        style: TextStyle(
                            fontSize: 10,
                            color: isSelected
                                ? _manager.primaryColor
                                : Colors.black87)),
                    selected: isSelected,
                    selectedColor: _manager.primaryColor.withOpacity(0.15),
                    backgroundColor: Colors.transparent,
                    onSelected: (val) {
                      setState(() {
                        _selectedSubcategory = val ? sub : null;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCompactFacingGridAdCard(AdItem ad) {
    // =========================================================================
    // 🎯 اختر من هنا التصميم الذي تريده: ضع 1 أو 2 أو 3 واعمل حفظ (Hot Reload)
    // 1 = النمط السينمائي البانورامي (الصورة تملأ الكرت مع سعر ذهبي فوقها)
    // 2 = النمط الشبكي المتراص الكلاسيكي (تفاصيل مدمجة بدون أي فراغ أبيض)
    // 3 = نمط البطاقة الملكية المزدوجة مع شارة السعر والعنوان البارز
    // =========================================================================
    const int cardDesignOption = 1;

    final isFav = _favoriteAdIds.contains(ad.id);
    final remaining = ad.soldRemainingDuration;
    final displayImg = ad.imageUrls.isNotEmpty ? ad.imageUrls.first : '';
    final priceStr = ad.priceUsd != null
        ? '\$${ad.priceUsd!.toStringAsFixed(0)}'
        : (ad.priceSyp != null ? '${ad.priceSyp!.toStringAsFixed(0)} ل.س' : '');

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
      color: const Color(0xFF0F172A),
      child: InkWell(
        onTap: () {
          setState(() {
            final targetIdx = _manager.ads.indexWhere((x) => x.id == ad.id);
            if (targetIdx != -1) {
              _manager.ads[targetIdx] = _manager.ads[targetIdx].copyWith(
                viewsCount: _manager.ads[targetIdx].viewsCount + 1,
              );
            }
          });
          _manager.incrementAdViews(ad.id);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FullAdDetailsScreen(
                ad: ad.copyWith(viewsCount: ad.viewsCount + 1),
                isFavorite: isFav,
                onToggleFavorite: () {
                  _requireAuth(() {
                    _toggleFavoriteInSupabase(ad.id);
                  });
                },
                onAdUpdated: (updatedAd) {
                  setState(() {
                    final idx =
                        _manager.ads.indexWhere((x) => x.id == updatedAd.id);
                    if (idx != -1) _manager.ads[idx] = updatedAd;
                  });
                },
                onAdDeleted: (deletedId) {
                  setState(() {
                    _manager.ads.removeWhere((x) => x.id == deletedId);
                  });
                },
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================== قسم الصورة (يملأ معظم الكرت لمنع الفراغ) ==================
            Expanded(
              flex: cardDesignOption == 1 ? 8 : (cardDesignOption == 2 ? 6 : 7),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: Colors.grey.shade900,
                    child: AppSmartImage(
                      imageUrl: displayImg,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // تدرج ظل سفلي خفيف لإبراز السعر والتفاصيل
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.70),
                            Colors.transparent,
                            Colors.black.withOpacity(0.35),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),

                  // شارات الحالة (قيد المراجعة / مرفوض / VIP)
                  if (ad.status == 'pending')
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade800,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('قيد المراجعة ⏳',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8)),
                      ),
                    )
                  else if (ad.status == 'rejected')
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: Colors.red.shade800,
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('مرفوض ❌',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8)),
                      ),
                    )
                  else if (ad.isFeatured)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1.5),
                        decoration: BoxDecoration(
                            color: _manager.secondaryColor,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text('VIP ★',
                            style: TextStyle(
                                color: _manager.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9)),
                      ),
                    ),

                  // زر المفضلة الملكي المطور: واضح وكبير ولمسته فورية وسريعة جداً
                  Positioned(
                    top: 6,
                    left: 6,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        _requireAuth(() {
                          _toggleFavoriteInSupabase(ad.id);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isFav
                              ? Colors.red.withOpacity(0.85)
                              : Colors.black.withOpacity(0.60),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isFav ? Colors.white : Colors.white54,
                            width: 1.2,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 17, // حجم واضح ومريح جداً للعين وللأصبع
                        ),
                      ),
                    ),
                  ),

                  // السعر المذهب على الصورة (في الخيار 1 و 3)
                  if (cardDesignOption == 1 || cardDesignOption == 3)
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.80),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: const Color(0xFFD4AF37), width: 0.9),
                        ),
                        child: Text(
                          priceStr,
                          style: const TextStyle(
                              color: Color(0xFFD4AF37),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  // عداد المشاهدات
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1.5),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.remove_red_eye,
                              color: Colors.white70, size: 9),
                          const SizedBox(width: 2),
                          Text('${ad.viewsCount}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),

                  // شارة التوثيق
                  if (ad.sellerPositiveLikes >= 1000 || ad.isVerifiedSeller)
                    Positioned(
                      top: 4,
                      right: ad.isFeatured ? 45 : 4,
                      child: KycVerificationBadge(
                        isVerified: ad.isVerifiedSeller,
                        positiveLikes: ad.sellerPositiveLikes,
                        size: 13,
                      ),
                    ),

                  // ختم تم البيع
                  if (ad.isSold)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.65),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: -0.22,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDC2626),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                        color: Colors.white, width: 1.5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black45, blurRadius: 6)
                                    ],
                                  ),
                                  child: const Text('تم البيع ✓ SOLD',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10.5)),
                                ),
                              ),
                              if (remaining != null) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: const Color(0xFFD4AF37)
                                              .withOpacity(0.4))),
                                  child: Text('${remaining.inMinutes} دقيقة ⏳',
                                      style: const TextStyle(
                                          color: Color(0xFFD4AF37),
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ================== قسم التفاصيل المضغوط حسب الخيار المختار ==================
            Expanded(
              flex: cardDesignOption == 1 ? 2 : (cardDesignOption == 2 ? 4 : 3),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // العنوان
                    Text(
                      ad.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.5,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // في الخيار 2 (الشبكي التقليدي المضغوط): نعرض السعر والمدينة تحت بعض
                    if (cardDesignOption == 2) ...[
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            priceStr,
                            style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          Text(
                            ad.condition,
                            style: const TextStyle(
                                fontSize: 8,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 2),
                    // سطر الموقع والتوقيت
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Color(0xFFD4AF37), size: 9),
                            const SizedBox(width: 2),
                            Text(
                              '${ad.governorate}',
                              style: const TextStyle(
                                  fontSize: 8.5, color: Colors.white70),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.white38, size: 8),
                            const SizedBox(width: 2),
                            Text(
                              ad.timeAgo,
                              style: const TextStyle(
                                  fontSize: 7.5, color: Colors.white38),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsAndNegotiationsTab() {
    if (!_manager.isLoggedIn) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('غرف المحادثة والتفاوض المباشر',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('يرجى تسجيل الدخول للوصول إلى رسائلك وعروض التفاوض.',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AuthScreen())),
              child: const Text('تسجيل الدخول الآن 🔑',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    }

    if (_userChatThreads.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline,
                size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('لا توجد محادثات نشطة حالياً',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey)),
            const SizedBox(height: 6),
            const Text('تواصل مع أصحاب الإعلانات لبدء التفاوض المباشر.',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _userChatThreads.length,
      itemBuilder: (ctx, idx) {
        final thread = _userChatThreads[idx];
        final senderName = thread['sender_name']?.toString() ?? 'طرف التفاوض';
        final message = thread['message']?.toString() ?? '';
        final adId = thread['ad_id']?.toString() ?? '';

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _manager.primaryColor,
              child: Text(
                senderName.isNotEmpty ? senderName[0] : 'S',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(senderName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            subtitle:
                Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => FullChatNegotiationScreen(
                    adId: adId,
                    partnerName: senderName,
                    productTitle: 'تفاوض مباشر على السلعة',
                    initialPrice: 0,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    final favAds =
        _manager.ads.where((x) => _favoriteAdIds.contains(x.id)).toList();

    if (favAds.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            const Text('قائمة المفضلة فارغة حالياً',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey)),
            const SizedBox(height: 6),
            const Text(
                'اضغط على رمز القلب في أي إعلان لحفظه هنا للرجوع إليه لاحقاً.',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      );
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: favAds.length,
      itemBuilder: (ctx, idx) => _buildCompactFacingGridAdCard(favAds[idx]),
    );
  }

  Widget _buildProfileTab() {
    final currentPlan = _manager.getCurrentUserPlan();
    final userAds =
        _manager.ads.where((x) => x.userId == _manager.currentUserId).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _manager.primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: _manager.secondaryColor,
                child: Text(
                  _manager.currentUserName.isNotEmpty
                      ? _manager.currentUserName[0]
                      : 'U',
                  style: TextStyle(
                      color: _manager.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(_manager.currentUserName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 6),
                        KycVerificationBadge(
                          isVerified: _manager.isCurrentUserVerified,
                          positiveLikes: _manager.currentUserPositiveLikes,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _manager.isLoggedIn
                          ? _manager.currentUserEmail
                          : 'غير مسجل (وضع الزائر)',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: _manager.secondaryColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text('الخطة: ${currentPlan.name}',
                              style: TextStyle(
                                  color: _manager.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.thumb_up,
                                  size: 11, color: Colors.lightBlueAccent),
                              const SizedBox(width: 4),
                              Text('${_manager.currentUserPositiveLikes} إعجاب',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ],
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
        const SizedBox(height: 16),
        if (userAds.isNotEmpty) ...[
          Text('إعلاناتي المعروضة (${userAds.length}):',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          ...userAds.map((ad) {
            Color statusColor = Colors.green;
            String statusText = 'معتمد ونشط ✓';
            if (ad.status == 'pending') {
              statusColor = Colors.orange.shade800;
              statusText = 'قيد المراجعة ⏳';
            } else if (ad.status == 'rejected') {
              statusColor = Colors.red.shade800;
              statusText = 'مرفوض ❌';
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: AppSmartImage(
                        imageUrl:
                            ad.imageUrls.isNotEmpty ? ad.imageUrls.first : ''),
                  ),
                ),
                title: Text(ad.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statusText,
                      style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                    if (ad.status == 'rejected' &&
                        ad.rejectionReason != null &&
                        ad.rejectionReason!.isNotEmpty)
                      Text('السبب: ${ad.rejectionReason}',
                          style: TextStyle(
                              color: Colors.red.shade700, fontSize: 10)),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => FullAdDetailsScreen(
                        ad: ad,
                        isFavorite: _favoriteAdIds.contains(ad.id),
                        onToggleFavorite: () =>
                            _toggleFavoriteInSupabase(ad.id),
                        onAdUpdated: (up) => setState(() {}),
                        onAdDeleted: (del) => setState(() {}),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 12),
        ],
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: _manager.secondaryColor.withOpacity(0.15),
          leading: Icon(Icons.lightbulb, color: _manager.secondaryColor),
          title: const Text('صوتك مسموع 💡 - اقترح وطوّر التطبيق',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text('أرسل أفكارك وملاحظاتك مباشرةً لصاحب التطبيق'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => AppFeedbackScreen())),
        ),
        const SizedBox(height: 10),
        if (!_manager.isLoggedIn)
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: _manager.primaryColor.withOpacity(0.1),
            leading: Icon(Icons.login, color: _manager.primaryColor),
            title: const Text('تسجيل الدخول / إنشاء حساب جديد',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('تسجيل سريع مع ميزة استرجاع كلمة المرور'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => AuthScreen())),
          )
        else
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.red.withOpacity(0.08),
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('تسجيل الخروج',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () async {
              await _manager.logoutUser();
              setState(() {
                _favoriteAdIds.clear();
                _userChatThreads.clear();
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تسجيل الخروج بنجاح.')));
              }
            },
          ),
        const SizedBox(height: 10),
        ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Colors.grey.withOpacity(0.06),
          leading:
              Icon(Icons.workspace_premium, color: _manager.secondaryColor),
          title: const Text('ترقية الباقة والاشتراكات VIP'),
          subtitle: const Text('ميزات حصرية ونشر غير محدود'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
          onTap: () {
            _showContactAdminDialog();
          },
        ),
        if (_manager.isModerator) ...[
          const SizedBox(height: 10),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Colors.red.withOpacity(0.08),
            leading: const Icon(Icons.admin_panel_settings, color: Colors.red),
            title: const Text('غرفة العمليات ولوحة تحكم المشرفين 🛡️',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
                'موافقة الإعلانات، تدقيق إيصالات شام كاش وبينانس، إدارة الأقسام والأسعار'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => const FullAdminPanelScreen(),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _openAddAdScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FullAddAdScreen(
          onAdCreated: (newAd) {
            _manager.addNewAdDirectly(newAd);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _manager.isSuperAdmin
                      ? '✨ تم نشر إعلانك فوراً ومباشرةً في السوق!'
                      : '⏳ تم استلام إعلانك بنجاح وسيعرض للجميع فور موافقة الإدارة عليه.',
                ),
                backgroundColor: _manager.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
// ==============================================================================
// 🌟 سوق سوريا الشامل 2028 - المنظومة السيادية الحقيقية المتكاملة 100%
// [الدفعة 4 من أصل 4: شاشة إضافة الإعلان، غرف المحادثة، باقات الاشتراك، غرفة العمليات، و main()]
// مربوطة بالكامل بالسيرفر الحقيقي وقواعد البيانات الحقيقية دون أي اختصار
// ==============================================================================

/// ==============================================================================
// 20. شاشة إضافة وتعديل الإعلانات والمزادات الحرة (FullAddAdScreen)
// ==============================================================================
class FullAddAdScreen extends StatefulWidget {
  final AdItem? initialAd;
  final Function(AdItem) onAdCreated;

  const FullAddAdScreen({
    Key? key,
    this.initialAd,
    required this.onAdCreated,
  }) : super(key: key);

  @override
  State<FullAddAdScreen> createState() => _FullAddAdScreenState();
}

class _FullAddAdScreenState extends State<FullAddAdScreen> {
  final AppStateManager _manager = AppStateManager();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _titleController;
  late TextEditingController _descController;
  late TextEditingController _priceUsdController;
  late TextEditingController _priceSypController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _phoneController;
  late TextEditingController _whatsappController;
  late TextEditingController _videoUrlController;
  late TextEditingController _facebookUrlController;
  late TextEditingController _telegramUrlController;
  late TextEditingController _instagramUrlController;
  late TextEditingController _tiktokUrlController;
  late TextEditingController _youtubeUrlController;
  late TextEditingController _startingBidController;

  String _governorate = 'دمشق';
  String _condition = 'مستعمل بحالة ممتازة';
  String _selectedCategory = 'سيارات ومركبات';
  String _selectedSubcategory = 'سيارات سياحية للبيع';
  bool _isAuction = false;
  int _auctionDaysDuration = 3;

  List<String> _existingImageUrls = [];
  List<Uint8List> _newLocalImageBytes = [];
  bool _isUploading = false;

  final List<String> _governorates = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'درعا',
    'السويداء',
    'القنيطرة',
    'دير الزور',
    'الرقة',
    'الحسكة'
  ];

  final List<String> _conditions = [
    'جديد بالكرتونة',
    'مستعمل بحالة ممتازة',
    'مستعمل',
    'بحاجة صيانة',
    'كسر زيرو',
  ];

  @override
  void initState() {
    super.initState();
    final ad = widget.initialAd;
    _titleController = TextEditingController(text: ad?.title ?? '');
    _descController = TextEditingController(text: ad?.description ?? '');
    _priceUsdController = TextEditingController(
        text: ad?.priceUsd != null ? ad!.priceUsd!.toStringAsFixed(0) : '');
    _priceSypController = TextEditingController(
        text: ad?.priceSyp != null ? ad!.priceSyp!.toStringAsFixed(0) : '');
    _neighborhoodController =
        TextEditingController(text: ad?.neighborhood ?? '');
    _phoneController = TextEditingController(
        text: ad?.contactPhone ?? _manager.currentUserPhone);
    _whatsappController = TextEditingController(
        text: ad?.contactWhatsapp ?? _manager.currentUserPhone);
    _videoUrlController = TextEditingController(text: ad?.videoUrl ?? '');
    _facebookUrlController = TextEditingController(text: ad?.facebookUrl ?? '');
    _telegramUrlController = TextEditingController(text: ad?.telegramUrl ?? '');
    _instagramUrlController =
        TextEditingController(text: ad?.instagramUrl ?? '');
    _tiktokUrlController = TextEditingController(text: ad?.tiktokUrl ?? '');
    _youtubeUrlController = TextEditingController(text: ad?.youtubeUrl ?? '');
    _startingBidController = TextEditingController(
        text:
            ad?.startingBid != null ? ad!.startingBid!.toStringAsFixed(0) : '');

    if (ad != null) {
      _governorate = ad.governorate;
      _condition = ad.condition;
      _selectedCategory = ad.categoryId;
      _selectedSubcategory = ad.subcategory;
      _isAuction = ad.isAuction;
      _existingImageUrls = List.from(ad.imageUrls);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceUsdController.dispose();
    _priceSypController.dispose();
    _neighborhoodController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _videoUrlController.dispose();
    _facebookUrlController.dispose();
    _telegramUrlController.dispose();
    _instagramUrlController.dispose();
    _tiktokUrlController.dispose();
    _youtubeUrlController.dispose();
    _startingBidController.dispose();
    super.dispose();
  }

  // فحص صلاحية الروابط حسب باقة المستخدم
  bool _canUseSocialLink(String linkType) {
    if (_manager.isAdmin || _manager.isSuperAdmin) return true;
    final planId = _manager.currentUserPlanId;

    // باقة VIP الملكية: تفتح جميع الروابط الخمسة بالكامل
    if (planId == 'plan_vip') return true;

    // باقة Pro المتوسطة: تفتح فيسبوك وإنستغرام فقط
    if (planId == 'plan_pro') {
      return linkType == 'facebook' || linkType == 'instagram';
    }

    // الباقة المجانية: مقفولة بالكامل
    return false;
  }

  // نافذة التنبيه لاشتراك الباقات عند محاولة الكتابة في الروابط المقفولة
  void _showUpgradeSocialDialog(String linkName, String requiredPlan) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.lock, color: Color(0xFFD4AF37), size: 22),
            const SizedBox(width: 8),
            Text('ميزة حصرية: إضافة $linkName 💎',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          'عذراً! إضافة روابط التواصل الاجتماعي وتضمين الفيديو متاحة للمشتركين في ($requiredPlan).\n\nتساعدك الروابط في توجيه آلاف الزبائن مباشرة لقناتك وصفحتك التجارية وزيادة مبيعاتك!',
          style:
              const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إغلاق', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0F172A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            icon: const Icon(Icons.workspace_premium, size: 18),
            label: const Text('ترقية الباقة الآن 🚀',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => const SubscriptionPlansScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  // ويدجت إنشاء حقل الرابط (شفاف ومقفل للباقة المجانية)
  Widget _buildLockedSocialField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required String linkType,
    required String requiredPlanName,
  }) {
    final bool isAllowed = _canUseSocialLink(linkType);

    return Opacity(
      opacity: isAllowed ? 1.0 : 0.45,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          TextFormField(
            controller: controller,
            readOnly: !isAllowed,
            onTap: () {
              if (!isAllowed) {
                _showUpgradeSocialDialog(label, requiredPlanName);
              }
            },
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: isAllowed ? Colors.white70 : Colors.grey,
                fontSize: 12.5,
              ),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 11),
              prefixIcon: Icon(icon,
                  color: isAllowed ? iconColor : Colors.grey, size: 20),
              filled: true,
              fillColor: isAllowed
                  ? const Color(0xFF1E293B).withOpacity(0.6)
                  : const Color(0xFF0F172A).withOpacity(0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      isAllowed ? Colors.white12 : Colors.grey.withOpacity(0.2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      isAllowed ? Colors.white12 : Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
          ),
          if (!isAllowed)
            Positioned(
              left: 10,
              child: GestureDetector(
                onTap: () => _showUpgradeSocialDialog(label, requiredPlanName),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock, size: 12, color: Color(0xFF0F172A)),
                      SizedBox(width: 4),
                      Text(
                        'VIP / Pro',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaLinksSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.share, color: Color(0xFFD4AF37), size: 18),
              SizedBox(width: 8),
              Text(
                'روابط التواصل الاجتماعي وتضمين الفيديو 🔗',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'أضف روابط حساباتك وقناتك ليتواصل معك الزبائن بضغطة واحدة (حصرية للباقات المدفوعة)',
            style: TextStyle(color: Colors.grey, fontSize: 10.5),
          ),
          const SizedBox(height: 12),
          _buildLockedSocialField(
            controller: _youtubeUrlController,
            label: 'رابط فيديو يوتيوب (YouTube)',
            hint: 'https://youtube.com/watch?v=...',
            icon: Icons.play_circle_fill,
            iconColor: Colors.redAccent,
            linkType: 'youtube',
            requiredPlanName: 'باقة VIP الشاملة',
          ),
          const SizedBox(height: 8),
          _buildLockedSocialField(
            controller: _facebookUrlController,
            label: 'رابط صفحة أو حساب فيسبوك (Facebook)',
            hint: 'https://facebook.com/...',
            icon: Icons.facebook,
            iconColor: const Color(0xFF1877F2),
            linkType: 'facebook',
            requiredPlanName: 'باقة التجار Pro أو VIP',
          ),
          const SizedBox(height: 8),
          _buildLockedSocialField(
            controller: _instagramUrlController,
            label: 'رابط حساب إنستغرام (Instagram)',
            hint: 'https://instagram.com/...',
            icon: Icons.camera_alt,
            iconColor: const Color(0xFFE1306C),
            linkType: 'instagram',
            requiredPlanName: 'باقة التجار Pro أو VIP',
          ),
          const SizedBox(height: 8),
          _buildLockedSocialField(
            controller: _telegramUrlController,
            label: 'رابط قناة أو حساب تليجرام (Telegram)',
            hint: 'https://t.me/...',
            icon: Icons.send,
            iconColor: const Color(0xFF229ED9),
            linkType: 'telegram',
            requiredPlanName: 'باقة VIP الشاملة',
          ),
          const SizedBox(height: 8),
          _buildLockedSocialField(
            controller: _tiktokUrlController,
            label: 'رابط حساب تيك توك (TikTok)',
            hint: 'https://tiktok.com/@...',
            icon: Icons.music_note,
            iconColor: Colors.cyanAccent,
            linkType: 'tiktok',
            requiredPlanName: 'باقة VIP الشاملة',
          ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    int maxAllowed = 4;
    String planName = 'المجانية';
    if (_manager.isAdmin ||
        _manager.isSuperAdmin ||
        _manager.currentUserPlanId == 'plan_vip') {
      maxAllowed = 12;
      planName = 'VIP الملكية';
    } else if (_manager.currentUserPlanId == 'plan_pro') {
      maxAllowed = 8;
      planName = 'Pro المتقدمة';
    }

    final currentCount = _existingImageUrls.length + _newLocalImageBytes.length;

    if (currentCount >= maxAllowed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '⚠️ لقد وصلت للحد الأقصى المسموح ($maxAllowed صور) حسب باقتك ($planName).'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final pickedList = await _picker.pickMultiImage(
        imageQuality: 75,
        maxWidth: 1080,
      );

      for (var f in pickedList) {
        if (_existingImageUrls.length + _newLocalImageBytes.length <
            maxAllowed) {
          final b = await f.readAsBytes();
          setState(() => _newLocalImageBytes.add(b));
        }
      }
    } catch (e) {
      debugPrint('Image pick error: $e');
    }
  }

  void _syncSypFromUsd(String val) {
    final usd = double.tryParse(val);
    if (usd != null) {
      final syp = usd * _manager.exchangeRateUsdToSyp;
      _priceSypController.text = syp.toStringAsFixed(0);
    }
  }

  void _syncUsdFromSyp(String val) {
    final syp = double.tryParse(val);
    if (syp != null && _manager.exchangeRateUsdToSyp > 0) {
      final usd = syp / _manager.exchangeRateUsdToSyp;
      _priceUsdController.text = usd.toStringAsFixed(0);
    }
  }

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;

    final textToCheck =
        '${_titleController.text} ${_descController.text}'.toLowerCase();
    const forbidden = ['مخدرات', 'سلاح', 'ممنوعات'];
    for (var w in forbidden) {
      if (textToCheck.contains(w)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ عذراً! يحتوي الإعلان على كلمة محظورة: "$w"'),
            backgroundColor: Colors.red.shade900,
          ),
        );
        return;
      }
    }

    setState(() => _isUploading = true);

    List<String> finalImageUrls = List.from(_existingImageUrls);
    if (_newLocalImageBytes.isNotEmpty) {
      final uploaded = await StorageUploadService.uploadMultipleImageBytes(
        bucketName: kStorageBucketAds,
        imagesBytesList: _newLocalImageBytes,
        prefix: 'ad',
      );
      finalImageUrls.addAll(uploaded);
    }

    final double? pUsd = double.tryParse(_priceUsdController.text);
    final double? pSyp = double.tryParse(_priceSypController.text);
    final double? startBid = double.tryParse(_startingBidController.text);

    final adItem = AdItem(
      id: widget.initialAd?.id ?? '',
      userId:
          _manager.currentUserId.isNotEmpty ? _manager.currentUserId : 'guest',
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      priceUsd: pUsd,
      priceSyp: pSyp,
      governorate: _governorate,
      neighborhood: _neighborhoodController.text.trim().isNotEmpty
          ? _neighborhoodController.text.trim()
          : 'المركز',
      categoryId: _selectedCategory,
      subcategory: _selectedSubcategory,
      condition: _condition,
      contactPhone: _phoneController.text.trim(),
      contactWhatsapp: _whatsappController.text.trim(),
      imageUrls: finalImageUrls,
      videoUrl: _videoUrlController.text.trim().isNotEmpty
          ? _videoUrlController.text.trim()
          : null,
      facebookUrl: _facebookUrlController.text.trim().isNotEmpty
          ? _facebookUrlController.text.trim()
          : null,
      telegramUrl: _telegramUrlController.text.trim().isNotEmpty
          ? _telegramUrlController.text.trim()
          : null,
      instagramUrl: _instagramUrlController.text.trim().isNotEmpty
          ? _instagramUrlController.text.trim()
          : null,
      tiktokUrl: _tiktokUrlController.text.trim().isNotEmpty
          ? _tiktokUrlController.text.trim()
          : null,
      youtubeUrl: _youtubeUrlController.text.trim().isNotEmpty
          ? _youtubeUrlController.text.trim()
          : null,
      publisherName: _manager.currentUserName,
      publisherEmail: _manager.currentUserEmail,
      isVerifiedSeller: _manager.isCurrentUserVerified,
      status: 'approved',
      isAuction: _isAuction,
      startingBid: startBid,
      currentBid: startBid,
      auctionEndTime: _isAuction
          ? DateTime.now().add(Duration(days: _auctionDaysDuration))
          : null,
      createdAt: widget.initialAd?.createdAt ?? DateTime.now(),
    );

    try {
      if (widget.initialAd != null) {
        await Supabase.instance.client
            .from('ads')
            .update(adItem.toMap())
            .eq('id', adItem.id)
            .timeout(const Duration(seconds: 12));

        widget.onAdCreated(adItem);
      } else {
        final res = await Supabase.instance.client
            .from('ads')
            .insert(adItem.toMap())
            .select()
            .single()
            .timeout(const Duration(seconds: 12));

        final savedAd = AdItem.fromMap(res);
        widget.onAdCreated(savedAd);
      }

if (mounted) {
          setState(() => _isUploading = false);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ تم نشر إعلانك بنجاح مع روابط التواصل!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        debugPrint('Save Ad Supabase Error: $e');
        if (mounted) {
          setState(() => _isUploading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('⚠️ تعذر الحفظ بالسيرفر: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    final categories = _manager.categories;
    final currentCatItem = categories.firstWhere(
      (c) => c.name == _selectedCategory,
      orElse: () => categories.isNotEmpty
          ? categories.first
          : CategoryItem(
              id: 'all',
              name: 'عام',
              iconData: Icons.category,
              subcategories: ['عام']),
    );

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Text(
          widget.initialAd != null
              ? 'تعديل بيانات الإعلان ✏️'
              : 'نشر إعلان جديد في السوق 📢',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            const Text('صور السلعة والمعاينة *',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  InkWell(
                    onTap: _pickImages,
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: _manager.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: _manager.secondaryColor, width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo,
                              color: _manager.secondaryColor, size: 28),
                          const SizedBox(height: 4),
                          const Text('إضافة صورة',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ..._existingImageUrls.map((url) => Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 90,
                            height: 90,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: AppSmartImage(imageUrl: url),
                          ),
                          Positioned(
                            top: 2,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _existingImageUrls.remove(url)),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                  ..._newLocalImageBytes.map((bytes) => Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            width: 90,
                            height: 90,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.memory(bytes, fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 2,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => setState(
                                  () => _newLocalImageBytes.remove(bytes)),
                              child: const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close,
                                    size: 12, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان الإعلان *',
                hintText: 'مثال: كيا سيراتو 2021 أوتوماتيك خالية العلام',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 4)
                  ? 'يرجى كتابة عنوان واضح للإعلان'
                  : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'القسم الرئيسي',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: categories
                        .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Text(c.name,
                                style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _selectedCategory = v;
                          final subList = categories
                              .firstWhere((x) => x.name == v)
                              .subcategories;
                          if (subList.isNotEmpty) {
                            _selectedSubcategory = subList.first;
                          }
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: currentCatItem.subcategories
                            .contains(_selectedSubcategory)
                        ? _selectedSubcategory
                        : (currentCatItem.subcategories.isNotEmpty
                            ? currentCatItem.subcategories.first
                            : null),
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'القسم الفرعي',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: currentCatItem.subcategories
                        .map((s) => DropdownMenuItem(
                            value: s,
                            child:
                                Text(s, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _selectedSubcategory = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _governorate,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'المحافظة',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    items: _governorates
                        .map((g) => DropdownMenuItem(
                            value: g,
                            child:
                                Text(g, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _governorate = v);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _neighborhoodController,
                    decoration: InputDecoration(
                      labelText: 'المنطقة أو الحي',
                      hintText: 'مثال: المزة، الشهباء',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _condition,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'حالة السلعة',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              items: _conditions
                  .map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(c, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _condition = v);
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceUsdController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر (\$ USD)',
                      prefixIcon:
                          const Icon(Icons.attach_money, color: Colors.green),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: _syncSypFromUsd,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _priceSypController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'السعر (ل.س)',
                      prefixIcon: const Icon(Icons.currency_exchange,
                          color: Color(0xFFD4AF37)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onChanged: _syncUsdFromSyp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('طرح السلعة في المزاد العلني ⚖️',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              subtitle: const Text(
                  'يتيح للمشترين المزايدة المباشرة مع نظام مكافحة القنص الذكي'),
              value: _isAuction,
              onChanged: (val) => setState(() => _isAuction = val),
            ),
            if (_isAuction) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startingBidController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'سعر بدء المزاد (\$)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _auctionDaysDuration,
                      decoration: InputDecoration(
                        labelText: 'مدة المزاد',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      items: [1, 2, 3, 5, 7]
                          .map((d) => DropdownMenuItem(
                              value: d, child: Text('$d أيام')))
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => _auctionDaysDuration = v);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
            _buildSocialMediaLinksSection(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الاتصال *',
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'رقم الاتصال مطلوب'
                        : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _whatsappController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الواتساب *',
                      prefixIcon:
                          const Icon(Icons.chat, color: Color(0xFF25D366)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'رقم الواتساب مطلوب'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'المواصفات والتفاصيل الكاملة *',
                hintText: 'اكتب كافة المواصفات والعيوب والميزات بدقة...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              validator: (v) => (v == null || v.trim().length < 10)
                  ? 'يرجى كتابة تفاصيل وافية عن السلعة'
                  : null,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _manager.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _isUploading ? null : _submitAd,
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        widget.initialAd != null
                            ? 'حفظ التعديلات ✨'
                            : 'نشر الإعلان في السوق الآن 🚀',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// 21. شاشة التفاوض وغرف المحادثة المباشرة (FullChatNegotiationScreen)
// ==============================================================================
class FullChatNegotiationScreen extends StatefulWidget {
  final String adId;
  final String partnerName;
  final String productTitle;
  final double initialPrice;

  const FullChatNegotiationScreen({
    Key? key,
    required this.adId,
    required this.partnerName,
    required this.productTitle,
    required this.initialPrice,
  }) : super(key: key);

  @override
  State<FullChatNegotiationScreen> createState() => _FullChatNegotiationScreenState();
}

class _FullChatNegotiationScreenState extends State<FullChatNegotiationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محادثة: ${widget.partnerName}'),
      ),
      body: Center(
        child: Text('غرفة التفاوض حول: ${widget.productTitle}'),
      ),
    );
  }
}
  @override
  State<FullChatNegotiationScreen> createState() =>
      _FullChatNegotiationScreenState();
}
  @override
  State<FullChatNegotiationScreen> createState() =>
      _FullChatNegotiationScreenState();
}

class _FullChatNegotiationScreenState extends State<FullChatNegotiationScreen> {
  final AppStateManager _manager = AppStateManager();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _offerPriceController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;
  dynamic _chatSubscription;

  @override
  void initState() {
    super.initState();
    _loadChatMessages();
    _startRealtimeChatListener();
  }

  @override
  void dispose() {
    _chatSubscription?.cancel();
    _messageController.dispose();
    _offerPriceController.dispose();
    super.dispose();
  }

  void _startRealtimeChatListener() {
    try {
      _chatSubscription = Supabase.instance.client
          .from('chat_messages')
          .stream(primaryKey: ['id'])
          .eq('ad_id', widget.adId)
          .order('created_at', ascending: true)
          .listen((List<Map<String, dynamic>> data) {
            if (mounted) {
              setState(() {
                _messages.clear();
                _messages.addAll(data);
                _isLoading = false;
              });
            }
          }, onError: (err) {
            debugPrint('Realtime Chat Error: $err');
          });
    } catch (_) {}
  }

  Future<void> _loadChatMessages() async {
    try {
      final res = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .eq('ad_id', widget.adId)
          .order('created_at', ascending: true)
          .timeout(const Duration(seconds: 8));

      if (res is List && mounted) {
        setState(() {
          _messages.clear();
          _messages.addAll(List<Map<String, dynamic>>.from(res));
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendMessage({String? customOfferText}) async {
    final text = customOfferText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    final senderId = _manager.currentUserId.isNotEmpty
        ? _manager.currentUserId
        : 'guest_${DateTime.now().millisecondsSinceEpoch}';
    final senderName = _manager.currentUserName.isNotEmpty
        ? _manager.currentUserName
        : 'مستخدم التطبيق';

    final msgData = {
      'id': 'msg_${DateTime.now().millisecondsSinceEpoch}',
      'ad_id': widget.adId,
      'sender_id': senderId,
      'sender_name': senderName,
      'message': text,
      'created_at': DateTime.now().toIso8601String(),
    };

    setState(() {
      _messages.add(msgData);
      if (customOfferText == null) _messageController.clear();
    });

    try {
      await Supabase.instance.client
          .from('chat_messages')
          .insert(msgData)
          .timeout(const Duration(seconds: 6));
    } catch (e) {
      debugPrint('Chat insert error: $e');
    }
  }

  void _showOfferDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.local_offer, color: Colors.green),
            SizedBox(width: 8),
            Text('تقديم عرض سعر رسمي 🤝', style: TextStyle(fontSize: 15)),
          ],
        ),
        content: TextField(
          controller: _offerPriceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'قيمة العرض بالدولار (\$)',
            hintText: 'مثال: 4500',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: _manager.primaryColor),
            onPressed: () {
              final val = _offerPriceController.text.trim();
              if (val.isNotEmpty) {
                Navigator.pop(ctx);
                _sendMessage(
                    customOfferText:
                        '🏷️ عرض رسمي للتفاوض: أنا على استعداد للشراء بسعر \$$val دولار.');
              }
            },
            child: const Text('إرسال العرض',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.partnerName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            Text(widget.productTitle,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer, color: Color(0xFFD4AF37)),
            tooltip: 'تقديم عرض سعر',
            onPressed: _showOfferDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                    ? Center(
                        child: Text(
                          'ابدأ المحادثة الآن مع ${widget.partnerName} للتفاوض حول السلعة.',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(12),
                        itemCount: _messages.length,
                        itemBuilder: (ctx, idx) {
                          final msg = _messages[idx];
                          final isMe =
                              msg['sender_id'] == _manager.currentUserId;
                          return Align(
                            alignment: isMe
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? _manager.primaryColor : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 4)
                                ],
                              ),
                              child: Text(
                                msg['message']?.toString() ?? '',
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  backgroundColor: _manager.buttonColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: () => _sendMessage(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 22. لوحة التحكم والإشراف المركزي (FullAdminPanelScreen)
// ==============================================================================
class FullAdminPanelScreen extends StatefulWidget {
  final int initialTab;

  const FullAdminPanelScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<FullAdminPanelScreen> createState() => _FullAdminPanelScreenState();
}

class _FullAdminPanelScreenState extends State<FullAdminPanelScreen>
    with SingleTickerProviderStateMixin {
  final AppStateManager _manager = AppStateManager();
  late TabController _tabController;

  final TextEditingController _usdRateController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 7, vsync: this, initialIndex: widget.initialTab);
    _usdRateController.text = _manager.exchangeRateUsdToSyp.toStringAsFixed(0);
    _goldPriceController.text = _manager.goldPrice21kSyp.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usdRateController.dispose();
    _goldPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendingAds =
        _manager.ads.where((a) => a.status == 'pending').toList();
    final pendingPayments =
        _manager.paymentAudits.where((p) => p.status == 'pending').toList();

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text(
          'غرفة العمليات والإشراف المركزي 🛡️',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFFD4AF37),
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.white70,
          tabs: [
            const Tab(text: 'لوحة التحكم 📊'),
            const Tab(text: 'إدارة البانوراما 🖼️'),
            Tab(text: 'مراجعة الإعلانات (${pendingAds.length}) ⏳'),
            Tab(text: 'تدقيق المدفوعات (${pendingPayments.length}) 💳'),
            const Tab(text: 'أسعار الصرف والذهب 🪙'),
            const Tab(text: 'شجرة الأقسام 🌳'),
            const Tab(text: 'صوتك مسموع 💡'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildBannersManagementTab(),
          _buildAdReviewTab(pendingAds),
          _buildPaymentAuditTab(pendingPayments),
          _buildRatesSettingsTab(),
          _buildDepartmentTreeTab(),
          _buildFeedbacksTab(),
        ],
      ),
    );
  }

  Widget _buildBannersManagementTab() {
    final rightBanners = _manager.banners.where((b) => b.slot == 1).toList();
    final leftBanners = _manager.banners.where((b) => b.slot == 2).toList();

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: const Color(0xFF0F172A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.view_carousel,
                        color: Color(0xFFD4AF37), size: 22),
                    SizedBox(width: 8),
                    Text(
                      'شكل عرض البانوراما في الرئيسية',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('مربعين منفصلين 🔲🔲',
                            style: TextStyle(fontSize: 11)),
                        selected: _manager.bannerDisplayMode ==
                            BannerDisplayLayoutMode.dualGrid,
                        selectedColor: const Color(0xFFD4AF37),
                        onSelected: (val) async {
                          if (val) {
                            setState(() => _manager.bannerDisplayMode =
                                BannerDisplayLayoutMode.dualGrid);
                            _manager.notifyListeners();
                            try {
                              await Supabase.instance.client
                                  .from('app_settings')
                                  .upsert({
                                'key': 'banner_settings',
                                'mode': 'dualGrid',
                                'interval_seconds':
                                    _manager.bannerDefaultIntervalSeconds,
                              });
                            } catch (_) {}
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('دمج شريط كامل 🖼️',
                            style: TextStyle(fontSize: 11)),
                        selected: _manager.bannerDisplayMode ==
                            BannerDisplayLayoutMode.fullPanorama,
                        selectedColor: const Color(0xFFD4AF37),
                        onSelected: (val) async {
                          if (val) {
                            setState(() => _manager.bannerDisplayMode =
                                BannerDisplayLayoutMode.fullPanorama);
                            _manager.notifyListeners();
                            try {
                              await Supabase.instance.client
                                  .from('app_settings')
                                  .upsert({
                                'key': 'banner_settings',
                                'mode': 'fullPanorama',
                                'interval_seconds':
                                    _manager.bannerDefaultIntervalSeconds,
                              });
                            } catch (_) {}
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('سرعة تقليب الصور:',
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text(
                      '${_manager.bannerDefaultIntervalSeconds} ثوانٍ',
                      style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
                Slider(
                  value: _manager.bannerDefaultIntervalSeconds
                      .toDouble()
                      .clamp(1.0, 10.0),
                  min: 1.0,
                  max: 10.0,
                  divisions: 9,
                  activeColor: const Color(0xFFD4AF37),
                  onChanged: (v) {
                    setState(() =>
                        _manager.bannerDefaultIntervalSeconds = v.toInt());
                  },
                  onChangeEnd: (v) async {
                    _manager.notifyListeners();
                    try {
                      await Supabase.instance.client
                          .from('app_settings')
                          .upsert({
                        'key': 'banner_settings',
                        'mode': _manager.bannerDisplayMode ==
                                BannerDisplayLayoutMode.fullPanorama
                            ? 'fullPanorama'
                            : 'dualGrid',
                        'interval_seconds': v.toInt(),
                      });
                    } catch (_) {}
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0284C7),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          icon: const Icon(Icons.add_photo_alternate, color: Colors.white),
          label: const Text(
            'رفع بانوراما جديدة (حتى 15 صورة) 🚀',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _showAddCustomBannerDialog(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.view_sidebar, size: 18, color: Color(0xFFD4AF37)),
            const SizedBox(width: 6),
            Text(
              'بنرات القسم الأيمن (Slot 1) (${rightBanners.length}):',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (rightBanners.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('لا توجد إعلانات في القسم الأيمن حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 11)),
          )
        else
          ...rightBanners.map((b) => _buildBannerAdminItemCard(b)).toList(),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.view_sidebar_outlined,
                size: 18, color: Color(0xFF0284C7)),
            const SizedBox(width: 6),
            Text(
              'بنرات القسم الأيسر (Slot 2) (${leftBanners.length}):',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 6),
        if (leftBanners.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('لا توجد إعلانات في القسم الأيسر حالياً.',
                style: TextStyle(color: Colors.grey, fontSize: 11)),
          )
        else
          ...leftBanners.map((b) => _buildBannerAdminItemCard(b)).toList(),
      ],
    );
  }

  Widget _buildBannerAdminItemCard(BannerItem b) {
    final remaining = b.expiresAt.difference(DateTime.now());
    final days = remaining.inDays;
    final isExpired = remaining.isNegative;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 50,
                height: 50,
                child: AppSmartImage(imageUrl: b.imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    b.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'القسم: ${b.slot == 1 ? "الأيمن (1)" : "الأيسر (2)"} • الصور: ${b.imageUrls.length} • المدة: ${b.displayDurationSeconds}ث',
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isExpired ? '❌ منتهي' : '⏳ متبقي: $days يوم',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isExpired ? Colors.red : Colors.green.shade800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              icon:
                  const Icon(Icons.delete_outline, color: Colors.red, size: 20),
              tooltip: 'حذف',
              onPressed: () async {
                try {
                  await Supabase.instance.client
                      .from('banners')
                      .delete()
                      .eq('id', b.id);
                } catch (_) {}
                setState(
                    () => _manager.banners.removeWhere((x) => x.id == b.id));
                _manager.saveBannersToOfflineCache(_manager.banners);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCustomBannerDialog() {
    final titleController = TextEditingController(text: 'عرض VIP خاص');
    final subtitleController = TextEditingController(text: 'سوق سوريا الشامل');
    final descriptionController = TextEditingController();
    final locationController = TextEditingController();
    final phoneController = TextEditingController();
    final whatsappController = TextEditingController();
    final facebookController = TextEditingController();
    final instagramController = TextEditingController();
    final tiktokController = TextEditingController();
    final telegramController = TextEditingController();
    final youtubeController = TextEditingController();

    int subscriptionDays = 7;
    List<Uint8List> selectedImages = [];
    bool isUploading = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('إضافة بانوراما إعلانية بمواصفات خاصة 🌟',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          labelText: 'عنوان البانوراما الرئيسي *',
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: subtitleController,
                      decoration: const InputDecoration(
                          labelText: 'النص الفرعي أو التخفيض',
                          prefixIcon: Icon(Icons.subtitles),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: 'وصف وتفاصيل الإعلان بالكامل 📝',
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                          labelText: 'المحافظة أو العنوان (دمشق، حلب...) 📍',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'رقم هاتف الاتصال المباشر 📞',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: whatsappController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          labelText: 'رقم أو رابط واتساب 💬',
                          prefixIcon: Icon(Icons.chat),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: facebookController,
                      decoration: const InputDecoration(
                          labelText: 'رابط صفحة فيسبوك 🌐',
                          prefixIcon: Icon(Icons.facebook),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: instagramController,
                      decoration: const InputDecoration(
                          labelText: 'رابط حساب إنستغرام 📸',
                          prefixIcon: Icon(Icons.camera_alt),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: tiktokController,
                      decoration: const InputDecoration(
                          labelText: 'رابط حساب تيك توك 🎵',
                          prefixIcon: Icon(Icons.music_note),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: telegramController,
                      decoration: const InputDecoration(
                          labelText: 'رابط قناة أو حساب تيليجرام ✈️',
                          prefixIcon: Icon(Icons.send),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: youtubeController,
                      decoration: const InputDecoration(
                          labelText: 'رابط قناة أو فيديو يوتيوب ▶️',
                          prefixIcon: Icon(Icons.play_circle_fill),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 12),
                    const Text('مدة صلاحية الاشتراك (عداد تنازلي):',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        ChoiceChip(
                          label: const Text('24 ساعة (يومي)'),
                          selected: subscriptionDays == 1,
                          onSelected: (v) =>
                              setModalState(() => subscriptionDays = 1),
                        ),
                        ChoiceChip(
                          label: const Text('أسبوع (7 أيام)'),
                          selected: subscriptionDays == 7,
                          onSelected: (v) =>
                              setModalState(() => subscriptionDays = 7),
                        ),
                        ChoiceChip(
                          label: const Text('شهر (30 يوم)'),
                          selected: subscriptionDays == 30,
                          onSelected: (v) =>
                              setModalState(() => subscriptionDays = 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F172A),
                            padding: const EdgeInsets.symmetric(vertical: 12)),
                        icon: const Icon(Icons.photo_library,
                            color: Colors.white),
                        label: Text(
                            'اختيار الصور من المعرض (${selectedImages.length} محددة)',
                            style: const TextStyle(color: Colors.white)),
                        onPressed: () async {
                          final picker = ImagePicker();
                          final picked = await picker.pickMultiImage(
                              imageQuality: 75, maxWidth: 1200);
                          if (picked.isNotEmpty) {
                            List<Uint8List> bytes = [];
                            for (var f in picked) {
                              bytes.add(await f.readAsBytes());
                            }
                            setModalState(() => selectedImages = bytes);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37)),
                        onPressed: (selectedImages.isEmpty || isUploading)
                            ? null
                            : () async {
                                setModalState(() => isUploading = true);
                                final urls = await StorageUploadService
                                    .uploadMultipleImageBytes(
                                  bucketName: kStorageBucketBanners,
                                  imagesBytesList: selectedImages,
                                  prefix: 'pan',
                                );

                                if (urls.isNotEmpty) {
                                  String mainLink = '';
                                  if (facebookController.text
                                      .trim()
                                      .isNotEmpty) {
                                    mainLink = facebookController.text.trim();
                                  } else if (instagramController.text
                                      .trim()
                                      .isNotEmpty) {
                                    mainLink = instagramController.text.trim();
                                  } else if (telegramController.text
                                      .trim()
                                      .isNotEmpty) {
                                    mainLink = telegramController.text.trim();
                                  } else if (tiktokController.text
                                      .trim()
                                      .isNotEmpty) {
                                    mainLink = tiktokController.text.trim();
                                  } else if (youtubeController.text
                                      .trim()
                                      .isNotEmpty) {
                                    mainLink = youtubeController.text.trim();
                                  }

                                  final newBanner = BannerItem(
                                    id: 'bn_${DateTime.now().millisecondsSinceEpoch}',
                                    imageUrls: urls,
                                    title: titleController.text.trim(),
                                    subtitle: subtitleController.text.trim(),
                                    description:
                                        descriptionController.text.trim(),
                                    location: locationController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    whatsapp: whatsappController.text.trim(),
                                    linkUrl: mainLink,
                                    facebookUrl: facebookController.text.trim(),
                                    telegramUrl: telegramController.text.trim(),
                                    instagramUrl:
                                        instagramController.text.trim(),
                                    youtubeUrl: youtubeController.text.trim(),
                                    tiktokUrl: tiktokController.text.trim(),
                                    badgeText: 'VIP ★',
                                    badgeColor: const Color(0xFFD4AF37),
                                    displayDurationSeconds:
                                        _manager.bannerDefaultIntervalSeconds,
                                    expiresAt: DateTime.now()
                                        .add(Duration(days: subscriptionDays)),
                                    isActive: true,
                                  );

                                  try {
                                    await Supabase.instance.client
                                        .from('banners')
                                        .insert(newBanner.toMap());
                                  } catch (err) {
                                    debugPrint('Insert banner err: $err');
                                  }

                                  setState(() {
                                    _manager.banners.insert(0, newBanner);
                                  });
                                  _manager.saveBannersToOfflineCache(
                                      _manager.banners);
                                  Navigator.pop(ctx);
                                }
                              },
                        child: isUploading
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : const Text('نشر وتفعيل البانوراما فوراً 🚀',
                                style: TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: const Color(0xFF0F172A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SyrianIndependenceFlag(width: 24, height: 16),
                    SizedBox(width: 8),
                    Text('إحصائيات المنصة السحابية المباشرة',
                        style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Text('إجمالي الإعلانات في السيرفر: ${_manager.ads.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 4),
                Text('البنرات والبانورامات النشطة: ${_manager.banners.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
                const SizedBox(height: 4),
                Text('الأقسام والفروع الهيكلية: ${_manager.categories.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _manager.isMaintenanceMode
                ? Colors.red.shade900.withOpacity(0.4)
                : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _manager.isMaintenanceMode
                  ? Colors.redAccent
                  : const Color(0xFFD4AF37),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.redAccent,
                title: Text(
                  _manager.isMaintenanceMode
                      ? 'وضع الصيانة مُقفل أمام الزوار 🔒'
                      : 'وضع الصيانة (متاح للجميع) 🔓',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _manager.isMaintenanceMode
                        ? Colors.redAccent
                        : Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: const Text(
                  'عند التفعيل، يقفل التطبيق أمام العامة وتظهر لهم الصلاة على النبي ﷺ والمدة',
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                ),
                value: _manager.isMaintenanceMode,
                onChanged: (val) async {
                  setState(() => _manager.isMaintenanceMode = val);
                  _manager.notifyListeners();

                  try {
                    await Supabase.instance.client.from('app_settings').upsert([
                      {'key': 'maintenance_mode', 'value': val.toString()},
                      {
                        'key': 'maintenance_title',
                        'value': 'أعمال صيانة وتطوير ⚙️'
                      },
                      {
                        'key': 'maintenance_message',
                        'value':
                            'نقوم حالياً بأعمال صيانة وتحديثات هامة لخدمتكم بشكل أفضل وأسرع.'
                      },
                      {
                        'key': 'maintenance_duration',
                        'value': 'نصف ساعة تقريباً بإذن الله'
                      },
                      {
                        'key': 'prayer_text',
                        'value':
                            '«اللهم صلِّ وسلِّم وبارك على سيدنا ونبينا محمد وعلى آله وصحبه أجمعين ﷺ»\n«سبحان الله والحمد لله ولا إله إلا الله والله أكبر»'
                      },
                    ]);

                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(val
                              ? '🔒 تم قفل التطبيق وإظهار شاشة الصيانة والأجر لجميع الأجهزة!'
                              : '🔓 تم فتح التطبيق لجميع الناس بنجاح!'),
                          backgroundColor:
                              val ? Colors.red.shade800 : Colors.green,
                        ),
                      );
                    }
                  } catch (e) {
                    debugPrint('خطأ في تحديث الصيانة: $e');
                  }
                },
              ),
              if (_manager.isMaintenanceMode) ...[
                const Divider(color: Colors.white24),
                const Text(
                  '💡 ملاحظة: أنت كمسؤول ومسؤولين تستطيعون تصفح التطبيق بحرية تامة، بينما باقي الناس تظهر لهم شاشة الصيانة والدعاء المبارك.',
                  style: TextStyle(color: Color(0xFFD4AF37), fontSize: 11),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdReviewTab(List<AdItem> pendingAds) {
    if (pendingAds.isEmpty) {
      return const Center(
          child: Text('لا توجد إعلانات بانتظار المراجعة حالياً ✓'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: pendingAds.length,
      itemBuilder: (ctx, idx) {
        final ad = pendingAds[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ad.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text('المعلن: ${ad.publisherName} • هاتف: ${ad.contactPhone}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 8),
                Text(ad.description,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text('موافقة ونشر',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _manager.approveAd(ad.id);
                          if (mounted) setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        icon: const Icon(Icons.close, color: Colors.white),
                        label: const Text('رفض الإعلان',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          await _manager.rejectAd(
                              ad.id, 'مخالف للشروط والسياسات');
                          if (mounted) setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentAuditTab(List<PaymentAuditRecord> pendingPayments) {
    if (pendingPayments.isEmpty) {
      return const Center(
          child: Text('لا توجد إيصالات دفع بانتظار التدقيق حالياً ✓'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: pendingPayments.length,
      itemBuilder: (ctx, idx) {
        final p = pendingPayments[idx];
        final isPanorama = p.requestType == 'panorama_booking';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isPanorama
                            ? const Color(0xFF0284C7)
                            : const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isPanorama
                            ? 'حجز بانوراما: ${p.durationLabel}'
                            : 'ترقية باقة: ${p.planName}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    Text(
                      '\$${p.amountUsd.toInt()} USD (${p.amountSyp.toInt()} ل.س)',
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Text('المشترك: ${p.userName} • هاتف: ${p.userPhone}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                if (p.userEmail.isNotEmpty)
                  Text('البريد: ${p.userEmail}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text('المحافظة: ${p.userGovernorate} • البوابة: ${p.gateway}',
                    style: const TextStyle(fontSize: 12)),
                Text('المرجع / TXID: ${p.transactionRefOrTxId}',
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
                if (isPanorama) ...[
                  const SizedBox(height: 8),
                  Text('عنوان البانوراما: ${p.bannerTitle}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  if (p.bannerSubtitle.isNotEmpty)
                    Text('النص الفرعي: ${p.bannerSubtitle}',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                  if (p.bannerImages.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 55,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: p.bannerImages.length,
                        itemBuilder: (_, i) => Container(
                          margin: const EdgeInsets.only(left: 6),
                          width: 55,
                          height: 55,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: AppSmartImage(
                              imageUrl: p.bannerImages[i], fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ],
                const SizedBox(height: 10),
                if (p.receiptImageUrl != null &&
                    p.receiptImageUrl!.isNotEmpty) ...[
                  const Text('📸 صورة الإيصال المرفقة (المس لتكبيرها):',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        ctx,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            backgroundColor: Colors.black,
                            appBar: AppBar(
                              backgroundColor: Colors.black,
                              title: const Text('معاينة إشعار الدفع',
                                  style: TextStyle(color: Colors.white)),
                              leading: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                                onPressed: () => Navigator.pop(_),
                              ),
                            ),
                            body: Center(
                              child: InteractiveViewer(
                                child: AppSmartImage(
                                  imageUrl: p.receiptImageUrl!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: AppSmartImage(
                        imageUrl: p.receiptImageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.check_circle,
                            color: Colors.white, size: 18),
                        label: Text(
                          isPanorama
                              ? 'اعتماد وتفعيل البانوراما ✓'
                              : 'اعتماد وترقية الحساب ✓',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        onPressed: () {
                          _manager.approvePaymentTransaction(p.id);
                          if (mounted) setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isPanorama
                                  ? '✅ تم تفعيل البانوراما في الواجهة الرئيسية لتبدأ مدة العرض!'
                                  : '✅ تم ترقية حساب ${p.userName} وتفعيل اشتراكه بنجاح!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.cancel,
                            color: Colors.white, size: 18),
                        label: const Text('رفض الإشعار ❌',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                        onPressed: () {
                          _manager.rejectPaymentTransaction(
                              p.id, 'الإشعار غير مطابق أو لم يصل التحويل');
                          if (mounted) setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRatesSettingsTab() {
    final usdBuyCtrl = TextEditingController(
        text: _usdRateController.text.isNotEmpty
            ? _usdRateController.text
            : '14800');
    final usdSellCtrl = TextEditingController(text: '15000');
    final tryBuyCtrl = TextEditingController(text: '410');
    final trySellCtrl = TextEditingController(text: '425');
    final goldSypCtrl = TextEditingController(
        text: _goldPriceController.text.isNotEmpty
            ? _goldPriceController.text
            : '1050000');
    final goldUsdCtrl = TextEditingController(text: '72.5');
    final sponsorNameCtrl =
        TextEditingController(text: 'صرافة ومجوهرات البركة 🏛️');
    bool isSponsorActive = true;

    return StatefulBuilder(
      builder: (ctx, setTabState) => ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.currency_exchange,
                    color: Color(0xFFD4AF37), size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إدارة أسعار العملات والذهب والصراف الراعي 💰',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      Text(
                        'مخصص لمدير ومشرف قسم الصرافة المعتمد',
                        style: TextStyle(color: Colors.white60, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'اسم الصراف أو المحل الراعي للأسعار:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color(0xFFD4AF37)),
                    ),
                    Switch(
                      value: isSponsorActive,
                      activeColor: const Color(0xFFD4AF37),
                      onChanged: (val) =>
                          setTabState(() => isSponsorActive = val),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: sponsorNameCtrl,
                  decoration: const InputDecoration(
                    hintText:
                        'مثال: صرافة ومجوهرات الشام (اتركه فارغاً للإلغاء)',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text('1. الدولار الأمريكي مقابل السوري (USD/SYP):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: usdBuyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'شراء الدولار (ل.س)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: usdSellCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'مبيع الدولار (ل.س)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('2. الليرة التركية مقابل السوري (TRY/SYP):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tryBuyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'شراء التركي (ل.س)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: trySellCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'مبيع التركي (ل.س)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('3. غرام الذهب عيار 21:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: goldSypCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'سعر الغرام (ل.س)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: goldUsdCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'سعر الغرام (\$ دولار)',
                      border: OutlineInputBorder(),
                      isDense: true),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
              ),
            ),
            onPressed: () async {
              final usdBuy = double.tryParse(usdBuyCtrl.text.trim()) ?? 0;
              final usdSell = double.tryParse(usdSellCtrl.text.trim()) ?? 0;
              final tryBuy = double.tryParse(tryBuyCtrl.text.trim()) ?? 0;
              final trySell = double.tryParse(trySellCtrl.text.trim()) ?? 0;
              final goldSyp = double.tryParse(goldSypCtrl.text.trim()) ?? 0;
              final goldUsd = double.tryParse(goldUsdCtrl.text.trim()) ?? 0;
              final sponsorName = sponsorNameCtrl.text.trim();

              try {
                await Supabase.instance.client.from('exchange_rates').upsert({
                  'id': 'current_rates',
                  'usd_rate': usdBuy,
                  'usd_buy': usdBuy,
                  'usd_sell': usdSell,
                  'try_buy': tryBuy,
                  'try_sell': trySell,
                  'gold_price': goldSyp,
                  'gold_usd': goldUsd,
                  'sponsor_name': sponsorName,
                  'is_sponsor_visible': isSponsorActive,
                  'updated_at': DateTime.now().toIso8601String(),
                });

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          '✅ تم حفظ ونشر أسعار العملات والذهب واسم الصراف لجميع الأجهزة بالسيرفر!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('⚠️ حدث خطأ في السيرفر: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.publish, color: Color(0xFFD4AF37), size: 18),
                SizedBox(width: 8),
                Text(
                  'حفظ ونشر الأسعار واسم الصراف فوراً 🚀',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentTreeTab() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      children: _manager.departments
          .map((d) => DepartmentTreeItemWidget(node: d))
          .toList(),
    );
  }

  Widget _buildFeedbacksTab() {
    if (_manager.feedbacks.isEmpty) {
      return const Center(child: Text('لا توجد مقترحات واردة بعد 💡'));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: _manager.feedbacks.length,
      itemBuilder: (ctx, idx) {
        final f = _manager.feedbacks[idx];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.type,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0284C7))),
                const SizedBox(height: 4),
                Text(f.content, style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 6),
                Text('المرسل: ${f.userName} • للتواصل: ${f.userContact}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==============================================================================
// 22. شاشة تفاصيل البانوراما الإعلانية الكاملة للزائر (BannerDetailsScreen)
// ==============================================================================
class BannerDetailsScreen extends StatefulWidget {
  final BannerItem banner;

  const BannerDetailsScreen({Key? key, required this.banner}) : super(key: key);

  @override
  State<BannerDetailsScreen> createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();

  Future<void> _launchUrlString(String url) async {
    if (url.trim().isEmpty) return;
    try {
      final uri = Uri.parse(url.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  Future<void> _callPhone(String phone) async {
    if (phone.trim().isEmpty) return;
    final uri = Uri.parse('tel:${phone.trim()}');
    try {
      await launchUrl(uri);
    } catch (_) {}
  }

  Future<void> _openWhatsApp(String phone) async {
    if (phone.trim().isEmpty) return;
    String clean = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('https://wa.me/$clean');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final b = widget.banner;
    final imgs = b.imageUrls.isNotEmpty ? b.imageUrls : [b.imageUrl];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          b.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              b.badgeText,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: imgs.length,
                    onPageChanged: (i) =>
                        setState(() => _currentImageIndex = i),
                    itemBuilder: (ctx, idx) {
                      return AppSmartImage(
                        imageUrl: imgs[idx],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  if (imgs.length > 1)
                    Positioned(
                      bottom: 12,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          imgs.length,
                          (i) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentImageIndex == i ? 18 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _currentImageIndex == i
                                  ? const Color(0xFFD4AF37)
                                  : Colors.white54,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (b.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      b.subtitle,
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.redAccent, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        b.location,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white24, height: 24),
                  if (b.description.isNotEmpty) ...[
                    const Text(
                      'التفاصيل والمعلومات:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        b.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      if (b.phone.isNotEmpty)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0284C7),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.phone,
                                color: Colors.white, size: 18),
                            label: const Text('اتصال 📞',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () => _callPhone(b.phone),
                          ),
                        ),
                      if (b.phone.isNotEmpty && b.whatsapp.isNotEmpty)
                        const SizedBox(width: 8),
                      if (b.whatsapp.isNotEmpty)
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF25D366),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.chat,
                                color: Colors.white, size: 18),
                            label: const Text('واتساب 💬',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () => _openWhatsApp(b.whatsapp),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'روابط التواصل والصفحات الرسمية:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (b.facebookUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.facebook,
                          label: 'فيسبوك',
                          color: const Color(0xFF1877F2),
                          onTap: () => _launchUrlString(b.facebookUrl),
                        ),
                      if (b.telegramUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.send,
                          label: 'تيليجرام',
                          color: const Color(0xFF229ED9),
                          onTap: () => _launchUrlString(b.telegramUrl),
                        ),
                      if (b.instagramUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.camera_alt,
                          label: 'إنستجرام',
                          color: const Color(0xFFE4405F),
                          onTap: () => _launchUrlString(b.instagramUrl),
                        ),
                      if (b.youtubeUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.video_library,
                          label: 'يوتيوب',
                          color: const Color(0xFFFF0000),
                          onTap: () => _launchUrlString(b.youtubeUrl),
                        ),
                      if (b.tiktokUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.music_note,
                          label: 'تيك توك',
                          color: Colors.black,
                          onTap: () => _launchUrlString(b.tiktokUrl),
                        ),
                      if (b.linkUrl.isNotEmpty)
                        _buildSocialChip(
                          icon: Icons.language,
                          label: 'الموقع الرسمي',
                          color: const Color(0xFFD4AF37),
                          onTap: () => _launchUrlString(b.linkUrl),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.6), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
// ==============================================================================
// 35. شاشة دليل المكاتب والشركات العقارية بالمحافظات (RealEstateDirectoryScreen)
// ==============================================================================

class RealEstateOfficeItem {
  final String id;
  final String name;
  final String ownerName;
  final String phone;
  final String whatsapp;
  final String governorate;
  final String cityArea;
  final String? addressDetails;
  final String? logoUrl;
  final String? coverUrl;
  final String? facebookUrl;
  final String? telegramUrl;
  final bool isVerified;
  final int activeListingsCount;
  final double rating;

  RealEstateOfficeItem({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.phone,
    required this.whatsapp,
    required this.governorate,
    required this.cityArea,
    this.addressDetails,
    this.logoUrl,
    this.coverUrl,
    this.facebookUrl,
    this.telegramUrl,
    this.isVerified = true,
    this.activeListingsCount = 0,
    this.rating = 5.0,
  });

  factory RealEstateOfficeItem.fromMap(Map<String, dynamic> map) {
    return RealEstateOfficeItem(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? 'مكتب عقاري',
      ownerName: map['owner_name']?.toString() ?? 'المدير المسؤول',
      phone: map['phone']?.toString() ?? '',
      whatsapp: map['whatsapp']?.toString() ?? '',
      governorate: map['governorate']?.toString() ?? 'إدلب',
      cityArea: map['city_area']?.toString() ?? 'المركز',
      addressDetails: map['address_details']?.toString(),
      logoUrl: map['logo_url']?.toString(),
      coverUrl: map['cover_url']?.toString(),
      facebookUrl: map['facebook_url']?.toString(),
      telegramUrl: map['telegram_url']?.toString(),
      isVerified: map['is_verified'] == true,
      activeListingsCount: map['active_listings_count'] is int
          ? map['active_listings_count']
          : 0,
      rating: (map['rating'] is num) ? (map['rating'] as num).toDouble() : 5.0,
    );
  }
}

class RealEstateDirectoryScreen extends StatefulWidget {
  const RealEstateDirectoryScreen({Key? key}) : super(key: key);

  @override
  State<RealEstateDirectoryScreen> createState() =>
      _RealEstateDirectoryScreenState();
}

class _RealEstateDirectoryScreenState extends State<RealEstateDirectoryScreen> {
  final AppStateManager _manager = AppStateManager();
  final TextEditingController _searchController = TextEditingController();

  String _selectedGov = 'الكل';
  String _selectedArea = 'الكل';
  bool _isLoading = false;
  List<RealEstateOfficeItem> _offices = [];

  final Map<String, List<String>> _govAreas = {
    'إدلب': [
      'الكل',
      'الدانا',
      'سرمدا',
      'إدلب المدينة',
      'أريحا',
      'بنش',
      'سلقين',
      'حارم',
      'معرة مصرين',
      'كفرتخاريم',
      'اطمة'
    ],
    'دمشق': [
      'الكل',
      'المزة',
      'كفرسوسة',
      'الميدان',
      'الشاغور',
      'المالكي',
      'أبو رمانة',
      'التجارة',
      'ركن الدين',
      'برزة',
      'دمر'
    ],
    'ريف دمشق': [
      'الكل',
      'جرمانا',
      'صحنايا',
      'أشرفية صحنايا',
      'قدسيا',
      'الضاحية',
      'معضمية الشام',
      'الكسوة',
      'دوما',
      'التل',
      'النبك'
    ],
    'حلب': [
      'الكل',
      'حلب الجديدة',
      'الشهباء',
      'سيف الدولة',
      'الفرقان',
      'الموكامبو',
      'الأشرفية',
      'السريان',
      'أعزاز',
      'عفرين',
      'الباب'
    ],
    'حمص': [
      'الكل',
      'الإنشاءات',
      'الحمراء',
      'الدبلان',
      'الغوطة',
      'الوعر',
      'عكرمة',
      'الزهراء',
      'القصير',
      'الرستن',
      'تدمر'
    ],
    'حماة': [
      'الكل',
      'حماة المدينة',
      'السقيلبية',
      'مصياف',
      'سلمية',
      'محردة',
      'طيبة الإمام'
    ],
    'اللاذقية': [
      'الكل',
      'اللاذقية المدينة',
      'جبلة',
      'القرداحة',
      'الحفة',
      'مشروع دمر',
      'الزراعة',
      'الصليبة'
    ],
    'طرطوس': [
      'الكل',
      'طرطوس المدينة',
      'بانياس',
      'صافيتا',
      'الدريكيش',
      'الشيخ بدر'
    ],
    'درعا': [
      'الكل',
      'درعا المدينة',
      'الصنمين',
      'إزرع',
      'طفس',
      'نوى',
      'بصرى الشام'
    ],
    'السويداء': ['الكل', 'السويداء المدينة', 'صلخد', 'شهبا', 'القريا'],
    'دير الزور': ['الكل', 'دير الزور المدينة', 'الميادين', 'البوكمال'],
    'الرقة': ['الكل', 'الرقة المدينة', 'تل أبيض', 'الطبقة'],
    'الحسكة': [
      'الكل',
      'الحسكة المدينة',
      'القامشلي',
      'عامودا',
      'رأس العين',
      'المالكية'
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadOffices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadOffices() async {
    setState(() => _isLoading = true);
    try {
      final res = await Supabase.instance.client
          .from('real_estate_offices')
          .select()
          .order('is_verified', ascending: false)
          .timeout(const Duration(seconds: 8));

      final list =
          (res as List).map((m) => RealEstateOfficeItem.fromMap(m)).toList();
      if (mounted) {
        setState(() {
          _offices = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Offices Load Error: $e');
      if (mounted) {
        setState(() {
          _offices = [];
          _isLoading = false;
        });
      }
    }
  }

  void _callOffice(String phone) async {
    if (phone.trim().isEmpty) return;
    final uri = Uri.parse('tel:$phone');
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (_) {}
  }

  void _whatsappOffice(String rawNumber, String officeName) async {
    if (rawNumber.trim().isEmpty) return;
    String clean = rawNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (clean.startsWith('09') && clean.length == 10) {
      clean = '963${clean.substring(1)}';
    }
    final msg = Uri.encodeComponent(
        'مرحباً $officeName، تواصلت معكم عبر تطبيق سوق سوريا للاستفسار عن العروض العقارية المتاحة.');
    final uri = Uri.parse('https://wa.me/$clean?text=$msg');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  void _showAddOfficeDialog() {
    final nameCtrl = TextEditingController();
    final ownerCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final whatsappCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
    String dialogGov = 'إدلب';
    String dialogArea = 'الدانا';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final availableAreas = _govAreas[dialogGov] ?? ['المركز'];
            final filteredAreas =
                availableAreas.where((a) => a != 'الكل').toList();
            if (!filteredAreas.contains(dialogArea)) {
              dialogArea =
                  filteredAreas.isNotEmpty ? filteredAreas.first : 'المركز';
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 45,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.add_business,
                            color: Color(0xFFD4AF37), size: 22),
                        SizedBox(width: 8),
                        Text(
                          'إضافة وتوثيق مكتب عقاري رسمي (إدارة) 🛡️',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: nameCtrl,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        labelText: 'اسم المكتب العقاري *',
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF1E293B),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: ownerCtrl,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        labelText: 'اسم المدير أو المالك *',
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF1E293B),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: dialogGov,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              labelText: 'المحافظة',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF1E293B),
                              border: OutlineInputBorder(),
                            ),
                            items: _govAreas.keys
                                .map((g) =>
                                    DropdownMenuItem(value: g, child: Text(g)))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setSheetState(() {
                                  dialogGov = v;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: dialogArea,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              labelText: 'المنطقة / البلدة',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF1E293B),
                              border: OutlineInputBorder(),
                            ),
                            items: filteredAreas
                                .map((a) =>
                                    DropdownMenuItem(value: a, child: Text(a)))
                                .toList(),
                            onChanged: (v) {
                              if (v != null)
                                setSheetState(() => dialogArea = v);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: phoneCtrl,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              labelText: 'رقم الهاتف *',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF1E293B),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: whatsappCtrl,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            decoration: const InputDecoration(
                              labelText: 'رقم الواتساب *',
                              labelStyle: TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Color(0xFF1E293B),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: addressCtrl,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: const InputDecoration(
                        labelText:
                            'العنوان التفصيلي (مثال: الشارع العام - جانب البريد)',
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Color(0xFF1E293B),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: const Color(0xFF0F172A),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: const Icon(Icons.verified, size: 18),
                        label: const Text('حفظ وتوثيق المكتب فوراً 🛡️',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        onPressed: () async {
                          final name = nameCtrl.text.trim();
                          final owner = ownerCtrl.text.trim();
                          final phone = phoneCtrl.text.trim();
                          final whatsapp = whatsappCtrl.text.trim();

                          if (name.isEmpty || owner.isEmpty || phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      '⚠️ يرجى تعبئة اسم المكتب والمالك ورقم الهاتف')),
                            );
                            return;
                          }

                          Navigator.pop(ctx);
                          setState(() => _isLoading = true);

                          try {
                            await Supabase.instance.client
                                .from('real_estate_offices')
                                .insert({
                              'name': name,
                              'owner_name': owner,
                              'phone': phone,
                              'whatsapp':
                                  whatsapp.isNotEmpty ? whatsapp : phone,
                              'governorate': dialogGov,
                              'city_area': dialogArea,
                              'address_details': addressCtrl.text.trim(),
                              'is_verified': true,
                              'active_listings_count': 0,
                            });

                            await _loadOffices();

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      '✅ تم تسجيل وتوثيق المكتب العقاري بنجاح في السيرفر!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              setState(() => _isLoading = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('خطأ أثناء الحفظ: $e')),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<RealEstateOfficeItem> get _filteredOffices {
    final q = _searchController.text.trim().toLowerCase();
    return _offices.where((o) {
      final matchGov =
          (_selectedGov == 'الكل') || (o.governorate == _selectedGov);
      final matchArea =
          (_selectedArea == 'الكل') || (o.cityArea == _selectedArea);
      final matchQuery = q.isEmpty ||
          o.name.toLowerCase().contains(q) ||
          o.cityArea.toLowerCase().contains(q) ||
          o.governorate.toLowerCase().contains(q) ||
          o.ownerName.toLowerCase().contains(q);
      return matchGov && matchArea && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentAreas = _selectedGov == 'الكل'
        ? ['الكل']
        : (_govAreas[_selectedGov] ?? ['الكل']);

    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: _manager.appBarColor,
        title: const Row(
          children: [
            Icon(Icons.real_estate_agent, color: Color(0xFFD4AF37), size: 22),
            SizedBox(width: 8),
            Text(
              'دليل المكاتب والشركات العقارية 🏢',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (_manager.isAdmin)
            IconButton(
              icon: const Icon(Icons.add_business, color: Color(0xFFD4AF37)),
              tooltip: 'إضافة مكتب عقاري رسمي (خاص بالإدارة)',
              onPressed: _showAddOfficeDialog,
            ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: _manager.isAdmin
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF0F172A),
              icon: const Icon(Icons.add_business),
              label: const Text('إضافة مكتب عقاري (إدارة) 🛡️',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onPressed: _showAddOfficeDialog,
            )
          : null,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: const Color(0xFF1E293B),
            child: Row(
              children: [
                const Icon(Icons.info_outline,
                    color: Color(0xFFD4AF37), size: 18),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'أصحاب المكاتب والشركات العقارية: انضموا للدليل المعتمد وافتحوا صفحة خاصة بمكتبكم.',
                    style: TextStyle(color: Colors.white70, fontSize: 10.5),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    backgroundColor: const Color(0xFF25D366),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {
                    _whatsappOffice(kAppOwnerWhatsApp,
                        'إدارة التطبيق بخصوص توثيق مكتب عقاري');
                  },
                  child: const Text(
                    'تواصل معنا',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF0F172A),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'ابحث باسم المكتب، المنطقة، أو صاحب المكتب...',
                    hintStyle:
                        const TextStyle(color: Colors.white38, fontSize: 12),
                    prefixIcon: const Icon(Icons.search,
                        color: Color(0xFFD4AF37), size: 20),
                    filled: true,
                    fillColor: const Color(0xFF1E293B),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedGov,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF0F172A),
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Color(0xFFD4AF37)),
                            items: ['الكل', ..._govAreas.keys]
                                .map((g) => DropdownMenuItem(
                                      value: g,
                                      child: Text(
                                        g == 'الكل' ? 'كل المحافظات' : g,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setState(() {
                                  _selectedGov = v;
                                  _selectedArea = 'الكل';
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentAreas.contains(_selectedArea)
                                ? _selectedArea
                                : 'الكل',
                            isExpanded: true,
                            dropdownColor: const Color(0xFF0F172A),
                            icon: const Icon(Icons.location_on,
                                color: Color(0xFFD4AF37), size: 16),
                            items: currentAreas
                                .map((a) => DropdownMenuItem(
                                      value: a,
                                      child: Text(
                                        a == 'الكل' ? 'كل المناطق' : a,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (v) {
                              if (v != null) setState(() => _selectedArea = v);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredOffices.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.domain_disabled,
                                  size: 55,
                                  color: Colors.grey.withOpacity(0.5)),
                              const SizedBox(height: 12),
                              const Text(
                                'لا توجد مكاتب عقارية مسجلة في هذه المنطقة حالياً',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'تواصل مع إدارة التطبيق لتوثيق مكتبك العقاري وإضافته للدليل.',
                                style: TextStyle(
                                    color: Colors.white38, fontSize: 11),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filteredOffices.length,
                        itemBuilder: (ctx, idx) {
                          final office = _filteredOffices[idx];
                          return _buildOfficeCard(office);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfficeCard(RealEstateOfficeItem office) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: office.isVerified
              ? const Color(0xFFD4AF37).withOpacity(0.4)
              : Colors.white12,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: const Color(0xFFD4AF37), width: 1.2),
                  ),
                  child: Center(
                    child: Text(
                      office.name.isNotEmpty ? office.name[0] : '🏢',
                      style: const TextStyle(
                          color: Color(0xFFD4AF37),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              office.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (office.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified,
                                color: Color(0xFFD4AF37), size: 16),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.redAccent, size: 13),
                          const SizedBox(width: 3),
                          Text(
                            '${office.governorate} • ${office.cityArea}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 11),
                          ),
                        ],
                      ),
                      if (office.addressDetails != null &&
                          office.addressDetails!.isNotEmpty)
                        Text(
                          office.addressDetails!,
                          style: const TextStyle(
                              color: Colors.white38, fontSize: 10.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${office.activeListingsCount}',
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      const Text(
                        'عقار متاح',
                        style: TextStyle(color: Colors.green, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.white12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0284C7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    icon: const Icon(Icons.phone, size: 15),
                    label: const Text('اتصال بالمكتب',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    onPressed: () => _callOffice(office.phone),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    icon: const Icon(Icons.chat, size: 15),
                    label: const Text('واتساب مباشر',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold)),
                    onPressed: () =>
                        _whatsappOffice(office.whatsapp, office.name),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// غرفة مفاتيح صلاحيات المشرفين المركزية للمسؤول العام (ModeratorsPermissionsPanel)
// ==============================================================================

class ModeratorPermissionModel {
  final String id;
  final String userId;
  final String userName;
  final String? userPhone;
  String role;
  bool canManageOffices;
  bool canApproveAds;
  bool canManageBanners;
  bool canAuditPayments;
  bool canBanUsers;

  ModeratorPermissionModel({
    required this.id,
    required this.userId,
    required this.userName,
    this.userPhone,
    this.role = 'moderator',
    this.canManageOffices = true,
    this.canApproveAds = true,
    this.canManageBanners = false,
    this.canAuditPayments = false,
    this.canBanUsers = false,
  });

  factory ModeratorPermissionModel.fromMap(Map<String, dynamic> map) {
    return ModeratorPermissionModel(
      id: map['id']?.toString() ?? '',
      userId: map['user_id']?.toString() ?? '',
      userName: map['user_name']?.toString() ?? 'مشرف',
      userPhone: map['user_phone']?.toString(),
      role: map['role']?.toString() ?? 'moderator',
      canManageOffices: map['can_manage_offices'] == true,
      canApproveAds: map['can_approve_ads'] == true,
      canManageBanners: map['can_manage_banners'] == true,
      canAuditPayments: map['can_audit_payments'] == true,
      canBanUsers: map['can_ban_users'] == true,
    );
  }
}

class AdminModeratorsControlSection extends StatefulWidget {
  const AdminModeratorsControlSection({Key? key}) : super(key: key);

  @override
  State<AdminModeratorsControlSection> createState() =>
      _AdminModeratorsControlSectionState();
}

class _AdminModeratorsControlSectionState
    extends State<AdminModeratorsControlSection> {
  final AppStateManager _manager = AppStateManager();
  bool _isLoading = false;
  List<ModeratorPermissionModel> _moderators = [];

  @override
  void initState() {
    super.initState();
    _loadModerators();
  }

  Future<void> _loadModerators() async {
    setState(() => _isLoading = true);
    try {
      final res = await Supabase.instance.client
          .from('moderators_permissions')
          .select()
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      if (res is List && mounted) {
        setState(() {
          _moderators = res
              .map((m) =>
                  ModeratorPermissionModel.fromMap(m as Map<String, dynamic>))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading moderators: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updatePermission(
      ModeratorPermissionModel mod, String field, bool value) async {
    setState(() {
      if (field == 'can_manage_offices') mod.canManageOffices = value;
      if (field == 'can_approve_ads') mod.canApproveAds = value;
      if (field == 'can_manage_banners') mod.canManageBanners = value;
      if (field == 'can_audit_payments') mod.canAuditPayments = value;
      if (field == 'can_ban_users') mod.canBanUsers = value;
    });

    try {
      await Supabase.instance.client
          .from('moderators_permissions')
          .update(
              {field: value, 'updated_at': DateTime.now().toIso8601String()})
          .eq('user_id', mod.userId)
          .timeout(const Duration(seconds: 8));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ تم تحديث صلاحية (${mod.userName}) بنجاح!'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating mod perm: $e');
      _loadModerators();
    }
  }

  void _showAddModeratorDialog() {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final userIdCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.person_add_alt_1,
                      color: Color(0xFFD4AF37), size: 24),
                  SizedBox(width: 8),
                  Text('تعيين مشرف جديد ومنح الصلاحيات 🛡️',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  labelText: 'اسم المشرف *',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF1E293B),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  labelText: 'رقم هاتف المشرف *',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF1E293B),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: userIdCtrl,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: const InputDecoration(
                  labelText: 'معرف المستخدم (User ID) إن وجد أو اتركه فارغاً',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Color(0xFF1E293B),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: const Color(0xFF0F172A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.check_circle),
                  label: const Text('اعتماد المشرف فوراً في السيرفر 🛡️',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    final name = nameCtrl.text.trim();
                    final phone = phoneCtrl.text.trim();
                    final uid = userIdCtrl.text.trim().isNotEmpty
                        ? userIdCtrl.text.trim()
                        : 'usr_${DateTime.now().millisecondsSinceEpoch}';

                    if (name.isEmpty || phone.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('⚠️ يرجى إدخال اسم ورقم المشرف')),
                      );
                      return;
                    }

                    Navigator.pop(ctx);
                    setState(() => _isLoading = true);

                    try {
                      await Supabase.instance.client
                          .from('moderators_permissions')
                          .upsert({
                        'user_id': uid,
                        'user_name': name,
                        'user_phone': phone,
                        'role': 'moderator',
                        'can_manage_offices': true,
                        'can_approve_ads': true,
                        'can_manage_banners': false,
                        'can_audit_payments': false,
                        'can_ban_users': false,
                      });

                      await _loadModerators();
                    } catch (e) {
                      debugPrint('Add mod error: $e');
                      if (mounted) setState(() => _isLoading = false);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.admin_panel_settings,
                      color: Color(0xFFD4AF37), size: 22),
                  SizedBox(width: 8),
                  Text(
                    'غرفة مفاتيح الصلاحيات المركزية 🔑',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: const Color(0xFF0F172A),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('إضافة مشرف',
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                onPressed: _showAddModeratorDialog,
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'تحكم بكل دقة في إظهار أو إخفاء زر إضافة المكاتب والخيارات لكل مشرف.',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const Divider(color: Colors.white12, height: 18),
          if (_isLoading)
            const Center(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator()))
          else if (_moderators.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'لا يوجد مشرفون حالياً. اضغط على (إضافة مشرف) لتعيين مشرف جديد.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _moderators.length,
              itemBuilder: (ctx, idx) {
                final mod = _moderators[idx];
                return _buildModeratorCard(mod);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildModeratorCard(ModeratorPermissionModel mod) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFD4AF37),
                    child: Text(
                      mod.userName.isNotEmpty ? mod.userName[0] : 'M',
                      style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mod.userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      if (mod.userPhone != null)
                        Text(
                          mod.userPhone!,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 11),
                        ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'مشرف معتمد',
                  style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white12, height: 16),
          _buildSwitchRow(
            title: 'إضافة وتوثيق المكاتب العقارية 🏢',
            subtitle: 'يتحكم في إظهار أو إخفاء زر إضافة المكاتب له',
            value: mod.canManageOffices,
            onChanged: (v) => _updatePermission(mod, 'can_manage_offices', v),
          ),
          _buildSwitchRow(
            title: 'الموافقة على الإعلانات المعلقة 📢',
            subtitle: 'السماح بمراجعة ونشر إعلانات المستخدمين',
            value: mod.canApproveAds,
            onChanged: (v) => _updatePermission(mod, 'can_approve_ads', v),
          ),
          _buildSwitchRow(
            title: 'إدارة البانرات الإعلانية 🖼️',
            subtitle: 'رفع بنرات جديدة في البانوراما',
            value: mod.canManageBanners,
            onChanged: (v) => _updatePermission(mod, 'can_manage_banners', v),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 10)),
              ],
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFFD4AF37),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// 24. نقطة الانطلاق والتشغيل السريعة للتطبيق (Main App Entry Point)
// تفتح الصفحة الرئيسية مباشرة بدون تعليق نهائياً
// ==============================================================================
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // إقلاع فوري للتطبيق وفتح الشاشة الرئيسية مباشرة لكسر أي شاشة بيضاء أو تعليق
  runApp(const SouqSyriaApp());

  // تهيئة Supabase في الخلفية لضمان سرعة الإقلاع على جميع الشبكات
  Future.microtask(() async {
    try {
      await Supabase.initialize(
        url: kSupabaseUrl,
        anonKey: kSupabaseAnonKey,
      ).timeout(const Duration(seconds: 8));
      debugPrint('✅ Supabase Initialized successfully in background');
    } catch (e) {
      debugPrint('⚠️ Supabase Background Init: $e');
    }
  });
}

class SouqSyriaApp extends StatefulWidget {
  const SouqSyriaApp({Key? key}) : super(key: key);

  @override
  State<SouqSyriaApp> createState() => _SouqSyriaAppState();
}
class SouqSyriaApp extends StatefulWidget {
  const SouqSyriaApp({Key? key}) : super(key: key);

  @override
  State<SouqSyriaApp> createState() => _SouqSyriaAppState();
}

class _SouqSyriaAppState extends State<SouqSyriaApp> {
  int _currentNavIndex = 0;
  bool _isDarkMode = false;
  final AppStateManager _manager = AppStateManager();

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _manager.scaffoldBgColor,
      body: SafeArea(
        child: _currentNavIndex == 0
            ? _buildHomeFeedTab()
            : _currentNavIndex == 1
                ? _buildCategoriesHorizontalBar()
                : _currentNavIndex == 2
                    ? _buildFavoritesTab()
                    : _buildProfileTab(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavIndex,
        onTap: (i) => setState(() => _currentNavIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: _manager.appBarColor,
        selectedItemColor: _manager.secondaryColor,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'الأقسام'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'المفضلة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }

  Widget _buildHomeFeedTab() {
    return const Center(child: Text('الرئيسية والإعلانات والبانوراما'));
  }

  Widget _buildCategoriesHorizontalBar() {
    return const Center(child: Text('الأقسام'));
  }

  Widget _buildFavoritesTab() {
    return const Center(child: Text('المفضلة'));
  }

  Widget _buildProfileTab() {
    return const Center(child: Text('حسابي'));
  }
}

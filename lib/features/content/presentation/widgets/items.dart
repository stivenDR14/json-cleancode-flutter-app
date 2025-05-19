import 'package:flutter/material.dart';
import 'package:mint_test/core/constants/theme/app_colors.dart';
import 'package:mint_test/core/constants/theme/app_theme.dart';
import '../../domain/entities/resource_class.dart';
import 'table.dart';

class Items extends StatefulWidget {
  final Resource resource;

  const Items({super.key, required this.resource});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String fullName = '${widget.resource.firstName} ${widget.resource.name}';
    final hasCertificates = widget.resource.certificates.isNotEmpty;

    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightBorder,
              border: Border.all(color: AppColors.divider, width: 1),
            ),
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.resource.photo),
              backgroundColor: AppColors.lightBorder,
            ),
          ),
          title: Text(
            fullName,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Text(
            widget.resource.userId,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          trailing:
              hasCertificates
                  ? IconButton(
                    icon: AnimatedRotation(
                      turns: _expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                    onPressed: _toggleExpand,
                  )
                  : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          child:
              _expanded && hasCertificates
                  ? Padding(
                    padding: const EdgeInsets.only(
                      left: AppTheme.pagePadding,
                      right: AppTheme.pagePadding,
                      bottom: 8,
                    ),
                    child: CertificatesTable(
                      certificates: widget.resource.certificates,
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

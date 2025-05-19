import 'package:flutter/material.dart';
import 'package:mint_test/config/di/locator.dart';
import 'package:mint_test/core/constants/localization/localization_class.dart';
import 'package:mint_test/core/constants/theme/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final VoidCallback? onCleared;
  final String? hintText;

  const CustomSearchBar({super.key, this.onCleared, this.hintText});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final localizationClass = locator<LocalizationsClass>();

  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  bool _isFocused = false;
  bool _showCancelButton = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (_isFocused) {
        _showCancelButton = true; // Prepare to show
        _animationController.forward(); // Start animation
      } else {
        if (_textController.text.isEmpty) {
          _animationController.reverse().then((_) {
            if (mounted) {
              setState(() {
                _showCancelButton = false; // Hide after animation
              });
            }
          });
        }
      }
    });
  }

  void _onCancel() {
    _textController.clear();
    _focusNode.unfocus();
    if (widget.onCleared != null) {
      widget.onCleared!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String hint =
        widget.hintText ?? localizationClass.messages()['search'] as String;
    final String cancelText = localizationClass.messages()['cancel'] as String;

    Widget searchFieldSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.searchBarBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.search, color: AppColors.textHint),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: AppColors.textHint),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );

    Widget animatedCancelButton = SizeTransition(
      sizeFactor: _widthAnimation,
      axis: Axis.horizontal,
      axisAlignment: -1.0,
      child: GestureDetector(
        onTap: _onCancel,
        child: Container(
          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
          alignment: Alignment.center,
          child: Text(
            cancelText,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );

    return Row(
      children: <Widget>[
        Expanded(child: searchFieldSection),
        if (_showCancelButton || !_animationController.isDismissed)
          animatedCancelButton,
      ],
    );
  }
}

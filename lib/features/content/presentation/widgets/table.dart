import 'package:flutter/material.dart';
import 'package:mint_test/core/constants/theme/app_colors.dart';

class CertificatesTable extends StatelessWidget {
  final List<String> certificates;

  const CertificatesTable({super.key, required this.certificates});

  @override
  Widget build(BuildContext context) {
    if (certificates.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.itemsBackground,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: const Text(
            'Certificates',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
        ...List.generate(certificates.length, (index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    certificates[index],
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              if (index != certificates.length - 1)
                const Divider(
                  color: AppColors.divider,
                  height: 1,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
            ],
          );
        }),
      ],
    );
  }
}

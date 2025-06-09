import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/family_member.dart';
import '../../core/constants/app_constants.dart';

class FamilyMemberMarker extends StatelessWidget {
  final FamilyMember member;
  final bool isSelected;
  final VoidCallback onTap;

  const FamilyMemberMarker({
    super.key,
    required this.member,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.shortAnimation,
        width: isSelected ? 70 : 60,
        height: isSelected ? 70 : 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Shadow
            Container(
              width: isSelected ? 65 : 55,
              height: isSelected ? 65 : 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            
            // Border
            Container(
              width: isSelected ? 60 : 50,
              height: isSelected ? 60 : 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  width: isSelected ? 4 : 3,
                ),
              ),
            ),
            
            // Photo
            Container(
              width: isSelected ? 52 : 44,
              height: isSelected ? 52 : 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: member.photoUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Center(
                    child: Text(
                      member.initials,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: isSelected ? 16 : 14,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Center(
                    child: Text(
                      member.initials,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontSize: isSelected ? 16 : 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Selection indicator
            if (isSelected)
              Positioned(
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
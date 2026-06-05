import 'package:flutter/material.dart';

class AnimatedFavoriteButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const AnimatedFavoriteButton({
    super.key,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, 
      child: Padding(
        padding: const EdgeInsets.all(8.0), 
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          // Esta es la magia: altera la escala e infla el icono automáticamente al cambiar de estado
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: TweenSequence<double>([
                TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 50),
                TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 50),
              ]).animate(animation),
              child: child,
            );
          },
          // Flutter necesita llaves únicas para saber cuándo aplicar la animación de transición
          child: isLiked
              ? const Icon(
                  Icons.favorite,
                  key: ValueKey('liked'),
                  color: Colors.red,
                  size: 26,
                )
              : const Icon(
                  Icons.favorite_border,
                  key: ValueKey('unliked'),
                  color: Colors.white70,
                  size: 26,
                ),
        ),
      ),
    );
  }
}
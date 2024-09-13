import 'dart:math'; // Para rotação do ícone

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Para ligar

class CallPoliceWidget extends StatefulWidget {
  const CallPoliceWidget({super.key});

  @override
  _CallPoliceWidgetState createState() => _CallPoliceWidgetState();
}

class _CallPoliceWidgetState extends State<CallPoliceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _iconColorAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _textOpacityAnimation;

  double _dragOffset = 0.0;
  bool _calling = false; // Estado para controlar o texto

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _iconColorAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.green,
    ).animate(_controller);

    _iconRotationAnimation = Tween<double>(
      begin: 0,
      end: pi * 2,
    ).animate(_controller);

    _textOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  Future<void> _callPolice() async {
    setState(() {
      _calling = true; // Define que o usuário está ligando
    });

    const url = 'tel:190';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível ligar para $url';
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta!;
      _dragOffset = _dragOffset.clamp(0.0, 240.0);

      double normalizedDrag = _dragOffset / 240;
      _controller.value = normalizedDrag;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset >= 230) {
      _callPolice();
      _controller.reset();
      setState(() {
        _dragOffset = 0.0;
      });
    } else {
      final double reverseDuration = (240 - _dragOffset) / 240;

      _controller
          .animateBack(0.0,
              duration: Duration(milliseconds: (400 * reverseDuration).toInt()),
              curve: Curves.easeOut)
          .whenComplete(() {
        if (mounted) {
          setState(() {
            _dragOffset = 0.0;
            _calling = false; // Reset do estado ao retornar
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(left: 24),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textOpacityAnimation.value,
                      child: Text(
                        _calling
                            ? "Ligando para Polícia..."
                            : "Ligar para Polícia",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: _dragOffset),
                padding: const EdgeInsets.all(16),
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _dragOffset >= 230
                          ? _iconRotationAnimation
                              .value // Gira somente se for suficiente
                          : 0.0, // Sem rotação ao retornar
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: _iconColorAnimation.value,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Icon(
                          Icons.phone,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

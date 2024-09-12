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
  // Controlador de animação
  late AnimationController _controller;
  late Animation<Color?> _iconColorAnimation;
  late Animation<double> _iconRotationAnimation;
  late Animation<double> _textPositionAnimation;

  // Offset atual do arrastar
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Animação para a cor do ícone de telefone
    _iconColorAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.green,
    ).animate(_controller);

    // Animação para a rotação do ícone
    _iconRotationAnimation =
        Tween<double>(begin: 0, end: pi * 2).animate(_controller);

    // Animação para a posição do texto (vai subir ao arrastar)
    _textPositionAnimation = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  // Função para ligar para o 190
  void _callPolice() async {
    const url = 'tel:190';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível ligar para $url';
    }
  }

  // Função chamada durante o arrastar
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta!;

      // Define limites para o arrastar
      if (_dragOffset < 0) {
        _dragOffset = 0;
      }
      if (_dragOffset > 240) _dragOffset = 240;

      // Atualiza a animação com base na posição do arrasto
      _controller.value = _dragOffset / 240;
    });
  }

  // Função chamada quando o arrastar termina
  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragOffset >= 230) {
      _callPolice();
    }

    // Reseta a animação e a posição do arrasto
    setState(() {
      _dragOffset = 0;
      _controller.reverse();
    });
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
            // Texto "Ligar para Polícia"
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Transform.translate(
                  offset: Offset(0, -_textPositionAnimation.value * 3),
                  child: const Text(
                    "Ligar para Polícia",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Ícone de telefone com animação de cor e rotação
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: _dragOffset),
                padding: const EdgeInsets.all(16),
                child: Transform.rotate(
                  angle: _iconRotationAnimation.value,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

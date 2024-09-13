import 'dart:math';

import 'package:flutter/material.dart';

Color generateRandomColor() {
  Random random = Random();
  // Gera valores aleatórios para os componentes R, G, e B da cor
  return Color.fromARGB(
    255, // Alpha é fixo para 255 (totalmente opaco)
    random.nextInt(256), // Valor aleatório de 0 a 255 para o componente Red
    random.nextInt(256), // Valor aleatório de 0 a 255 para o componente Green
    random.nextInt(256), // Valor aleatório de 0 a 255 para o componente Blue
  );
}

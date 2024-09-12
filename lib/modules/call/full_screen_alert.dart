import 'package:audioplayers/audioplayers.dart';
import 'package:emergency_app/main.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class FullScreenNotificationScreen extends StatefulWidget {
  const FullScreenNotificationScreen({
    super.key,
  });

  @override
  _FullScreenNotificationScreenState createState() =>
      _FullScreenNotificationScreenState();
}

class _FullScreenNotificationScreenState
    extends State<FullScreenNotificationScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _startNotification();
  }

  void _startNotification() async {
    // Tocar áudio em loop
    await _audioPlayer.setSource(AssetSource('audios/alert.mp3'));
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(AssetSource('audios/alert.mp3'));

    // Iniciar vibração contínua
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 10000, repeat: 1); // Vibração contínua
    }
  }

  @override
  void dispose() {
    _audioPlayer.stop(); // Parar áudio ao fechar a tela
    Vibration.cancel(); // Parar vibração ao fechar a tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigatorKey.currentState!.pushReplacementNamed('/call'),
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Alerta de Emergência',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

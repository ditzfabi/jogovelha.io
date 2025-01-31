import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JogoDaVelha(),
    );
  }
}

class JogoDaVelha extends StatefulWidget {
  @override
  _JogoDaVelhaState createState() => _JogoDaVelhaState();
}

class _JogoDaVelhaState extends State<JogoDaVelha> {
  List<String> _board = List.generate(9, (index) => ''); // Tabuleiro vazio
  bool _isXTurn = true; // Inicia com o jogador X
  String _message = "É a vez do X!";

  // Função para verificar se alguém ganhou
  bool _checkWinner(String player) {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (_board[combination[0]] == player &&
          _board[combination[1]] == player &&
          _board[combination[2]] == player) {
        return true;
      }
    }

    return false;
  }

  // Função para processar a jogada
  void _makeMove(int index) {
    setState(() {
      if (_board[index] == '') {
        _board[index] = _isXTurn ? 'X' : 'O';
        if (_checkWinner(_board[index])) {
          _message = '${_isXTurn ? 'X' : 'O'} ganhou!';
        } else {
          _isXTurn = !_isXTurn;
          _message = _isXTurn ? "É a vez do X!" : "É a vez do O!";
        }
      }
    });
  }

  // Função para reiniciar o jogo
  void _resetGame() {
    setState(() {
      _board = List.generate(9, (index) => ''); // Limpa o tabuleiro
      _isXTurn = true; // Reseta para o X começar
      _message = "É a vez do X!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe a mensagem de status
            Text(
              _message,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Tabuleiro (3x3)
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _makeMove(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: _board[index] == 'X' ? Colors.blue : (_board[index] == 'O' ? Colors.red : Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Botão de reiniciar
            ElevatedButton(
              onPressed: _resetGame,
              child: Text("Reiniciar Jogo", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

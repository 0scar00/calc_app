import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator - Your Name',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _expression = '';
  String _result = '';

  // Method to handle button presses
  void _onPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        _evaluateExpression();
      } else {
        _expression += value;
      }
    });
  }

  // Method to evaluate the expression using the expressions package
  void _evaluateExpression() {
    try {
      final expression = Expression.parse(_expression);
      final evaluator = const ExpressionEvaluator();
      final result = evaluator.eval(expression, {});
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator - Your Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display area for the expression and result
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _expression,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _result,
                      style: const TextStyle(fontSize: 48, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ),
            // Calculator buttons layout
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                // First row of buttons
                _buildButton('7'), _buildButton('8'), _buildButton('9'), _buildButton('/'),
                // Second row of buttons
                _buildButton('4'), _buildButton('5'), _buildButton('6'), _buildButton('*'),
                // Third row of buttons
                _buildButton('1'), _buildButton('2'), _buildButton('3'), _buildButton('-'),
                // Fourth row of buttons
                _buildButton('C'), _buildButton('0'), _buildButton('='), _buildButton('+'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget for building calculator buttons
  Widget _buildButton(String value) {
    return ElevatedButton(
      onPressed: () => _onPressed(value),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}

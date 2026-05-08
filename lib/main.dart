import 'package:flutter/material.dart';

void main() => runApp(const AppEdad());

class AppEdad extends StatelessWidget {
  const AppEdad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Edad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),
      home: const PantallaEdad(),
    );
  }
}

class PantallaEdad extends StatefulWidget {
  const PantallaEdad({super.key});

  @override
  State<PantallaEdad> createState() => _PantallaEdadState();
}

class _PantallaEdadState extends State<PantallaEdad> {

  final TextEditingController _controller =
  TextEditingController();

  int? _edad;
  String? _error;

  void _calcularEdad() {

    final texto = _controller.text.trim();
    final anio = int.tryParse(texto);
    final anioActual = DateTime.now().year;

    setState(() {

      if (anio == null) {

        _error = "Ingrese un año válido";
        _edad = null;

      } else if (anio < 1900 || anio > anioActual) {

        _error =
        "El año debe estar entre 1900 y $anioActual";
        _edad = null;

      } else {

        _error = null;
        _edad = anioActual - anio;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Calculadora de Edad"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.stretch,

          children: [

            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 4,

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Año de nacimiento",
                errorText: _error,
                prefixIcon:
                const Icon(Icons.cake),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: _calcularEdad,
              icon: const Icon(Icons.calculate),
              label:
              const Text("Calcular edad"),
            ),

            const SizedBox(height: 30),

            if (_edad != null)
              Card(
                child: Padding(
                  padding:
                  const EdgeInsets.all(20),

                  child: Text(
                    "Tu edad es $_edad años",
                    textAlign: TextAlign.center,

                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
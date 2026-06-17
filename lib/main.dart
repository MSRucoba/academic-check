import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

// --- COLORES PSICODÉLICOS ---
const Color neonPink = Color(0xFFFF007F);
const Color neonCyan = Color(0xFF00FFFF);
const Color neonGreen = Color(0xFF00FF00);
const Color darkBg = Color(0xFF0A0014);
const Color darkPanel = Color(0xFF1A0033);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Check',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: darkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: neonPink,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Courier', // Fuente estilo hacker/psicodélico
      ),
      home: const PsychoSplashScreen(),
    );
  }
}

// --- SPLASH SCREEN LOCAZO ---
class PsychoSplashScreen extends StatefulWidget {
  const PsychoSplashScreen({super.key});

  @override
  State<PsychoSplashScreen> createState() => _PsychoSplashScreenState();
}

class _PsychoSplashScreenState extends State<PsychoSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navegar a la página principal después de 4 segundos
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PromedioPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a0033), Color(0xFF001a33), Color(0xFF33001a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Caballo Gigante
            const Text(
              "🐎",
              style: TextStyle(
                fontSize: 120,
                shadows: [
                  Shadow(color: neonPink, blurRadius: 30),
                  Shadow(color: neonCyan, blurRadius: 60),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Texto Glitch simulado
            const Text(
              "WELCOME TO\nACADEMIC CHECK",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: neonCyan,
                shadows: [
                  Shadow(color: neonPink, offset: Offset(3, 3), blurRadius: 5),
                  Shadow(color: neonGreen, offset: Offset(-3, -3), blurRadius: 5),
                ],
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "MAKANAKI BOTAME TU GAAAAA 🚀",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: neonGreen,
                shadows: [Shadow(color: neonGreen, blurRadius: 15)],
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              color: neonPink,
              backgroundColor: neonCyan,
            ),
          ],
        ),
      ),
    );
  }
}

// --- PÁGINA PRINCIPAL ---
class PromedioPage extends StatefulWidget {
  const PromedioPage({super.key});

  @override
  State<PromedioPage> createState() => _PromedioPageState();
}

class _PromedioPageState extends State<PromedioPage> {
  // Estado para colapsar/expandir pesos
  bool _pesosExpandidos = false;

  // --- CONTROLADORES DE NOTAS ---
  final _u1Es = TextEditingController();
  final _u1Ep = TextEditingController();
  final _u2Es = TextEditingController();
  final _u2Ep = TextEditingController();
  final _u3Es = TextEditingController();
  final _u3Ep = TextEditingController();
  final _ecg = TextEditingController();

  // --- CONTROLADORES DE PESOS ---
  final _wU1Es = TextEditingController(text: "5");
  final _wU1Ep = TextEditingController(text: "15");
  final _wU2Es = TextEditingController(text: "5");
  final _wU2Ep = TextEditingController(text: "30");
  final _wU3Es = TextEditingController(text: "10");
  final _wU3Ep = TextEditingController(text: "25");
  
  final _wTotalEs = TextEditingController(text: "20");
  final _wTotalEp = TextEditingController(text: "70");
  final _wTotalEcg = TextEditingController(text: "10");

  double? _notaFinal;
  String _mensaje = "";

  void _calcular() {
    setState(() {
      double nU1es = double.tryParse(_u1Es.text) ?? 0;
      double nU1ep = double.tryParse(_u1Ep.text) ?? 0;
      double nU2es = double.tryParse(_u2Es.text) ?? 0;
      double nU2ep = double.tryParse(_u2Ep.text) ?? 0;
      double nU3es = double.tryParse(_u3Es.text) ?? 0;
      double nU3ep = double.tryParse(_u3Ep.text) ?? 0;
      double nEcg = double.tryParse(_ecg.text) ?? 0;

      double wU1es = double.tryParse(_wU1Es.text) ?? 0;
      double wU1ep = double.tryParse(_wU1Ep.text) ?? 0;
      double wU2es = double.tryParse(_wU2Es.text) ?? 0;
      double wU2ep = double.tryParse(_wU2Ep.text) ?? 0;
      double wU3es = double.tryParse(_wU3Es.text) ?? 0;
      double wU3ep = double.tryParse(_wU3Ep.text) ?? 0;
      
      double wT_Es = (double.tryParse(_wTotalEs.text) ?? 0) / 100;
      double wT_Ep = (double.tryParse(_wTotalEp.text) ?? 0) / 100;
      double wT_Ecg = (double.tryParse(_wTotalEcg.text) ?? 0) / 100;

      double sumaPesosEs = wU1es + wU2es + wU3es;
      double sumaPesosEp = wU1ep + wU2ep + wU3ep;

      double promedioES = sumaPesosEs > 0 ? (nU1es * wU1es + nU2es * wU2es + nU3es * wU3es) / sumaPesosEs : 0;
      double promedioEP = sumaPesosEp > 0 ? (nU1ep * wU1ep + nU2ep * wU2ep + nU3ep * wU3ep) / sumaPesosEp : 0;

      if (promedioEP < 12.50) {
        _notaFinal = promedioEP;
        _mensaje = "Desaprobado: EP < 12.5 💀";
      } else {
        _notaFinal = (promedioES * wT_Es) + (promedioEP * wT_Ep) + (nEcg * wT_Ecg);
        _mensaje = _notaFinal! >= 10.5 ? "¡Aprobado! 🎉" : "Desaprobado 💀";
      }
    });
  }

  void _reset() {
    setState(() {
      for (var c in [_u1Es, _u1Ep, _u2Es, _u2Ep, _u3Es, _u3Ep, _ecg]) {
        c.clear();
      }
      _notaFinal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "ACADEMIC CHECK",
          style: TextStyle(
            color: neonCyan,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            shadows: [
              Shadow(color: neonPink, offset: Offset(2, 2), blurRadius: 4),
            ],
          ),
        ),
        centerTitle: true,
        leading: const Center(
          child: Text("🐎", style: TextStyle(fontSize: 24, shadows: [Shadow(color: neonGreen, blurRadius: 10)])),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: neonPink,
            height: 2.0,
            width: double.infinity,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- SECCIÓN DE PESOS COLAPSABLE ---
            Container(
              decoration: BoxDecoration(
                color: darkPanel.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: neonPink, width: 2),
                boxShadow: const [BoxShadow(color: neonPink, blurRadius: 10)],
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => setState(() => _pesosExpandidos = !_pesosExpandidos),
                    title: const Text(
                      "CONFIGURACIÓN DE PESOS (%)", 
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, color: neonCyan, letterSpacing: 1),
                    ),
                    trailing: Icon(
                      _pesosExpandidos ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: neonPink,
                    ),
                    dense: true,
                  ),
                  if (_pesosExpandidos)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(
                        children: [
                          _buildWeightRow("U1", _wU1Es, _wU1Ep),
                          _buildWeightRow("U2", _wU2Es, _wU2Ep),
                          _buildWeightRow("U3", _wU3Es, _wU3Ep),
                          const Divider(color: neonPink),
                          Row(
                            children: [
                              Expanded(child: _buildSmallInput(_wTotalEs, "T. ES %")),
                              const SizedBox(width: 5),
                              Expanded(child: _buildSmallInput(_wTotalEp, "T. EP %")),
                              const SizedBox(width: 5),
                              Expanded(child: _buildSmallInput(_wTotalEcg, "T. ECG %")),
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // --- SECCIÓN DE NOTAS ---
            _buildUnidadCard("UNIDAD 1", _u1Es, "Nota ES", _u1Ep, "Nota EP"),
            _buildUnidadCard("UNIDAD 2", _u2Es, "Nota ES", _u2Ep, "Nota EP"),
            _buildUnidadCard("UNIDAD 3", _u3Es, "Nota ES", _u3Ep, "Nota EP"),
            
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: darkPanel,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: neonCyan, width: 2),
                boxShadow: const [BoxShadow(color: neonCyan, blurRadius: 10)],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _ecg,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    labelText: "Nota ECG (Competencia Genérica)",
                    labelStyle: TextStyle(color: neonCyan),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: neonPink)),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: neonGreen, width: 2)),
                    prefixIcon: Icon(Icons.star, color: neonGreen),
                  ),
                ),
              ),
            ),

            // BOTONES ÉPICOS
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: neonGreen, blurRadius: 15)],
                    ),
                    child: ElevatedButton(
                      onPressed: _calcular,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: neonGreen,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text("CALCULAR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2)),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: neonPink, blurRadius: 15)],
                    ),
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: neonPink, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.black.withOpacity(0.5),
                        foregroundColor: neonPink,
                      ),
                      child: const Text("RESET", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2)),
                    ),
                  ),
                ),
              ],
            ),

            if (_notaFinal != null) ...[
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [neonPink, neonCyan],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: const [
                    BoxShadow(color: neonPink, blurRadius: 20),
                    BoxShadow(color: neonCyan, blurRadius: 40),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "PROMEDIO FINAL", 
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black, letterSpacing: 2)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _notaFinal!.toStringAsFixed(2), 
                      style: const TextStyle(
                        fontSize: 60, 
                        fontWeight: FontWeight.w900, 
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 5)]
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _mensaje, 
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildWeightRow(String label, TextEditingController c1, TextEditingController c2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 40, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, color: neonGreen, fontSize: 16))),
          Expanded(child: _buildSmallInput(c1, "ES %")),
          const SizedBox(width: 10),
          Expanded(child: _buildSmallInput(c2, "EP %")),
        ],
      ),
    );
  }

  Widget _buildSmallInput(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: neonPink),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonCyan)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonGreen, width: 2)),
      ),
    );
  }

  Widget _buildUnidadCard(String titulo, TextEditingController c1, String l1, TextEditingController c2, String l2) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: darkPanel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: neonCyan, width: 2),
        boxShadow: const [BoxShadow(color: neonCyan, blurRadius: 8)],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo, 
              style: const TextStyle(fontWeight: FontWeight.w900, color: neonGreen, fontSize: 16, letterSpacing: 2)
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c1, 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: l1, 
                      labelStyle: const TextStyle(color: neonPink),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonCyan)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonGreen, width: 2)),
                      isDense: true,
                    ), 
                    keyboardType: TextInputType.number
                  )
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: c2, 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: l2, 
                      labelStyle: const TextStyle(color: neonPink),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonCyan)),
                      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: neonGreen, width: 2)),
                      isDense: true,
                    ), 
                    keyboardType: TextInputType.number
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();

  DateTime fechaSeleccionada = DateTime.now();
  var formatFecha = DateFormat('dd-MM-yyyy');

  String jornadaSeleccionada = 'd';

  bool estudiaGratuidad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Formularios'),
      ),
      body: Form(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                campoNombres(),
                campoApellidos(),
                campoEmail(),
                campoHijos(),
                campoFechaNacimiento(),
                campoJornada(),
                campoGratuidad(),
              ],
            ),
          ),
          key: formKey),
    );
  }

  TextFormField campoNombres() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Nombres',
        hintText: 'Escriba su primer y segundo nombre.',
      ),
    );
  }

  TextFormField campoApellidos() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Apellidos',
        hintText: 'Escriba su primer y segundo apellido.',
      ),
    );
  }

  TextFormField campoEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Escriba su dirección de correo.',
      ),
    );
  }

  TextFormField campoHijos() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Cantidad hijos',
        hintText: 'Escriba cuantos hijos tiene.',
      ),
    );
  }

  Row campoFechaNacimiento() {
    return Row(
      children: [
        Text('Fecha Nacimiento: ', style: TextStyle(fontSize: 16)),
        Text(formatFecha.format(fechaSeleccionada),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Spacer(),
        IconButton(
          onPressed: () => showDatePicker(
            context: context,
            initialDate: DateTime.now(), // Para la fecha de hoy
            firstDate: DateTime(1922),
            lastDate: DateTime.now(),
            locale: Locale('es', 'ES'), // Calendario en español
          ).then((fecha) =>
              setState(() => fechaSeleccionada = fecha ?? fechaSeleccionada)),
          // foo = bar ?? foo, si bar es null se queda con el valor de foo
          icon: Icon(MdiIcons.calendar, color: Colors.purple),
        )
      ],
    );
  }

  Column campoJornada() {
    return Column(
      children: [
        RadioListTile<String>(
          value: 'd',
          groupValue: jornadaSeleccionada,
          onChanged: (jornada) =>
              setState(() => jornadaSeleccionada = jornada!),
          title: Text('Jornada Diurna'),
        ),
        RadioListTile<String>(
          value: 'v',
          groupValue: jornadaSeleccionada,
          onChanged: (jornada) =>
              setState(() => jornadaSeleccionada = jornada!),
          title: Text('Jornada Vespertina'),
        ),
        RadioListTile<String>(
          value: 'e',
          groupValue: jornadaSeleccionada,
          onChanged: (jornada) =>
              setState(() => jornadaSeleccionada = jornada!),
          title: Text('Jornada Ejecutiva'),
        )
      ],
    );
  }

  SwitchListTile campoGratuidad() {
    return SwitchListTile(
      title: Text('Estudia gratuidad'),
      value: estudiaGratuidad,
      onChanged: (gratuidad) => setState(() => estudiaGratuidad = gratuidad),
    );
  }
}
// Uilizamos la dependencia intL => flutter pub add intl
// Tambien utilizamos localizations la que hay que escribirla directamente
// en dependencys de pubspec.yaml
// flutter_localizations:
//  sdk: flutter
// Concepto futuro en flutter
// Hay acciones que no están sincronizadas, y no dependen de terceros
// un sistema interno o un usuario. No se sabe cuanto le tomará al usuario
// apretar el botoncito, pero si se sabe que se hará en el futuro
// Con flutter se puede atrapar en un evento ese futuro cuando se materializa 
// y lo puede programar
// Evento 'then'
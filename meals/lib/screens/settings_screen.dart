import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChange;
  const SettingsScreen(this.settings, this.onSettingsChange, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChange(settings);
      },
    );
  }

  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configurações',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Glúten',
                  'Só exibe refeições sem glúten',
                  settings.isGlutenFree,
                  (value) => setState(() {
                    settings.isGlutenFree = value;
                  }),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Só exibe refeições sem Lactose',
                  settings.isLactoseFree,
                  (value) => setState(() {
                    settings.isLactoseFree = value;
                  }),
                ),
                _createSwitch(
                  'Vegana',
                  'Só exibe refeições Veganas',
                  settings.isVegan,
                  (value) => setState(() {
                    settings.isVegan = value;
                  }),
                ),
                _createSwitch(
                  'Vegetariana',
                  'Só exibe refeições Vegetarianas',
                  settings.isVegetarian,
                  (value) => setState(() {
                    settings.isVegetarian = value;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilter;
  FilterScreen(this.currentFilter, this.saveFilters);
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _gultenFree = false;
  var _vegetrian = false;
  var _vegan = false;
  var _lactosFree = false;
  @override
  initState() {
    _gultenFree = widget.currentFilter['gluten']!;
    _lactosFree = widget.currentFilter['lactose']!;
    _vegan = widget.currentFilter['vegan']!;
    _vegetrian = widget.currentFilter['vegetrian']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String description, var currentValue, var updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _gultenFree,
                'lactose': _lactosFree,
                'vegan': _vegan,
                'vegetrian': _vegetrian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your meal Selection',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only Include Gluten-free meals',
                  _gultenFree,
                  (newvalue) {
                    setState(() {
                      _gultenFree = newvalue;
                    });
                  },
                ),
                _buildSwitchListTile('Lactos-free',
                    'Only Include Lactose-free meals', _lactosFree, (newvalue) {
                  setState(() {
                    _lactosFree = newvalue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetrian', 'Only Include Vegetrian meals', _vegetrian,
                    (newvalue) {
                  setState(() {
                    _vegetrian = newvalue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only Include Vegan meals', _vegan, (newvalue) {
                  setState(() {
                    _vegan = newvalue;
                  });
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

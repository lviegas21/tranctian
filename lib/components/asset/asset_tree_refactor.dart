import 'package:flutter/material.dart';
import '../../models/assets_model.dart';
import '../../models/location_model.dart';

class AssetTree extends StatelessWidget {
  final List<LocationModel> locations;
  final List<AssetModel> assets;

  AssetTree({required this.locations, required this.assets});

  @override
  Widget build(BuildContext context) {
    final rootLocations =
        locations.where((location) => location.parentId == null).toList();
    return ListView.builder(
      itemCount: rootLocations.length,
      itemBuilder: (context, index) {
        return EntryItem(
          entry: rootLocations[index],
          allLocations: locations,
          allAssets: assets,
          level: 0,
        );
      },
    );
  }
}

class EntryItem extends StatefulWidget {
  final dynamic entry;
  final List<LocationModel> allLocations;
  final List<AssetModel> allAssets;
  final int level;

  const EntryItem({
    required this.entry,
    required this.allLocations,
    required this.allAssets,
    required this.level,
    Key? key,
  }) : super(key: key);

  @override
  _EntryItemState createState() => _EntryItemState();
}

class _EntryItemState extends State<EntryItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final subLocations = widget.allLocations
        .where((location) => location.parentId == widget.entry.id)
        .toList();
    final associatedAssets = widget.allAssets
        .where((asset) => asset.locationId == widget.entry.id)
        .toList();
    final subAssets = widget.allAssets
        .where((asset) => asset.parentId == widget.entry.id)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: widget.level * 16.0, top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                    size: 24),
                SizedBox(width: 8),
                Icon(
                  widget.entry is LocationModel
                      ? Icons.location_on
                      : Icons.build,
                  size: 24,
                  color: widget.entry is LocationModel
                      ? Colors.blue
                      : Colors.orange,
                ),
                SizedBox(width: 12),
                Flexible(
                  child: Text(
                    widget.entry.name.toUpperCase(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...subLocations.map((subLocation) {
                  return EntryItem(
                    entry: subLocation,
                    allLocations: widget.allLocations,
                    allAssets: widget.allAssets,
                    level: widget.level + 1,
                  );
                }).toList(),
                ...associatedAssets.map((asset) {
                  return EntryItem(
                    entry: asset,
                    allLocations: widget.allLocations,
                    allAssets: widget.allAssets,
                    level: widget.level + 1,
                  );
                }).toList(),
                ...subAssets.map((asset) {
                  return EntryItem(
                    entry: asset,
                    allLocations: widget.allLocations,
                    allAssets: widget.allAssets,
                    level: widget.level + 1,
                  );
                }).toList(),
                if (widget.entry is AssetModel &&
                    widget.entry.sensorType != null)
                  Padding(
                    padding: EdgeInsets.only(
                        left: (widget.level + 1) * 16.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          widget.entry.sensorType == 'energy'
                              ? Icons.bolt
                              : Icons.build,
                          color: widget.entry.sensorType == 'energy'
                              ? Colors.green
                              : Colors.blue,
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            widget.entry.name,
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (widget.entry.status == 'critical')
                          Icon(Icons.error, color: Colors.red, size: 24),
                        if (widget.entry.status == 'operating')
                          Icon(Icons.check_circle,
                              color: Colors.green, size: 24),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

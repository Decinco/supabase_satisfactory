class Building {
  late int id;
  late String buildingClass;
  late String buildingName;
  late bool overclockable;
  int? somersloopSlots;
  double? energyConsumption;
  double? minimumEnergyConsumption;
  double? energyProduction;
  double? minimumEnergyProduction;
  int? conveyorInputs;
  int? pipeInputs;
  int? conveyorOutputs;
  int? pipeOutputs;

  Building({
    required this.id,
    required this.buildingClass,
    required this.buildingName,
    required this.overclockable,
    this.somersloopSlots,
    this.energyConsumption,
    this.minimumEnergyConsumption,
    this.energyProduction,
    this.minimumEnergyProduction,
    this.conveyorInputs,
    this.pipeInputs,
    this.conveyorOutputs,
    this.pipeOutputs,
  });

  Building.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildingClass = json['buildingClass'];
    buildingName = json['buildingName'];
    overclockable = json['overclockable'];
    somersloopSlots = json['somersloopSlots'];
    energyConsumption = json['energyConsumption'] != null ? double.parse(json['energyConsumption'].toString()) : null;
    minimumEnergyConsumption = json['minimumEnergyConsumption'] != null ? double.parse(json['minimumEnergyConsumption'].toString()) : null;
    energyProduction = json['energyProduction'] != null ? double.parse(json['energyProduction'].toString()) : null;
    minimumEnergyProduction = json['minimumEnergyProduction'] != null ? double.parse(json['minimumEnergyProduction'].toString()) : null;
    conveyorInputs = json['conveyorInputs'];
    pipeInputs = json['pipeInputs'];
    conveyorOutputs = json['conveyorOutputs'];
    pipeOutputs = json['pipeOutputs'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['building_class'] = buildingClass;
    data['building_name'] = buildingName;
    data['overclockable'] = overclockable;
    data['somersloop_slots'] = somersloopSlots;
    data['energy_consumption'] = energyConsumption;
    data['minimum_energy_consumption'] = minimumEnergyConsumption;
    data['energy_production'] = energyProduction;
    data['minimum_energy_production'] = minimumEnergyProduction;
    data['conveyor_inputs'] = conveyorInputs;
    data['pipe_inputs'] = pipeInputs;
    data['conveyor_outputs'] = conveyorOutputs;
    data['pipe_outputs'] = pipeOutputs;
    return data;
  }

  static List<Building> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Building.fromJson(e)).toList();
  }
}

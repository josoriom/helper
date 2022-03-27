class Elements {
  List<dynamic>? labels;
  dynamic atomicNumber;
  dynamic element;
  dynamic symbol;
  dynamic atomicMass;
  dynamic numberofNeutrons;
  dynamic numberofProtons;
  dynamic numberofElectrons;
  dynamic period;
  dynamic group;
  dynamic phase;
  dynamic radioactive;
  dynamic natural;
  dynamic metal;
  dynamic nonmetal;
  dynamic metalloid;
  dynamic type;
  dynamic atomicRadius;
  dynamic electronegativity;
  dynamic firstIonization;
  dynamic density;
  dynamic meltingPoint;
  dynamic boilingPoint;
  dynamic numberOfIsotopes;
  dynamic discoverer;
  dynamic year;
  dynamic specificHeat;
  dynamic numberofShells;
  dynamic numberofValence;
  dynamic color;

  Elements(
      {this.labels,
      required this.atomicNumber,
      required this.element,
      required this.symbol,
      required this.atomicMass,
      required this.numberofNeutrons,
      required this.numberofProtons,
      required this.numberofElectrons,
      required this.period,
      required this.group,
      required this.phase,
      required this.radioactive,
      required this.natural,
      required this.metal,
      required this.nonmetal,
      required this.metalloid,
      required this.type,
      required this.atomicRadius,
      required this.electronegativity,
      required this.firstIonization,
      required this.density,
      required this.meltingPoint,
      required this.boilingPoint,
      required this.numberOfIsotopes,
      required this.discoverer,
      required this.year,
      required this.specificHeat,
      required this.numberofShells,
      required this.numberofValence,
      required this.color});

  Elements.fromJson(Map<String, dynamic> json) {
    labels = json['labels'];
    atomicNumber = json['AtomicNumber'].toString();
    element = json['Element'].toString();
    symbol = json['Symbol'].toString();
    atomicMass = json['AtomicMass'].toString();
    numberofNeutrons = json['NumberofNeutrons'].toString();
    numberofProtons = json['NumberofProtons'].toString();
    numberofElectrons = json['NumberofElectrons'].toString();
    period = json['Period'].toString();
    group = json['Group'].toString();
    phase = json['Phase'].toString();
    radioactive = json['Radioactive'].toString();
    natural = json['Natural'].toString();
    metal = json['Metal'].toString();
    nonmetal = json['Nonmetal'].toString();
    metalloid = json['Metalloid'].toString();
    type = json['Type'].toString();
    atomicRadius = json['AtomicRadius'].toString();
    electronegativity = json['Electronegativity'].toString();
    firstIonization = json['FirstIonization'].toString();
    density = json['Density'].toString();
    meltingPoint = json['MeltingPoint'].toString();
    boilingPoint = json['BoilingPoint'].toString();
    numberOfIsotopes = json['NumberOfIsotopes'].toString();
    discoverer = json['Discoverer'].toString();
    year = json['Year'].toString();
    specificHeat = json['SpecificHeat'].toString();
    numberofShells = json['NumberofShells'].toString();
    numberofValence = json['NumberofValence'].toString();
    color = json['color'];
  }
}

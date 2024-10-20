// Enum to represent skills
enum Skill { FLUTTER, DART, OTHER }

// Address class with street, city, and zipCode attributes
class Address {
  final String street;
  final String city;
  final String zipCode;

  Address(this.street, this.city, this.zipCode);
}

// Employee class
class Employee {
  // Private attributes
  final String _name;
  final Address _address;
  final List<Skill> _skills;
  final int _yearsOfExperience;
  final double _baseSalary = 40000;

  // Default constructor
  Employee(this._name, this._address, this._skills, this._yearsOfExperience);

  // Named constructor for mobile developers
  Employee.mobileDeveloper(this._name, this._address, this._yearsOfExperience)
      : _skills = [Skill.FLUTTER, Skill.DART];

  // Getter methods for accessing private attributes
  String get name => _name;
  Address get address => _address;
  List<Skill> get skills => _skills;
  int get yearsOfExperience => _yearsOfExperience;

  // Method to compute the salary based on experience and skills
  double computeSalary() {
    double totalSalary = _baseSalary + (_yearsOfExperience * 2000);

    for (var skill in _skills) {
      if (skill == Skill.FLUTTER) {
        totalSalary += 5000;
      } else if (skill == Skill.DART) {
        totalSalary += 3000;
      } else {
        totalSalary += 1000;
      }
    }

    return totalSalary;
  }

  // Print employee details
  void printDetails() {
    print('Employee: $_name');
    print('Address: ${_address.street}, ${_address.city}, ${_address.zipCode}');
    print('Years of Experience: $_yearsOfExperience');
    print('Skills: ${_skills.map((skill) => skill.toString().split('.').last).join(', ')}');
    print('Base Salary: \$$_baseSalary');
    print('Computed Salary: \$${computeSalary()}');
  }
}

void main() {
  // Create an address
  Address address1 = Address("123 Main St", "Phnom Penh", "12345");

  // Create employees using default and named constructors
  var emp1 = Employee("Sokea", address1, [Skill.FLUTTER, Skill.OTHER], 5);
  emp1.printDetails();

  var emp2 = Employee.mobileDeveloper("Ronan", address1, 3);
  emp2.printDetails();
}

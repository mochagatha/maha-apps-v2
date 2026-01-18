# SOLID Principles in Practice

## Overview

SOLID is an acronym for five design principles that make software designs more understandable, flexible, and maintainable.

---

## 1. Single Responsibility Principle (SRP)

### Definition

**A class should have only one reason to change.**

Each class should have only one job or responsibility.

### Why It Matters

- Easier to understand
- Easier to test
- Easier to maintain
- Reduces coupling

### Examples

#### ❌ Violating SRP

```dart
// ❌ BAD: Multiple responsibilities
class UserManager {
  // Responsibility 1: Data fetching
  Future<User> fetchUser(int id) async {
    final response = await http.get('/users/$id');
    return User.fromJson(response.data);
  }
  
  // Responsibility 2: Data validation
  bool validateUser(User user) {
    return user.email.contains('@') && user.name.isNotEmpty;
  }
  
  // Responsibility 3: Data persistence
  Future<void> saveUser(User user) async {
    await database.insert('users', user.toJson());
  }
  
  // Responsibility 4: UI display
  Widget buildUserCard(User user) {
    return Card(child: Text(user.name));
  }
}
```

**Problems**:
- Changes to API affect validation logic
- Changes to UI affect data fetching
- Hard to test individual responsibilities
- Violates separation of concerns

#### ✅ Following SRP

```dart
// ✅ GOOD: Single responsibility - Data fetching
class UserRemoteDataSource {
  final ApiClient client;
  
  UserRemoteDataSource(this.client);
  
  Future<UserModel> fetchUser(int id) async {
    final response = await client.get('/users/$id');
    return UserModel.fromJson(response.data);
  }
}

// ✅ GOOD: Single responsibility - Business logic
class ValidateUser implements UseCase<bool, User> {
  @override
  bool call(User user) {
    return user.email.contains('@') && user.name.isNotEmpty;
  }
}

// ✅ GOOD: Single responsibility - Data persistence
class UserLocalDataSource {
  final Database database;
  
  UserLocalDataSource(this.database);
  
  Future<void> saveUser(UserModel user) async {
    await database.insert('users', user.toJson());
  }
}

// ✅ GOOD: Single responsibility - UI display
class UserCard extends StatelessWidget {
  final User user;
  
  const UserCard({required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Card(child: Text(user.name));
  }
}
```

---

## 2. Open/Closed Principle (OCP)

### Definition

**Software entities should be open for extension but closed for modification.**

You should be able to add new functionality without changing existing code.

### Why It Matters

- Reduces risk of breaking existing code
- Promotes code reuse
- Makes system more flexible

### Examples

#### ❌ Violating OCP

```dart
// ❌ BAD: Need to modify class to add new payment method
class PaymentProcessor {
  void processPayment(String type, double amount) {
    if (type == 'credit_card') {
      // Process credit card
    } else if (type == 'paypal') {
      // Process PayPal
    } else if (type == 'bank_transfer') {
      // Process bank transfer
    }
    // Need to modify this method to add new payment type!
  }
}
```

#### ✅ Following OCP

```dart
// ✅ GOOD: Abstract interface
abstract class PaymentMethod {
  Future<void> processPayment(double amount);
}

// ✅ GOOD: Concrete implementations
class CreditCardPayment implements PaymentMethod {
  @override
  Future<void> processPayment(double amount) async {
    // Process credit card payment
  }
}

class PayPalPayment implements PaymentMethod {
  @override
  Future<void> processPayment(double amount) async {
    // Process PayPal payment
  }
}

class BankTransferPayment implements PaymentMethod {
  @override
  Future<void> processPayment(double amount) async {
    // Process bank transfer
  }
}

// ✅ GOOD: Processor doesn't need modification
class PaymentProcessor {
  Future<void> process(PaymentMethod method, double amount) async {
    await method.processPayment(amount);
  }
}

// Adding new payment method doesn't require changing existing code
class CryptoPayment implements PaymentMethod {
  @override
  Future<void> processPayment(double amount) async {
    // Process crypto payment
  }
}
```

---

## 3. Liskov Substitution Principle (LSP)

### Definition

**Objects of a superclass should be replaceable with objects of its subclasses without breaking the application.**

Subtypes must be substitutable for their base types.

### Why It Matters

- Ensures polymorphism works correctly
- Prevents unexpected behavior
- Maintains contract of base class

### Examples

#### ❌ Violating LSP

```dart
// ❌ BAD: Violates LSP
abstract class Bird {
  void fly();
}

class Sparrow extends Bird {
  @override
  void fly() {
    print('Sparrow flying');
  }
}

class Penguin extends Bird {
  @override
  void fly() {
    throw Exception('Penguins cannot fly!'); // Violates LSP!
  }
}

// This breaks when using Penguin
void makeBirdFly(Bird bird) {
  bird.fly(); // Throws exception for Penguin!
}
```

#### ✅ Following LSP

```dart
// ✅ GOOD: Proper abstraction
abstract class Bird {
  void eat();
  void sleep();
}

abstract class FlyingBird extends Bird {
  void fly();
}

class Sparrow extends FlyingBird {
  @override
  void fly() => print('Sparrow flying');
  
  @override
  void eat() => print('Sparrow eating');
  
  @override
  void sleep() => print('Sparrow sleeping');
}

class Penguin extends Bird {
  void swim() => print('Penguin swimming');
  
  @override
  void eat() => print('Penguin eating');
  
  @override
  void sleep() => print('Penguin sleeping');
}

// Now works correctly for all birds
void feedBird(Bird bird) {
  bird.eat(); // Works for all birds
}

void makeFlyingBirdFly(FlyingBird bird) {
  bird.fly(); // Only accepts flying birds
}
```

---

## 4. Interface Segregation Principle (ISP)

### Definition

**Clients should not be forced to depend on interfaces they do not use.**

Many specific interfaces are better than one general-purpose interface.

### Why It Matters

- Reduces coupling
- Improves flexibility
- Makes code easier to refactor

### Examples

#### ❌ Violating ISP

```dart
// ❌ BAD: Fat interface
abstract class Worker {
  void work();
  void eat();
  void sleep();
  void attendMeeting();
  void writeCode();
  void designUI();
}

// Robot worker doesn't eat or sleep!
class RobotWorker implements Worker {
  @override
  void work() => print('Working');
  
  @override
  void eat() => throw UnimplementedError(); // Forced to implement!
  
  @override
  void sleep() => throw UnimplementedError(); // Forced to implement!
  
  @override
  void attendMeeting() => print('Attending meeting');
  
  @override
  void writeCode() => print('Writing code');
  
  @override
  void designUI() => throw UnimplementedError(); // Not a designer!
}
```

#### ✅ Following ISP

```dart
// ✅ GOOD: Segregated interfaces
abstract class Workable {
  void work();
}

abstract class Eatable {
  void eat();
}

abstract class Sleepable {
  void sleep();
}

abstract class Attendable {
  void attendMeeting();
}

abstract class Codeable {
  void writeCode();
}

abstract class Designable {
  void designUI();
}

// Implement only what's needed
class HumanWorker implements Workable, Eatable, Sleepable, Attendable, Codeable {
  @override
  void work() => print('Working');
  
  @override
  void eat() => print('Eating');
  
  @override
  void sleep() => print('Sleeping');
  
  @override
  void attendMeeting() => print('Attending meeting');
  
  @override
  void writeCode() => print('Writing code');
}

class RobotWorker implements Workable, Attendable, Codeable {
  @override
  void work() => print('Working');
  
  @override
  void attendMeeting() => print('Attending meeting');
  
  @override
  void writeCode() => print('Writing code');
}
```

---

## 5. Dependency Inversion Principle (DIP)

### Definition

**High-level modules should not depend on low-level modules. Both should depend on abstractions.**

**Abstractions should not depend on details. Details should depend on abstractions.**

### Why It Matters

- Reduces coupling between modules
- Makes code more flexible
- Easier to test (can mock dependencies)
- Easier to change implementations

### Examples

#### ❌ Violating DIP

```dart
// ❌ BAD: High-level depends on low-level
class MySQLDatabase {
  void save(String data) {
    print('Saving to MySQL: $data');
  }
}

class UserService {
  final MySQLDatabase database; // Depends on concrete class!
  
  UserService() : database = MySQLDatabase();
  
  void saveUser(String user) {
    database.save(user);
  }
}

// Cannot easily switch to PostgreSQL or MongoDB!
```

#### ✅ Following DIP

```dart
// ✅ GOOD: Depend on abstraction
abstract class Database {
  void save(String data);
}

// Low-level modules implement abstraction
class MySQLDatabase implements Database {
  @override
  void save(String data) {
    print('Saving to MySQL: $data');
  }
}

class PostgreSQLDatabase implements Database {
  @override
  void save(String data) {
    print('Saving to PostgreSQL: $data');
  }
}

class MongoDatabase implements Database {
  @override
  void save(String data) {
    print('Saving to MongoDB: $data');
  }
}

// High-level module depends on abstraction
class UserService {
  final Database database; // Depends on interface!
  
  UserService(this.database); // Injected dependency
  
  void saveUser(String user) {
    database.save(user);
  }
}

// Easy to switch implementations
void main() {
  // Use MySQL
  final mysqlService = UserService(MySQLDatabase());
  mysqlService.saveUser('John');
  
  // Switch to PostgreSQL without changing UserService
  final postgresService = UserService(PostgreSQLDatabase());
  postgresService.saveUser('Jane');
  
  // Switch to MongoDB
  final mongoService = UserService(MongoDatabase());
  mongoService.saveUser('Bob');
}
```

---

## SOLID in MAHA Apps V2

### Example: Home Feature

```dart
// 1. SRP: Each class has single responsibility
class GetEmployeeProfile {
  // Only responsible for getting employee profile
}

class HomeRemoteDataSource {
  // Only responsible for fetching from API
}

class HomeLocalDataSource {
  // Only responsible for caching
}

// 2. OCP: Open for extension
abstract class HomeRepository {
  Future<Either<Failure, Employee>> getEmployeeProfile();
}

// Can add new implementations without modifying interface
class HomeRepositoryImpl implements HomeRepository { }
class MockHomeRepository implements HomeRepository { }

// 3. LSP: Implementations are substitutable
void loadProfile(HomeRepository repository) {
  // Works with any implementation
  repository.getEmployeeProfile();
}

// 4. ISP: Specific interfaces
abstract class Readable {
  Future<Data> read();
}

abstract class Writable {
  Future<void> write(Data data);
}

// Implement only what's needed
class ReadOnlyCache implements Readable { }

// 5. DIP: Depend on abstractions
class HomeProvider {
  final GetEmployeeProfile getEmployeeProfile; // Abstract use case
  
  HomeProvider({required this.getEmployeeProfile});
}
```

---

## Benefits of SOLID

1. **Maintainability**: Easier to understand and modify
2. **Testability**: Easier to write unit tests
3. **Flexibility**: Easier to extend and adapt
4. **Reusability**: Components can be reused
5. **Scalability**: System grows without becoming complex

---

## Summary

| Principle | Key Point |
|-----------|-----------|
| **SRP** | One class, one responsibility |
| **OCP** | Open for extension, closed for modification |
| **LSP** | Subtypes must be substitutable |
| **ISP** | Many specific interfaces > one general interface |
| **DIP** | Depend on abstractions, not concretions |

Follow SOLID principles to create clean, maintainable, and scalable code!

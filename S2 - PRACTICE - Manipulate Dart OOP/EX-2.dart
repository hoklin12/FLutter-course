class BankAccount {
  // Private attributes
  final int _accountId;
  final String _accountOwner;
  double _balance;

  // Constructor
  BankAccount(this._accountId, this._accountOwner, [this._balance = 0]);

  // Getter for balance
  double get balance => _balance;

  // Withdraw method
  void withdraw(double amount) {
    if (_balance - amount < 0) {
      throw Exception("Insufficient balance for withdrawal!");
    }
    _balance -= amount;
  }

  // Credit method
  void credit(double amount) {
    _balance += amount;
  }
}

class Bank {
  final String name;
  final List<BankAccount> _accounts = [];

  // Constructor for Bank
  Bank({required this.name});

  // Create a new account, ensuring the account ID is unique
  BankAccount createAccount(int accountId, String accountOwner) {
    // Check if the account ID already exists
    for (var account in _accounts) {
      if (account._accountId == accountId) {
        throw Exception("Account with ID $accountId already exists!");
      }
    }

    // If not, create a new BankAccount and add it to the accounts list
    BankAccount newAccount = BankAccount(accountId, accountOwner);
    _accounts.add(newAccount);
    return newAccount;
  }

  // Get account by account ID
  BankAccount getAccountById(int accountId) {
    for (var account in _accounts) {
      if (account._accountId == accountId) {
        return account;
      }
    }
    throw Exception("Account with ID $accountId not found!");
  }
}

void main() {
  // Create a Bank
  Bank myBank = Bank(name: "CADT Bank");

  // Create a bank account for Ronan
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  // Display initial balance
  print('Balance: \$${ronanAccount.balance}'); // Balance: $0

  // Credit 100 to Ronan's account
  ronanAccount.credit(100);
  print('Balance: \$${ronanAccount.balance}'); // Balance: $100

  // Withdraw 50 from Ronan's account
  ronanAccount.withdraw(50);
  print('Balance: \$${ronanAccount.balance}'); // Balance: $50

  // Attempt to withdraw more than the balance
  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  // Attempt to create another account with the same ID
  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}

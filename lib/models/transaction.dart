class Transaction {
  final String id;
  final String type; // 'send', 'buy_goods', 'paybill', 'airtime'
  final String recipient;
  final double amount;
  final DateTime timestamp;
  final String status; // 'completed', 'failed', 'pending'
  final String? description;

  Transaction({
    required this.id,
    required this.type,
    required this.recipient,
    required this.amount,
    required this.timestamp,
    required this.status,
    this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      recipient: json['recipient'],
      amount: json['amount'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'recipient': recipient,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'description': description,
    };
  }
}

part of 'widgets.dart';

class CardList extends StatefulWidget {
  final Costs cost;
  const CardList(this.cost);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  String rupiahMoneyFormatter(int? value) {
    if (value == null) return "Rp0,00";
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 2,
    );
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    Costs cost = widget.cost;

    Cost firstCost = cost.cost?.isNotEmpty ?? false ? cost.cost![0] : Cost();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 16),
      color: const Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      child: ListTile(
          title: Text(
              style: TextStyle(color: Color.fromARGB(255, 155, 115, 195)),
              "${cost.description} (${cost.service})"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  style: TextStyle(color: Color.fromARGB(255, 155, 115, 195)),
                  "Biaya: ${rupiahMoneyFormatter(firstCost.value)}"),
              SizedBox(height: 4),
              Text(
                  style: TextStyle(color: const Color.fromARGB(255, 47, 85, 4), fontWeight: FontWeight.bold),
                  "Estimasi sampai: ${firstCost.etd} hari"),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 155, 115, 195),
            child: Icon(Icons.local_shipping, color: Color.fromARGB(255, 255, 255, 255)),
          )),
    );
  }
}
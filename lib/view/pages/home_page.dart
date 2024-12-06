part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  home_vm HomeViewModel = home_vm();

  @override
  void initState() {
    HomeViewModel.getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 215, 176, 254),
            shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
          title: Text(style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,), "Province Data" ),
          centerTitle: true),
      body: ChangeNotifierProvider<home_vm>(
          create: (context) =>HomeViewModel,
          child: Consumer<home_vm>(builder: (context, value, _) {
            switch (value.provinceList.status) {
              case Status.loading:
                return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: Color.fromARGB(255, 155, 115, 195)));
              case Status.error:
                return Align(
                    alignment: Alignment.center,
                    child: Text(value.provinceList.message.toString()));
              case Status.completed:
                return ListView.builder(
                    itemCount: value.provinceList.data?.length,
                    itemBuilder: (context, index) {
                      return CardProvince(
                          value.provinceList.data!.elementAt(index));
                    });
              default:
            }
            return Container();
          })),
    );
  }
}


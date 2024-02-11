import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewFirm extends StatefulWidget {
  const NewFirm({Key? key}) : super(key: key);

  @override
  State<NewFirm> createState() => _NewFirmState();
}

class _NewFirmState extends State<NewFirm> {

  bool _isLoading = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? newFirm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _oninit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('OPSV-firm',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),),//TextStyle
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
          ),
          _isLoading
              ? const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Please wait Data is fetching from Database"),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ),
          )
              : ListView.builder(
            itemCount: newFirm?.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        (newFirm?[i].data()['Company'] ?? "i").toString().substring(0, 1),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(newFirm?[i].data()['Company']),
                    isThreeLine: true,
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email:  ${newFirm?[i].data()['email']}',
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          'Password: ${newFirm?[i].data()['password']}',
                          style: TextStyle(fontSize: 11),
                        ),
                        Text(
                          'Ph.No: ${newFirm?[i].data()['phno']}',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    horizontalTitleGap: 20,
                    tileColor: Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      )
    );
  }

  Future<void> _oninit() async {
    _isLoading = true;
    refresh();
    final engineerCollection = await FirebaseFirestore.instance.collection('FirmData').get();
    newFirm = engineerCollection.docs;
    _isLoading = false;
    refresh();
  }

  void refresh() {
    if (this.mounted) setState(() {});
  }
}

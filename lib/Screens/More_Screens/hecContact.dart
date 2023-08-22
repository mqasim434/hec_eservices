import 'package:flutter/material.dart';

class HECContact extends StatefulWidget {
  const HECContact({Key? key}) : super(key: key);

  @override
  _HECContactState createState() => _HECContactState();
}

class _HECContactState extends State<HECContact> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey[50],
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "HEC Contacts",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ContactContainer(
                  textTheme: textTheme,
                  City: "Lahore",
                  Address:
                      "55 B Street, Block B2 Block B 2 Gulberg III, Lahore, Punjab 54000, Pakistan",
                  Phone: "+92-42-99263092, 94-96",
                  Mail: "info@Hec.gov.pk",
                  Photo: "https://i2.paktive.com/pnrm/51843723.jpg",
                ),
                ContactContainer(
                  textTheme: textTheme,
                  City: "Karachi",
                  Address:
                      "55 B Street, Block B2 Block B 2 Gulberg III, Lahore, Punjab 54000, Pakistan",
                  Phone: "+92-42-99263092, 94-96",
                  Mail: "info@Hec.gov.pk",
                  Photo: "https://pk.top10place.com/img_files/270983062975626",
                ),
                ContactContainer(
                  textTheme: textTheme,
                  City: "Islamabad",
                  Address:
                      "55 B Street, Block B2 Block B 2 Gulberg III, Lahore, Punjab 54000, Pakistan",
                  Phone: "+92-42-99263092, 94-96",
                  Mail: "info@Hec.gov.pk",
                  Photo: "https://i.dawn.com/primary/2019/12/5e018728b14d7.jpg",
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactContainer extends StatelessWidget {
  final String City;
  final String Address;
  final String Phone;
  final String Mail;
  final String Photo;
  const ContactContainer({
    required this.City,
    required this.Address,
    required this.Phone,
    required this.Mail,
    required this.Photo,
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200,
            child: Image.network(
              Photo,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            City,
            style: textTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                Address,
                softWrap: true,
              ))
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                Phone,
                softWrap: true,
              ))
            ],
          ),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        // launch("mailto:$Mail.com");
                      },
                      child: Text(Mail,
                          softWrap: true,
                          style:
                              TextStyle(decoration: TextDecoration.underline))))
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0, 3))
          ]),
    );
  }
}

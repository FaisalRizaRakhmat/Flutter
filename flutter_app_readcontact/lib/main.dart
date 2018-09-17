import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permissions/permissions.dart';
import 'dart:io' show Platform;


void main() => runApp(ContactsExampleApp());

class ContactsExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: <String, WidgetBuilder>{
      '/add': (BuildContext context) => AddContactPage()
    }, home: ContactListPage());
  }
}

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  Iterable<Contact> _contacts;
  Permission permission = Permission.ReadContacts;

  @override
  initState() {
    super.initState();
    if (Platform.isAndroid) {
      requestPermission();
    } else if (Platform.isIOS) {
      refreshContacts();
    }
  }


  refreshContacts() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contacts Plugin Example')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("/add").then((_) {
              refreshContacts();
            });
          }),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
          itemCount: _contacts?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            Contact c = _contacts?.elementAt(index);
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ContactDetailsPage(c)));
              },
              leading: (c.avatar != null && c.avatar.length > 0)
                  ? CircleAvatar(backgroundImage: MemoryImage(c.avatar))
                  : CircleAvatar(
                  child: Text(c.displayName.length > 1
                      ? c.displayName?.substring(0, 2)
                      : "")),
              title: Text(c.displayName ?? ""),
            );
          },
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  requestPermission() async {
    bool res = await Permissions.requestPermission(permission);
    print("permission request result is " + res.toString());
    if(res == true){
      refreshContacts();
    }
  }
}

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage(this._contact);
  final Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(title: Text(_contact.displayName ?? ""), actions: <Widget>[
          FlatButton(
              child: Icon(Icons.delete),
              onPressed: () {
                ContactsService.deleteContact(_contact);
              })
        ]),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ListTile(
                  title: Text("Name"),
                  trailing: Text(_contact.givenName ?? "")),
              ListTile(
                  title: Text("Middle name"),
                  trailing: Text(_contact.middleName ?? "")),
              ListTile(
                  title: Text("Family name"),
                  trailing: Text(_contact.familyName ?? "")),
              ListTile(
                  title: Text("Prefix"), trailing: Text(_contact.prefix ?? "")),
              ListTile(
                  title: Text("Suffix"), trailing: Text(_contact.suffix ?? "")),
              ListTile(
                  title: Text("Company"),
                  trailing: Text(_contact.company ?? "")),
              ListTile(
                  title: Text("Job"), trailing: Text(_contact.jobTitle ?? "")),
              AddressesTile(_contact.postalAddresses),
              ItemsTile("Phones", _contact.phones),
              ItemsTile("Emails", _contact.emails)
            ],
          ),
        ));
  }
}

class AddressesTile extends StatelessWidget {
  AddressesTile(this._addresses);
  final Iterable<PostalAddress> _addresses;

  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(title: Text("Addresses")),
          Column(
              children: _addresses
                  .map((a) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        title: Text("Street"),
                        trailing: Text(a.street)),
                    ListTile(
                        title: Text("Postcode"),
                        trailing: Text(a.postcode)),
                    ListTile(
                        title: Text("City"), trailing: Text(a.city)),
                    ListTile(
                        title: Text("Region"),
                        trailing: Text(a.region)),
                    ListTile(
                        title: Text("Country"),
                        trailing: Text(a.country)),
                  ],
                ),
              ))
                  .toList())
        ]);
  }
}

class ItemsTile extends StatelessWidget {
  ItemsTile(this._title, this._items);
  final Iterable<Item> _items;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(title: Text(_title)),
          Column(
              children: _items
                  .map((i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListTile(
                      title: Text(i.label ?? ""),
                      trailing: Text(i.value ?? ""))))
                  .toList())
        ]);
  }
}

class AddContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  Contact contact = Contact();
  PostalAddress address = PostalAddress(label: "Home");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a contact"),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                _formKey.currentState.save();
                contact.postalAddresses = [address];
                ContactsService.addContact(contact);
                Navigator.of(context).pop();
              },
              child: Icon(Icons.save, color: Colors.white))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                    decoration: const InputDecoration(labelText: 'First name'),
                    onSaved: (v) => contact.givenName = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Middle name'),
                    onSaved: (v) => contact.middleName = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Last name'),
                    onSaved: (v) => contact.familyName = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Prefix'),
                    onSaved: (v) => contact.prefix = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Suffix'),
                    onSaved: (v) => contact.suffix = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Phone'),
                    onSaved: (v) =>
                    contact.phones = [Item(label: "mobile", value: v)],
                    keyboardType: TextInputType.phone),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    onSaved: (v) =>
                    contact.emails = [Item(label: "work", value: v)],
                    keyboardType: TextInputType.emailAddress),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Company'),
                    onSaved: (v) => contact.company = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Job'),
                    onSaved: (v) => contact.jobTitle = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Street'),
                    onSaved: (v) => address.street = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'City'),
                    onSaved: (v) => address.city = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Region'),
                    onSaved: (v) => address.region = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Postal code'),
                    onSaved: (v) => address.postcode = v),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Country'),
                    onSaved: (v) => address.country = v),
              ],
            )),
      ),
    );
  }
}

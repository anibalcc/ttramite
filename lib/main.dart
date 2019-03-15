import 'dart:async';
import 'dart:convert';

import 'package:apktramite2019/src/widgets/tramite_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:apktramite2019/src/pages/lista_tramite_detalle.dart';

import 'package:http/http.dart' as http;

import 'package:apktramite2019/src/models/tramite.dart';

Future<List<Tramite>> fetchTramites(
    http.Client client, String nroExpediente) async {
  final _body = "Expediente=" + nroExpediente;
  final response = await client.post(
      "http://190.108.89.83/TramiteDocumentario2019/tramites/buscar_tramite_expediente/",
      body: _body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      encoding: Encoding.getByName("utf-8"));

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseTramites, response.body);
}

// A function that converts a response body into a List<Photo>
List<Tramite> parseTramites(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Tramite>((json) => Tramite.fromJson(json)).toList();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GORE CUSCO',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MySplash(
          title:
              'Tramite Documentario'), //MyHomePage(title: 'Tramite Documentario'),
    );
  }
}

class MySplash extends StatefulWidget {
  MySplash({Key key, this.title}) : super(key: key);

  final String title;
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Tramite Documentario'),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Colors.white, //Color.fromRGBO(128, 22, 39, 1), //Color(0XFFFF0000),
        body: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                //stops: [0.1, 0.5, 0.7, 0.9],
                stops: [0.1, 0.9],
                //colors: [Colors.blue[800],Colors.red[700],Colors.red[600],Color.fromRGBO(10, 10, 10, 1),],
                colors: [
                  Color.fromRGBO(166, 166, 166, 1),
                  Color.fromRGBO(241, 241, 242, 1),
                ],
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.asset("images/top.png"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset("images/logo.png", height: 200.0),
                      Text('TRAMITE DOCUMENTARIO',
                          style: TextStyle(
                              fontSize: 20.0,
                              //color: Colors.white,
                              color: Color.fromRGBO(193, 18, 37, 1),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Image.asset("images/botton.png", height: 250.0),
                    ],
                  )
                ]),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(title: 'Tramite Documentario'),
                ));
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //static List _buscarPor = ["NRO DE EXPEDIENTE", "NRO DE DOCUMENTO"];
  static List _buscarPor = ["NRO DE EXPEDIENTE"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedBuscar = _buscarPor[0];

  final _textNroExpedienteController = TextEditingController();

  final nroExpediente = "";

  @override
  void initState() {
    super.initState();

    _textNroExpedienteController.addListener(() {});

    _dropDownMenuItems = buildAndGetDropDownMenuItems(_buscarPor);
  }

  _update() {
    setState(() {});
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List bucarPor) {
    List<DropdownMenuItem<String>> items = new List();
    for (String nro in bucarPor) {
      items.add(
        new DropdownMenuItem(value: nro, child: Text(nro)),
      );
    }
    return items;
  }

  void changedDropDownItem(String selectedDoc) {
    setState(() {
      _selectedBuscar = selectedDoc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /*DropdownButton(
              value: _selectedBuscar,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
              style: Theme.of(context).textTheme.subtitle,
            ),
            Expanded(
              child: new Container(
                color: Colors.red,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      height: 50.0,
                      width: 50.0,
                    ),
                    new Text(
                      'jbijbibbib',
                    ),
                    new Text(
                      'author',
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: new EdgeInsets.all(0.7),
                margin: new EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45),
                  borderRadius: new BorderRadius.all(new Radius.circular(7.0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedBuscar,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem,
                  ),
                )),*/
            Container(
              padding: new EdgeInsets.all(0.7),
              margin: new EdgeInsets.all(15.0),
              color: Colors.white,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _textNroExpedienteController,
                onTap: () {},
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: 'NRO EXPEDIENTE',
                    helperText: 'Ingresar el Nro. de expediente',
                    //labelText: 'DEPENDENCIA',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    prefixText: ' '),
              ),
            ),
            Container(
                width: 120.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _update();
                    });
                  },
                  color: Color(0XFFFF0000),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1, // 20%
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            Text(
                              'BUSCAR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            /*RaisedButton(
              onPressed: () {
                setState(() {
                  _update();
                });
              },
              color: Color(0XFFFF0000),
              child: Row(
                children: <Widget>[
                  Text(
                    'Play this song',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _update();
                });
              },
            ),*/
            Expanded(
              child: FutureBuilder<List<Tramite>>(
                initialData: null,
                future: fetchTramites(
                    http.Client(), _textNroExpedienteController.text),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Press button to start.');
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return Text('Error: ${snapshot.error}');
                      return TramiteList(tramite: snapshot.data);
                  }
                  return null; // unreachable
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? TramiteList(tramite: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                  //: Center(child: Text('PROBLEMAS CON INTERNET'));
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: const Color(0xFFFFFFFF))),
        height: 40.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone_in_talk,
                      color: Colors.red[300],
                    ),
                    Center(
                      child: Text("+51 84 221131"),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_searching),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Center(
                      child: Text(
                        "Av Tomasa Ttio Condemayta S/N, Wanchaq, Cusco, Perú",
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class TramiteList extends StatelessWidget {
  final List<Tramite> tramite;

  TramiteList({Key key, this.tramite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        //margin: EdgeInsets.all(30),
        //color: Color.fromRGBO(205, 205, 205, 1), //Color(0xFF00FF00),
        child: ListView.builder(
          itemCount: tramite.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
                color: Color.fromRGBO(240, 240, 240, 1),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaTramiteDetallePage(
                                tramite[index].idTramiteDetalle)));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TramiteTextWidget("FECHA", tramite[index].fecha),
                        SizedBox(
                          height: 10.0,
                        ),
                        TramiteTextWidget(
                            "ORIGEN", tramite[index].nombreOrigen),
                        SizedBox(
                          height: 10.0,
                        ),
                        TramiteTextWidget(
                            "DESTINO", tramite[index].oficinaDestino),
                        TramiteTextWidget("ASUNTO", tramite[index].asunto),
                        SizedBox(
                          height: 10.0,
                        ),
                        TramiteTextWidget(
                            "TIPO DOC", tramite[index].tipoDocumento),
                        SizedBox(
                          height: 10.0,
                        ),
                        TramiteTextWidget(
                            "NRO DOC", tramite[index].nroDocumento),
                        SizedBox(
                          height: 10.0,
                        ),
                        TramiteTextWidget(
                            "ADJUNTO OTROS", tramite[index].adjuntoOtros),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'FECHA :',
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].fecha,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'ORIGEN :',
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].nombreOrigen,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'DESTINO :',
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].oficinaDestino,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.all(16.0),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: Text(
                        //           'ASUNTO :',
                        //           style: TextStyle(
                        //               fontSize: 12.0,
                        //               color: Colors.red,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //       ),
                        //       Flexible(
                        //         flex: 2,
                        //         fit: FlexFit.tight,
                        //         child: Text(
                        //           tramite[index].asunto,
                        //           style: TextStyle(
                        //             fontSize: 12.0,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'TIPO DOC. :',
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].tipoDocumento,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'NRO DOC. :',
                        //       style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].nroDocumento,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        /*Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'TIPO DOC. :',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    tramite[index].tipoDocumento,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'NRO DOC. :',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    tramite[index].nroDocumento,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),*/
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(
                        //       'ADJUNTO OTROS :',
                        //       style: TextStyle(
                        //           fontSize: 13.0,
                        //           color: Colors.red,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       tramite[index].adjuntoOtros,
                        //       style: TextStyle(
                        //         fontSize: 12.0,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        Container(
                          child: Center(
                              child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListaTramiteDetallePage(
                                                    tramite[index]
                                                        .idTramiteDetalle)));
                                  },
                                  color: Color(0XFFFF0000),
                                  child: Text('VER SEGUIMIENTO',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.0,
                                      )))
                              // child: Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     Flexible(
                              //       flex: 1,
                              //       fit: FlexFit.loose,
                              //       child: Row(
                              //         children: <Widget>[
                              //           RaisedButton(
                              //               onPressed: () {
                              //                 Navigator.push(
                              //                     context,
                              //                     MaterialPageRoute(
                              //                         builder: (context) =>
                              //                             ListaTramiteDetallePage(
                              //                                 tramite[index]
                              //                                     .idTramiteDetalle)));
                              //               },
                              //               color: Color(0XFFFF0000),
                              //               child: Text('VER SEGUIMIENTO',
                              //                   style: TextStyle(
                              //                     color: Colors.white,
                              //                     fontSize: 9.0,
                              //                   )))
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              ),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}

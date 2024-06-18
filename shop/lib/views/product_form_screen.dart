import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool _isLoading = false;

  void _updateImageUrl() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startsWithHttp = url.toLowerCase().startsWith('http://');
    bool startsWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startsWithHttp || startsWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_formData.isEmpty) {
      final product = ModalRoute.of(context)?.settings.arguments as Product?;

      if (product != null) {
        _formData['id'] = product.id!;
        _formData['title'] = product.title;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = _formData['imageUrl'] as String;
      } else {
        _formData['price'] = '';
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _form.currentState?.save();
    final product = Product(
      id: _formData['id'] as String?,
      title: _formData['title'] as String,
      price: _formData['price'] as double,
      description: _formData['description'] as String,
      imageUrl: _formData['imageUrl'] as String,
    );

    setState(() {
      _isLoading = true;
    });

    final products = Provider.of<Products>(context, listen: false);
    if (_formData['id'] == null) {
      // products.addProduct(product).catchError(
      //   (error) {
      //     return showDialog<Null>(
      //       context: context,
      //       builder: (ctx) => AlertDialog(
      //         title: Text("Ocorreu um erro"),
      //         //error.toString()
      //         content: Text("Ocorreu um erro ao salvar o produto"),
      //         actions: [
      //           ElevatedButton(
      //             onPressed: () => Navigator.of(context).pop(),
      //             child: Text('Ok'),
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ).then((_) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // });

      try {
        await products.addProduct(product);
        Navigator.of(context).pop();
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Ocorreu um erro"),
            //error.toString()
            content: Text("Ocorreu um erro ao salvar o produto"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'),
              ),
            ],
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      products.updateProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['title'] as String? ?? "",
                      decoration: InputDecoration(labelText: 'Título'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      onSaved: (value) => _formData['title'] = value!,
                      validator: (value) {
                        bool isEmpty = value?.trim().isEmpty ?? true;
                        bool isInvalid = (value ?? "").trim().length < 3;
                        if (isEmpty || isInvalid) {
                          return 'Informe um título válido com no mínimo 3 caracteres';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocusNode,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) =>
                          _formData['price'] = double.parse(value!),
                      validator: (value) {
                        bool isEmpty = value?.trim().isEmpty ?? true;
                        double? newPrice = double.tryParse(value ?? "");
                        bool isInvalid = newPrice == null || newPrice <= 0;
                        if (isEmpty || isInvalid) {
                          return 'Informe um preço valido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'] as String?,
                      decoration: InputDecoration(labelText: 'Descrição'),
                      maxLines: 3,
                      focusNode: _descriptionFocusNode,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) => _formData['description'] = value!,
                      validator: (value) {
                        bool isEmpty = value?.trim().isEmpty ?? true;
                        bool isInvalid = (value ?? "").trim().length < 10;
                        if (isEmpty || isInvalid) {
                          return 'Informe uma descrição válida com no mínimo 10 caracteres';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'URL da imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocusNode,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) => _formData['imageUrl'] = value!,
                            validator: (value) {
                              bool isEmpty = value?.trim().isEmpty ?? true;
                              bool isInvalid = !isValidImageUrl(value ?? "");
                              if (isEmpty || isInvalid) {
                                return 'Informe uma URL válida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(top: 8, left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text('Informe a URL')
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

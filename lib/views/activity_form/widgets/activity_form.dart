import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/providers/city_provider.dart';
import 'package:travel_app/views/activity_form/widgets/activity_form_image_picker.dart';

import '../../../models/activity_model.dart';

class ActivityForm extends StatefulWidget {

  final String cityName;

  const ActivityForm({Key? key, required this.cityName}) : super(key: key);

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  late Activity newActivity;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String? nameInputAsync;
  late FocusNode priceFocusNode;
  late FocusNode urlFocusNode;
  bool isLoading = false;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    priceFocusNode = FocusNode();
    urlFocusNode = FocusNode();
    nameInputAsync = null;
    newActivity = Activity(name: "", city: widget.cityName, image: null, price: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    priceFocusNode.dispose();
    urlFocusNode.dispose();
    super.dispose();
  }

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }

  FormState get form => formKey.currentState!;


  void submitForm() async {
    CityProvider cityProvider = Provider.of<CityProvider>(context, listen: false);

    form.save();
// save active tout les onsave de chaque field
    setState(() {isLoading = true;});

    nameInputAsync = await cityProvider.verifyNameActivity(widget.cityName, newActivity.name);

    try{
      if(form.validate()){
        cityProvider.addActivityToCity(newActivity).then((_) => Navigator.pop(context));
      }else{
        setState(() {
          isLoading = false;
        });
      }
    }catch(e){
      setState(() {
        isLoading = false;
      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true, //met le focus automatique sur linput
                decoration: const InputDecoration(
                  labelText: "Nom",
                ),
                onSaved: (value) => newActivity.name = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Remplissez le nom';
                    }
                    else if(nameInputAsync != null){
                      return 'nom existe deja';
                    }
                    return null;
                  },
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(priceFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                focusNode: priceFocusNode,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Prix",
                ),
                  onSaved: (value) => newActivity.price = double.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Remplissez le prix';
                  }
                  return null;
                },
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(urlFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                focusNode: urlFocusNode,
                keyboardType: TextInputType.url,
                controller: _urlController,
                onFieldSubmitted: (_){
                  submitForm();
                },
                decoration: const InputDecoration(
                  labelText: "Url",
                ),
                  onSaved: (value) => newActivity.image = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Remplissez l\'URL';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10,),
              ActivityFormImagePicker(updateUrl: updateUrlField,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Annuler")),
                  ElevatedButton(onPressed: isLoading ? null : submitForm, child: const Text("Sauvegarder"))
                ],
              )
            ],
          )
      ),
    );
  }
}

String? validateSystolic(String? value) {
  if (value == null || value.isEmpty) {
    return 'Systolic Cant be null';
  } else if (int.parse(value) <= 0) {
    return 'Systolic Cant Be Less Than Less Than  or Equal To 0';
  } else if (int.parse(value) > 999) {
    return 'Systolic Cant Be Greater Than 999';
  } else {
    return null;
  }
}

String? validateDiastolic(String? value) {
  if (value == null || value.isEmpty) {
    return 'Diastolic Cant be null';
  } else if (int.parse(value) <= 0) {
    return 'Diastolic Cant Be Less Than Less Than  or Equal To 0';
  } else if (int.parse(value) > 999) {
    return 'Diastolic Cant Be Greater Than 999';
  } else {
    return null;
  }
}

String? validatePulse(String? value) {
  if (value == null || value.isEmpty) {
    return 'Pulse Cant be null';
  } else if (int.parse(value) <= 0) {
    return 'Pulse Cant Be Less Than  or Equal To 0' ;
  } else if (int.parse(value) > 999) {
    return 'Pulse Cant Be Greater Than 999';
  } else {
    return null;
  }
}


String? validateNote(String? value) {
if(value!.length>100){
return "Note Cannot Longet than 1000 word";
}  
    return null;
}



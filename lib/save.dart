import 'package:debitpad/respositary.dart';

class Categoryservice {
  Respositary? _respositary;

  Categoryservice() {
    _respositary = Respositary();
  }

  ///create data
  save(Catagory catagory) async {
    return await _respositary!.insertData('categories', catagory.categorymap());
  }

  ///read data frome table
  readbashakan() async {
    return await _respositary!.readData('categories');
  }

  readcategoryId(categoryId) async {
    return await _respositary!.readdatabyId('categories', categoryId);
  }

  ///update data from table
  updatebashakan(Catagory catagory) async {
    return await _respositary!.updateData('categories', catagory.categorymap());
  }

  ///delete data from table
  deletebashakan(idbashakan) async {
    return await _respositary!.deleteData('categories', idbashakan);
  }

  ///search
  searchbashakan(keyword) async {
    return await _respositary!.searchdata('categories', keyword);
  }
}

//   save(Catagory categ) async {
//     return await _respositary!.insertData('categories', categ.categorymap());
//   }
// }

class Catagory {
  int? id;
  String name = '';
  int? date;
  String qarz = '';
  int? enddate;
  String tebyny = '';
  String? image;
  String phonenumber = '';
  String wargr = '';
  String kafyl = '';
  String jorypara = '';

  categorymap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['date'] = date;
    mapping['enddate'] = enddate;
    mapping['qarz'] = qarz;
    mapping['tebyny'] = tebyny;
    mapping['image'] = image;
    mapping['phonenumber'] = phonenumber;
    mapping['wargr'] = wargr;
    mapping['kafyl'] = kafyl;
    mapping['jorypara'] = jorypara;

    return mapping;
  }
}

class Catagory_user {
  int? id;
  String name = '';
  int? date;
  String qarz = '';
  String tebyny = '';
  String phonenumber = '';
  String jorypara = '';
  String wargrtwnpedan = '';
  int? userid;

  categorymap_user() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['userid'] = userid;
    mapping['date'] = date;
    mapping['qarz'] = qarz;
    mapping['tebyny'] = tebyny;
    mapping['phonenumber'] = phonenumber;
    mapping['jorypara'] = jorypara;
    mapping['wargrtwnpedan'] = wargrtwnpedan;
    return mapping;
  }
}

class Categoryservice_user {
  Respositary_user? _respositary_user;

  Categoryservice_user() {
    _respositary_user = Respositary_user();
  }

  ///create data
  save(Catagory_user catagory) async {
    return await _respositary_user!
        .insertData('categoriesuser', catagory.categorymap_user());
  }

  ///read data frome table
  readbashakan() async {
    return await _respositary_user!.readData('categoriesuser');
  }

  readcategoryId(categoryId) async {
    return await _respositary_user!.readdatabyId('categoriesuser', categoryId);
  }

  ///update data from table
  updatebashakan(Catagory_user catagory) async {
    return await _respositary_user!
        .updateData('categoriesuser', catagory.categorymap_user());
  }

  ///delete data from table
  deletebashakan(idbashakan) async {
    return await _respositary_user!.deleteData('categoriesuser', idbashakan);
  }

  ///search
  searchbashakan(keyword) async {
    return await _respositary_user!.searchdata('categoriesuser', keyword);
  }
}

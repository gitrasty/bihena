import 'package:debitpad/store/database/respositary_store.dart';

class Catagory_store {
  int? id;
  String name = '';
  int? date;
  String nrx = '';
  String namecompany = '';
  String phonenumber_company = '';
  String jorypara = '';
  String nrxy_froshtn = '';
  int? barcode;
  categorymap_store() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['date'] = date;
    mapping['nrx'] = nrx;
    mapping['namecompany'] = nrx;
    mapping['barcode'] = barcode;
    mapping['phonenumbercompany'] = phonenumber_company;
    mapping['jorypara'] = jorypara;
    mapping['nrxyfroshtn'] = nrxy_froshtn;

    return mapping;
  }
}

class Categoryservice_store {
  Respositary_store? _respositary_store;

  Categoryservice_store() {
    _respositary_store = Respositary_store();
  }

  ///create data
  save(Catagory_store catagory) async {
    return await _respositary_store!
        .insertData('store', catagory.categorymap_store());
  }

  ///read data frome table
  readbashakan() async {
    return await _respositary_store!.readData('store');
  }

  readcategoryId(categoryId) async {
    return await _respositary_store!.readdatabyId('store', categoryId);
  }

  ///update data from table
  updatebashakan(Catagory_store catagory) async {
    return await _respositary_store!
        .updateData('store', catagory.categorymap_store());
  }

  ///delete data from table
  deletebashakan(idbashakan) async {
    return await _respositary_store!.deleteData('store', idbashakan);
  }

  ///search
  searchbashakan(keyword) async {
    return await _respositary_store!.searchdata('store', keyword);
  }
}

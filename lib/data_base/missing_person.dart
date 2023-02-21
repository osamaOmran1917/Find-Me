class MissingPerson {
  static const String collectionName = 'Missing Person';
  String? id,
      name,
      adress,
      desc,
      age,
      gov,
      posterId,
      posterName,
      image,
      loseDate,
      findingDate;
  DateTime? dateTime;
  bool? reachedToFamily, foundPerson;

  MissingPerson(
      {this.id,
      this.name,
      this.adress,
      this.desc,
      this.age,
      this.gov,
      this.dateTime,
      this.reachedToFamily,
      this.image,
      this.loseDate,
      this.findingDate,
      this.posterId,
      this.posterName,
      this.foundPerson});

  MissingPerson.fromFirestore(Map<String, dynamic> data)
      : this(
      id: data['id'],
            name: data['name'],
            adress: data['adress'],
            desc: data['desc'],
            age: data['age'],
            gov: data['gov'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(data['dateTime']),
            reachedToFamily: data['reachedToFamily'],
            image: data['image'],
            loseDate: data['loseDate'],
            findingDate: data['findingDate'],
            posterId: data['posterId'],
            posterName: data['posterName'],
            foundPerson: data['foundPerson']);

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'adress': adress,
      'desc': desc,
      'age': age,
      'gov': gov,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'reachedToFamily': reachedToFamily,
      'image': image,
      'loseDate': loseDate,
      'findingDate': findingDate,
      'posterId': posterId,
      'posterName': posterName,
      'foundPerson': foundPerson
    };
  }
}

class CollectionUtil {}

extension IterableExt<E> on Iterable<E> {
  Map<T, List<E>> groupBy<T>(T f(E e)) {
    Map<T, List<E>> mapResult = Map<T, List<E>>();
    forEach((element) {
      T t = f(element);
      var list = mapResult[t] ?? List<E>();
      list.add(element);
      mapResult[t] = list;
    });
    return mapResult;
  }

  Map<K, V> toMap<K, V>(K keySelector(E e), V valueTransform(E e)) {
    Map<K, V> result = {};
    forEach((element) {
      K k = keySelector(element);
      if (result.containsKey(k)) {
        throw Exception("Key exist");
      }
      return result[keySelector(element)] = valueTransform(element);
    });
    return result;
  }

  E elementAtOrNull(int index) {
    if (index < 0 || length <= index) return null;
    return elementAt(index);
  }

  E firstOrNull(bool f(E e)) {
    for (var value in this) {
      if (f(value)) return value;
    }
    return null;
  }

  E lastOrNull(bool f(E e)) {
    for (int i = this.length - 1; i >= 0; i--) {
      E ee = this.elementAt(i);
      if (f(ee)) return ee;
    }
    return null;
  }

  List<E> filter(bool f(E e)) {
    var result = <E>[];
    for (var value in this) {
      if (f(value)) result.add(value);
    }
    return result;
  }

  void forIndex(f(E e, int index)) {
    for (int i = 0; i < this.length; i++) {
      f(elementAt(i), i);
    }
  }

  E maxBy<R extends Comparable>(R f(E e)) {
    if (this.isEmpty) return null;
    E result = elementAt(0);
    R max = f(result);
    forEach((element) {
      R r = f(element);
      int i = max.compareTo(r);
      if (i < 0) {
        max = r;
        result = element;
      }
    });
    return result;
  }

  E minBy<R extends Comparable>(R f(E e)) {
    if (this.isEmpty) return null;
    E result = elementAt(0);
    R max = f(result);
    forEach((element) {
      R r = f(element);
      int i = max.compareTo(r);
      if (i > 0) {
        max = r;
        result = element;
      }
    });
    return result;
  }

  num sumBy(num f(E e)) {
    num r = 0;
    this.forEach((element) => r += f(element));
    return r;
  }
}

extension MapExt<K, V> on Map<K, V> {
  bool containsAll(Map target) {
    var result = true;
    target.forEach((targetKey, targetValue) {
      if (!this.containsKey(targetKey) || this[targetKey] != targetValue) {
        result = false;
        return;
      }
    });
    return result;
  }
}

extension StringExt on String {
  int toInt() => int.tryParse(this);
  double toDouble() => double.tryParse(this);
}

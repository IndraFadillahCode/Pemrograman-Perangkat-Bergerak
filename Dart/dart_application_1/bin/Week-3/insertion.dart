void insertionSort(List<int> arr) {
  for (int i = 1; i < arr.length; i++) {
    int key = arr[i];
    int j = i - 1;
    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j = j - 1;
    }
    arr[j + 1] = key;
  }
}

void main() {
  List<int> arr = [12, 9, 13, 5, 6];
  insertionSort(arr);
  print('Sorted array: $arr');
}

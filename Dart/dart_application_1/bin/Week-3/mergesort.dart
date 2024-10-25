void merge(List<int> arr, int left, int mid, int right) {
  int n1 = mid - left + 1;
  int n2 = right - mid;

  List<int> L = List.filled(n1, 0);
  List<int> R = List.filled(n2, 0);

  for (int i = 0; i < n1; i++) {
    L[i] = arr[left + i];
  }
  for (int j = 0; j < n2; j++) {
    R[j] = arr[mid + 1 + j];
  }

  int i = 0, j = 0;
  int k = left;
  while (i < n1 && j < n2) {
    if (L[i] <= R[j]) {
      arr[k] = L[i];
      i++;
    } else {
      arr[k] = R[j];
      j++;
    }
    k++;
  }

  while (i < n1) {
    arr[k] = L[i];
    i++;
    k++;
  }

  while (j < n2) {
    arr[k] = R[j];
    j++;
    k++;
  }
}

void mergeSort(List<int> arr, int left, int right) {
  if (left < right) {
    int mid = (left + right) ~/ 2;
    mergeSort(arr, left, mid);
    mergeSort(arr, mid + 1, right);
    merge(arr, left, mid, right);
  }
}

void main() {
  List<int> arr = [12, 11, 13, 5, 6, 7];
  mergeSort(arr, 0, arr.length - 1);
  print('Sorted array: $arr');
}
